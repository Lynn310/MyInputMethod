//
//  LWThemeManager.m
//  MyInputMethod
//
//  Created by luowei on 15/8/18.
//  Copyright (c) 2015年 luowei. All rights reserved.
//

#import "LWThemeManager.h"

@implementation LWThemeManager

+ (LWThemeManager *)sharedInstance {
    static LWThemeManager *sharedInstance = nil;
    if (sharedInstance == nil) {
        sharedInstance = [[LWThemeManager alloc] init];
    }
    return sharedInstance;
}

- (id)init {
    if ((self = [super init])) {

        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *themeName = [defaults objectForKey:@"theme"] ?: @"SkinableTheme";

        NSString *bundleFilePath = [[NSBundle mainBundle] pathForResource:themeName ofType:@"plist"];

        NSFileManager *fmanager = [NSFileManager defaultManager];
        NSString *documentsDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString *docFilePath = [documentsDirectory stringByAppendingPathComponent:themeName];

        //在Document是不存在
        if (![fmanager fileExistsAtPath:docFilePath]) {
            //先拷贝Bundle里下的到docment目录下
            NSError *error;
            [fmanager copyItemAtPath:bundleFilePath toPath:docFilePath error:&error];
            if (error) {
                self.theme = [NSDictionary dictionaryWithContentsOfFile:bundleFilePath].mutableCopy;
            }
        }
        self.theme = [NSDictionary dictionaryWithContentsOfFile:docFilePath].mutableCopy;

    }
    return self;

}

//把theme数据保存到文件
-(void)setThemeValue:(id)value forKey:(NSString *)key{
    [[LWThemeManager sharedInstance].theme setValue:value forKey:key];
    [self writeThemeToDoc];
}

//把theme数据写入到docment的文件中
-(void)writeThemeToDoc{

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *themeName = [defaults objectForKey:@"theme"] ?: @"SkinableTheme";

    NSString *bundleFilePath = [[NSBundle mainBundle] pathForResource:themeName ofType:@"plist"];

    NSString *documentsDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *docFilePath = [documentsDirectory stringByAppendingPathComponent:themeName];
    [self.theme writeToFile:docFilePath atomically:YES];
}

//根据Key获得颜色值
+ (UIColor *)getColorWithKey:(NSString *)key {
    UIColor *normalColor = nil;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *dat = [userDefaults objectForKey:key];
    if (!dat) {
        normalColor = [UIColor darkGrayColor];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:normalColor];
        [userDefaults setObject:data forKey:key];
        [userDefaults synchronize];
    } else {
        normalColor = (UIColor *) [NSKeyedUnarchiver unarchiveObjectWithData:dat];
    }
    return normalColor;
}


//根据key取得一个Array,若取不到,使用默认值
+ (NSMutableArray *)getArrByKey:(NSString *)key withDefaultArr:(NSArray *)defaultArr {
    NSMutableArray *skins = nil;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *dat = [userDefaults objectForKey:key];
    if (dat == nil) {
        skins = defaultArr.mutableCopy;
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:skins];
        [userDefaults setObject:data forKey:key];
        [userDefaults synchronize];
    } else {
        skins = ((NSArray *) [NSKeyedUnarchiver unarchiveObjectWithData:dat]).mutableCopy;
    }
    return skins;
}

//根据key设置一个Array
+ (void)setArr:(NSArray *)arr WithKey:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arr];
    [userDefaults setObject:data forKey:key];
    [userDefaults synchronize];
}

@end
