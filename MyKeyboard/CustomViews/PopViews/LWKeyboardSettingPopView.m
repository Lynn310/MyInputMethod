//
// Created by luowei on 15/8/19.
// Copyright (c) 2015 luowei. All rights reserved.
//

#import "LWKeyboardSettingPopView.h"
#import "LWDefines.h"
#import "UIImage+Color.h"


@implementation LWKeyboardSettingPopView {

}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        self.backgroundColor = UIColorValueFromThemeKey(@"popView.backgroundColor");
    }

    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];

    [self.pinyinFullBtn setTitle:NSLocalizedString(@"PinYin FullKeyboard", nil) forState:UIControlStateNormal];
    [self.pinyinFullBtn setTitleColor:UIColorValueFromThemeKey(@"btn.content.color") forState:UIControlStateNormal];
    [self.pinyinFullBtn setTitleColor:UIColorValueFromThemeKey(@"btn.content.highlightColor") forState:UIControlStateHighlighted];
    [self.pinyinFullBtn setImage:[[UIImage imageNamed:@"26pinyin"] imageWithOverlayColor:UIColorValueFromThemeKey(@"btn.content.color")] forState:UIControlStateNormal];
    [self.pinyinFullBtn setImage:[[UIImage imageNamed:@"26pinyin"] imageWithOverlayColor:UIColorValueFromThemeKey(@"btn.content.highlightColor")] forState:UIControlStateHighlighted];

    [self.pinyinNineBtn setTitle:NSLocalizedString(@"PinYin NineKeyboard", nil) forState:UIControlStateNormal];
    [self.pinyinNineBtn setTitleColor:UIColorValueFromThemeKey(@"btn.content.color") forState:UIControlStateNormal];
    [self.pinyinNineBtn setTitleColor:UIColorValueFromThemeKey(@"btn.content.highlightColor") forState:UIControlStateHighlighted];
    [self.pinyinNineBtn setImage:[[UIImage imageNamed:@"9pinyin"] imageWithOverlayColor:UIColorValueFromThemeKey(@"btn.content.color")] forState:UIControlStateNormal];
    [self.pinyinNineBtn setImage:[[UIImage imageNamed:@"9pinyin"] imageWithOverlayColor:UIColorValueFromThemeKey(@"btn.content.highlightColor")] forState:UIControlStateHighlighted];

    [self.wubiFullBtn setTitle:NSLocalizedString(@"Wubi FullKeyboard", nil) forState:UIControlStateNormal];
    [self.wubiFullBtn setTitleColor:UIColorValueFromThemeKey(@"btn.content.color") forState:UIControlStateNormal];
    [self.wubiFullBtn setTitleColor:UIColorValueFromThemeKey(@"btn.content.highlightColor") forState:UIControlStateHighlighted];
    [self.wubiFullBtn setImage:[[UIImage imageNamed:@"26pinyin"] imageWithOverlayColor:UIColorValueFromThemeKey(@"btn.content.color")] forState:UIControlStateNormal];
    [self.wubiFullBtn setImage:[[UIImage imageNamed:@"26pinyin"] imageWithOverlayColor:UIColorValueFromThemeKey(@"btn.content.highlightColor")] forState:UIControlStateHighlighted];

    [self.bihuaNineBtn setTitle:NSLocalizedString(@"Bihua FullKeyboard", nil) forState:UIControlStateNormal];
    [self.bihuaNineBtn setTitleColor:UIColorValueFromThemeKey(@"btn.content.color") forState:UIControlStateNormal];
    [self.bihuaNineBtn setTitleColor:UIColorValueFromThemeKey(@"btn.content.highlightColor") forState:UIControlStateHighlighted];
    [self.bihuaNineBtn setImage:[[UIImage imageNamed:@"bh"] imageWithOverlayColor:UIColorValueFromThemeKey(@"btn.content.color")] forState:UIControlStateNormal];
    [self.bihuaNineBtn setImage:[[UIImage imageNamed:@"bh"] imageWithOverlayColor:UIColorValueFromThemeKey(@"btn.content.highlightColor")] forState:UIControlStateHighlighted];
}


@end