//
//  LWDataConfig.h
//  MyInputMethod
//  用于维护与主程序通信相关的配置或初始化的数据
//  Created by luowei on 15/7/28.
//  Copyright (c) 2015 luowei. All rights reserved.
//



#import <UIKit/UIKit.h>

@interface LWDataConfig : NSObject

//根据plistName从document中或bundle中读取plist
+ (NSDictionary *)dictionaryFromPlistName:(NSString *)plistName;

//根据fName与fType从document中或bundle中读取
+ (NSString *)getTextWithFilePrefix:(NSString *)fName fType:(NSString *)fType;

//获得Phrase数据
+ (NSDictionary *)getPhraseDictionary;

//获得Emoji数据
+ (NSDictionary *)getEmojiDictionary;

//获得Emoji数据
+ (NSDictionary *)getEmoticonDictionary;

//获得Graphic数据
+ (NSDictionary *)getGraphicPlistDictionary;

/**
* 获得键盘的皮肤
*/
+ (UIImage *)keyboardSkin;

//根据名字从Doc中获得一张键盘背景图
+ (UIImage *)getKBImgFromDoc:(NSString *)imgName;

//获得popView的背景色
+(UIColor *)getPopViewBackGroundColor;


#pragma mark - UserDefault数据操作

//根据key从UserDefault中取得一个Array,若取不到,使用默认值
+ (NSMutableArray *)getArrByKey:(NSString *)key withDefaultArr:(NSArray *)defaultArr;

//根据key设置一个Array
+(void)setArr:(NSArray *)arr WithKey:(NSString *)key;

//根据Key获得颜色值
+ (UIColor *)getColorWithKey:(NSString *)key;

//从UserDefault中取值
+(id)getUserDefaultValueByKey:(NSString *)key;

//向UserDefault设置值
+(void)setUserDefaultValue:(id)value withKey:(NSString *)key;

@end
