//
//  LWDataConfig.m
//  MyInputMethod
//
//  Created by luowei on 15/7/28.
//  Copyright (c) 2015 luowei. All rights reserved.
//

#import "LWDataConfig.h"
#import "Categories.h"
#import "LWKeyboardConfig.h"
#import "UIImage+Color.h"
#import "UIColor+CrossFade.h"

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

/**
* 获得键盘的皮肤
*/
+ (UIImage *)keyboardSkin {
    NSString *kbBg = StringValueFromThemeKey(@"inputView.backgroundImage");
    UIImage *image = nil;
    if(![kbBg isEqualToString:@""]){
        image = [self getKBImgFromDoc:kbBg];
    }
    return image;
}

//根据名字从Doc中获得一张键盘背景图
+ (UIImage *)getKBImgFromDoc:(NSString *)imgName {
    NSString *suffix = [imgName substringFromIndex:imgName.length - 4];
    if(![suffix isEqualToString:@".png"]){
        imgName = [NSString stringWithFormat:@"%@.png",imgName];
    }

    UIImage *image = nil;//根据表情字符串从指定路径读取图片
    NSString *graphicPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"InputBgImg"];
    NSString *filePath = [graphicPath stringByAppendingPathComponent:imgName];

    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:filePath]) {
        image = [UIImage imageWithContentsOfFile:filePath];
    }
    return image;
}

//获得popView的背景色
+(UIColor *)getPopViewBackGroundColor{
    UIColor *firstColor = nil;
    UIColor *secondColor = UIColorValueFromThemeKey(@"font.Color");

    UIImage *keyboardSkin = [LWDataConfig keyboardSkin];
    if (keyboardSkin) { //图片
        return keyboardSkin.averageColor;
    }else{      //颜色
        firstColor = UIColorValueFromThemeKey(@"inputView.backgroundColor");
        return [UIColor colorBetweenFirstColor:firstColor secondColor:secondColor atRatio:0.2 withAlpha:1.0];
    }
}

@end
