//
//  LWDataConfig.m
//  MyInputMethod
//
//  Created by luowei on 15/7/28.
//  Copyright (c) 2015 luowei. All rights reserved.
//

#import "LWDataConfig.h"
#import "Categories.h"

@implementation LWDataConfig

//根据plistName从document中或bundle中读取plist
+ (NSDictionary *)dictionaryFromPlistName:(NSString *)plistName {
    NSString *bundleFilePath = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];

    NSFileManager *fmanager = [NSFileManager defaultManager];
    NSString *documentsDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *docFilePath = [documentsDirectory stringByAppendingPathComponent:plistName];

    //在Document是不存在
    if (![fmanager fileExistsAtPath:docFilePath]) {
        //先拷贝Bundle里下的到document目录下
        NSError *error;
        [fmanager copyItemAtPath:bundleFilePath toPath:docFilePath error:&error];
        if (error) {
            //从bundle中读取
            return [NSDictionary dictionaryWithContentsOfFile:bundleFilePath].mutableCopy;
        }
    }
    //从document中读取
    return [NSDictionary dictionaryWithContentsOfFile:docFilePath].mutableCopy;
}

//根据fName与fType从document中或bundle中读取
+ (NSString *)getTextWithFilePrefix:(NSString *)fName fType:(NSString *)fType {
    NSString *text;
    NSString *bundleFilePath = [[NSBundle mainBundle] pathForResource:fName ofType:fType];
    NSFileManager *fmanager = [NSFileManager defaultManager];
    NSString *documentsDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *docFilePath = [documentsDirectory stringByAppendingPathComponent:fName];

    //在Document是不存在
    if (![fmanager fileExistsAtPath:docFilePath]) {
        //先拷贝Bundle里下的到document目录下
        NSError *error;
        [fmanager copyItemAtPath:bundleFilePath toPath:docFilePath error:&error];
        if (error) {
            //从bundle中读取
            return [NSString stringWithContentsOfFile:bundleFilePath encoding:NSUTF8StringEncoding error:nil];
        }
    }
    return [NSString stringWithContentsOfFile:docFilePath encoding:NSUTF8StringEncoding error:nil];
}


//获得Phrase数据
+ (NSDictionary *)getPhraseDictionary {
    return [LWDataConfig dictionaryFromPlistName:@"phrase"];
}

//获得Graphic数据
+ (NSDictionary *)getGraphicPlistDictionary {
    return [LWDataConfig dictionaryFromPlistName:@"graphics"];
}


//获得Emoji数据
+ (NSDictionary *)getEmojiDictionary {
    NSString *text = [LWDataConfig getTextWithFilePrefix:@"emoji" fType:@"ini"];
    NSDictionary *iniDict = [NSDictionary dictFromEmoticonIni:text];
    return iniDict;
}

//获得Emoticon数据
+ (NSDictionary *)getEmoticonDictionary {
    NSString *text = [LWDataConfig getTextWithFilePrefix:@"emoticon" fType:@"ini"];
    NSDictionary *iniDict = [NSDictionary dictFromEmoticonIni:text];
    return iniDict;
}

@end
