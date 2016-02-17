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

//根据Key获得颜色值
+ (UIColor *)getColorWithKey:(NSString *)key;

//根据key取得一个Array,若取不到,使用默认值
+ (NSMutableArray *)getArrByKey:(NSString *)key withDefaultArr:(NSArray *)defaultArr;

//根据key设置一个Array
+(void)setArr:(NSArray *)arr WithKey:(NSString *)key;

@end
