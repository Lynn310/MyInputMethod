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

@end
