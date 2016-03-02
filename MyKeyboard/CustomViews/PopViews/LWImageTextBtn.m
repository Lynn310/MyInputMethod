//
//  LWImageTextBtn.m
//  MyInputMethod
//
//  Created by luowei on 15/8/19.
//  Copyright (c) 2015年 luowei. All rights reserved.
//

#import "LWImageTextBtn.h"
#import "LWDefines.h"

@implementation LWImageTextBtn

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        self.backgroundColor = [UIColor clearColor];


        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        self.titleLabel.font = [UIFont fontWithName:StringValueFromThemeKey(@"font.name") size:FloatValueFromThemeKey(@"settingBtn.fontSize")];
        [self updateImageAndTextFrame];
    }

    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [self updateImageAndTextFrame];
    }

    return self;
}



- (void)layoutSubviews {
    [super layoutSubviews];

    [self updateImageAndTextFrame];
}

- (void)updateImageAndTextFrame {
    self.imageView.frame = CGRectMake(0, 0, self.bounds.size.width, (CGFloat) (self.bounds.size.height * 0.8));
    self.titleLabel.frame = CGRectMake(0, (CGFloat) (self.bounds.size.height*0.8), self.bounds.size.width, (CGFloat) (self.bounds.size.height*0.2));
}


@end
