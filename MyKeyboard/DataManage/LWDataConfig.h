//
//  LWDataConfig.h
//  MyInputMethod
//  用于维护与主程序通信相关的配置或初始化的数据
//  Created by luowei on 15/7/28.
//  Copyright (c) 2015 luowei. All rights reserved.
//



#import <Foundation/Foundation.h>

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

@end
