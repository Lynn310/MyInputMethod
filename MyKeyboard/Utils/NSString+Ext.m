//
//  NSString+Ext.m
//  MyInputMethod
//
//  Created by luowei on 15/8/11.
//  Copyright (c) 2015年 luowei. All rights reserved.
//

#import "NSString+Ext.h"

@implementation NSString (Ext)

- (CGFloat)widthWithFont:(UIFont *)font andAttributes:(NSDictionary *)attributes {
    return [[[NSAttributedString alloc] initWithString:self attributes:attributes] size].width;
}

- (CGFloat)heigthWithWidth:(CGFloat)width andFont:(UIFont *)font andAttributes:(NSDictionary *)attributes{

    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:self attributes:attributes];
    CGRect rect = [attrStr boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    return rect.size.height;
}

@end
