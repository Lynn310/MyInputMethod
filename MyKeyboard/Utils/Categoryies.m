//
//  Categories.m
//  Categories
//
//  Created by luowei on 15/8/11.
//  Copyright (c) 2015年 luowei. All rights reserved.
//

#import "Categories.h"
#import "MyKeyboardViewController.h"

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


@implementation UIView (FindUIViewController)

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

//获得MyKeyboardViewController
- (MyKeyboardViewController *)responderKBViewController {
    UIResponder *responder = self;
    while (![responder isKindOfClass:[MyKeyboardViewController class]]) {
        responder = [responder nextResponder];
        if (nil == responder) {
            break;
        }
    }
    return (MyKeyboardViewController *)responder;
}

//获得指class类型的父视图
-(id)superViewWithClass:(Class)clazz{
    UIResponder *responder = self;
    while (![responder isKindOfClass:clazz]) {
        responder = [responder nextResponder];
        if (nil == responder) {
            break;
        }
    }
    return responder;
}

@end


@implementation UIView (Rotation)

//递归的向子视图发送屏幕发生旋转了的消息
- (void)rotationToInterfaceOrientation:(UIInterfaceOrientation)orientation {
    for (UIView *v in self.subviews) {
        [v rotationToInterfaceOrientation:orientation];
    }
}

@end

@implementation UIView (NoScrollToTop)

- (void)subViewNOScrollToTopExcludeClass:(Class)clazz {

    for (UIView *v in self.subviews) {
        if ([v isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scrollView = (UIScrollView *) v;
            scrollView.scrollsToTop = clazz == nil ? NO : [v isKindOfClass:clazz];
        }
        [v subViewNOScrollToTopExcludeClass:clazz];
    }
}

@end

@implementation UIView(updateAppearance)

-(void)updateAppearance{

    for(UIView *v in self.subviews){
        [v updateAppearance];
    }

}

@end