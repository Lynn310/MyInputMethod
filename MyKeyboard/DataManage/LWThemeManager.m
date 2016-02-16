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

        NSString *path = [[NSBundle mainBundle] pathForResource:themeName ofType:@"plist"];
        self.theme = [NSDictionary dictionaryWithContentsOfFile:path];
    }
    return self;

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
    }else{
        normalColor = (UIColor *) [NSKeyedUnarchiver unarchiveObjectWithData:dat];
    }
    return normalColor;
}


@end
