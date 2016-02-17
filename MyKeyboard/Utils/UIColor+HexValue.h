//
//  UIColor+HexValue.h
//  MyInputMethod
//
//  Created by luowei on 15/7/28.
//  Copyright (c) 2015 luowei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexValue)

+ (UIColor *)colorWithRGBAString:(NSString *)RGBAString;

+ (UIColor *)colorWithHexString:(NSString *)hex;

//从UIColor得到RGBA字符串
+(NSString *)rgbaStringFromUIColor:(UIColor *)color;

+(NSString *)hexValuesFromUIColor:(UIColor *)color;

+ (UIColor *)colorWithHex:(uint)hex alpha:(CGFloat)alpha;

@end
