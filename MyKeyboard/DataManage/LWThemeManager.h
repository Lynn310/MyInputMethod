//
//  LWThemeManager.h
//  MyInputMethod
//
//  Created by luowei on 15/8/18.
//  Copyright (c) 2015年 luowei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LWThemeManager : NSObject

@property(nonatomic, strong) NSDictionary *theme;

+ (LWThemeManager *)sharedInstance;

@end
