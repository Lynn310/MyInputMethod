//
//  Categories.m
//  Categories
//
//  Created by luowei on 15/8/11.
//  Copyright (c) 2015年 luowei. All rights reserved.
//

#import "Categories.h"

@implementation NSDictionary(Ini)

//解析Emoji表情ini文件字符串
+(NSDictionary *)dictFromEmoticonIni:(NSString *)iniString{
    NSMutableDictionary *iniDict = @{}.mutableCopy;
    
    NSString *section = nil;
    for (NSString *line in [iniString componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]]) {
        if(!line || [[line stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]){
            continue;
        }
        
        NSRange startChar = [line rangeOfString:@"["];
        NSRange endChar = [line rangeOfString:@"]"];
        
        if (startChar.location != NSNotFound && endChar.location != NSNotFound && endChar.location > startChar.location) {
            section = [line substringWithRange:NSMakeRange(startChar.location+1, endChar.location-(startChar.location+1))];
        }else{
            NSArray *split = [line componentsSeparatedByString:@"  "];
            iniDict[section] = split?split:[NSNull new];
        }
    }
    
    return iniDict;
}


@end


@interface UIView (FindUIViewController)

- (UIViewController *)responderViewController {
    UIResponder *responder = self;
    while (![responder isKindOfClass:[UIViewController class]]) {
        responder = [responder nextResponder];
        if (nil == responder) {
            break;
        }
    }
    return (UIViewController *)responder;
}

@end