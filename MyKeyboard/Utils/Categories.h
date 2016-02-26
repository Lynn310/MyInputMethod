//
//  Categories.h
//  Categories
//
//  Created by luowei on 15/8/11.
//  Copyright (c) 2015年 luowei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSDictionary(Ini)

//解析Emoji表情ini文件字符串
+(NSDictionary *)dictFromEmoticonIni:(NSString *)iniString;

@end

@interface UIView (FindUIViewController)

//获得一个View的响应ViewController
- (UIViewController *)responderViewController;

@end