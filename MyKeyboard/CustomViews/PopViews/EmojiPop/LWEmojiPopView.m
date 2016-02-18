//
//  LWEmojiPopView.m
//  MyInputMethod
//
//  Created by luowei on 16/2/18.
//  Copyright © 2016年 luowei. All rights reserved.
//

#import "LWEmojiPopView.h"
#import "LWDefines.h"

@implementation LWEmojiPopView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorValueFromThemeKey(@"popView.backgroundColor");

    }

    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.backgroundColor = UIColorValueFromThemeKey(@"popView.backgroundColor");
}

@end
