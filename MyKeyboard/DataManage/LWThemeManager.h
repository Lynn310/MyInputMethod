//
//  LWThemeManager.h
//  MyInputMethod
//
//  Created by luowei on 15/8/18.
//  Copyright (c) 2015年 luowei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWThemeManager : NSObject

@property(nonatomic, strong) NSMutableDictionary *theme;

//把theme数据保存到文件
-(void)setThemeValue:(id)value forKey:(NSString *)key;

+ (LWThemeManager *)sharedInstance;

@end
