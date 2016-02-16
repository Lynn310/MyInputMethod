//
//  LWThemeManager.h
//  MyInputMethod
//
//  Created by luowei on 15/8/18.
//  Copyright (c) 2015年 luowei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWThemeManager : NSObject

@property(nonatomic, strong) NSDictionary *theme;

+ (LWThemeManager *)sharedInstance;

//根据Key获得颜色值
+ (UIColor *)getColorWithKey:(NSString *)key;

@end
