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
        self.backgroundColor = Color_KBBtn_PopView_BG;
    }

    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];

    [self.pinyinFullBtn setTitle:NSLocalizedString(@"PinYin FullKeyboard", nil) forState:UIControlStateNormal];
    [self.pinyinFullBtn setTitleColor:Color_KBBtn_Content_Normal forState:UIControlStateNormal];
    [self.pinyinFullBtn setTitleColor:Color_KBBtn_Content_Highlight forState:UIControlStateHighlighted];
    [self.pinyinFullBtn setImage:[[UIImage imageNamed:@"26pinyin"] imageWithOverlayColor:Color_KBBtn_Content_Normal] forState:UIControlStateNormal];
    [self.pinyinFullBtn setImage:[[UIImage imageNamed:@"26pinyin"] imageWithOverlayColor:Color_KBBtn_Content_Highlight] forState:UIControlStateHighlighted];

    [self.pinyinNineBtn setTitle:NSLocalizedString(@"PinYin NineKeyboard", nil) forState:UIControlStateNormal];
    [self.pinyinNineBtn setTitleColor:Color_KBBtn_Content_Normal forState:UIControlStateNormal];
    [self.pinyinNineBtn setTitleColor:Color_KBBtn_Content_Highlight forState:UIControlStateHighlighted];
    [self.pinyinNineBtn setImage:[[UIImage imageNamed:@"9pinyin"] imageWithOverlayColor:Color_KBBtn_Content_Normal] forState:UIControlStateNormal];
    [self.pinyinNineBtn setImage:[[UIImage imageNamed:@"9pinyin"] imageWithOverlayColor:Color_KBBtn_Content_Highlight] forState:UIControlStateHighlighted];

    [self.wubiFullBtn setTitle:NSLocalizedString(@"Wubi FullKeyboard", nil) forState:UIControlStateNormal];
    [self.wubiFullBtn setTitleColor:Color_KBBtn_Content_Normal forState:UIControlStateNormal];
    [self.wubiFullBtn setTitleColor:Color_KBBtn_Content_Highlight forState:UIControlStateHighlighted];
    [self.wubiFullBtn setImage:[[UIImage imageNamed:@"26pinyin"] imageWithOverlayColor:Color_KBBtn_Content_Normal] forState:UIControlStateNormal];
    [self.wubiFullBtn setImage:[[UIImage imageNamed:@"26pinyin"] imageWithOverlayColor:Color_KBBtn_Content_Highlight] forState:UIControlStateHighlighted];

    [self.bihuaNineBtn setTitle:NSLocalizedString(@"Bihua FullKeyboard", nil) forState:UIControlStateNormal];
    [self.bihuaNineBtn setTitleColor:Color_KBBtn_Content_Normal forState:UIControlStateNormal];
    [self.bihuaNineBtn setTitleColor:Color_KBBtn_Content_Highlight forState:UIControlStateHighlighted];
    [self.bihuaNineBtn setImage:[[UIImage imageNamed:@"bh"] imageWithOverlayColor:Color_KBBtn_Content_Normal] forState:UIControlStateNormal];
    [self.bihuaNineBtn setImage:[[UIImage imageNamed:@"bh"] imageWithOverlayColor:Color_KBBtn_Content_Highlight] forState:UIControlStateHighlighted];
}


@end