//
//  LWThemeManager.m
//  MyInputMethod
//
//  Created by luowei on 15/8/18.
//  Copyright (c) 2015年 luowei. All rights reserved.
//

#import "LWThemeManager.h"
#import "LWDefines.h"

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
        NSString *themeName = [defaults objectForKey:Key_Theme] ?: @"defaultTheme";

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
                return self;
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
    NSString *themeName = [defaults objectForKey:Key_Theme] ?: @"defaultTheme";

    //NSString *bundleFilePath = [[NSBundle mainBundle] pathForResource:themeName ofType:@"plist"];

    NSString *documentsDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *docFilePath = [documentsDirectory stringByAppendingPathComponent:themeName];
    [self.theme writeToFile:docFilePath atomically:YES];
}


@end
