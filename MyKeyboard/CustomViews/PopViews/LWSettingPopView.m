//
//  LWSettingPopView.m
//  MyInputMethod
//
//  Created by luowei on 15/7/28.
//  Copyright (c) 2015 luowei. All rights reserved.
//

#import "LWSettingPopView.h"
#import "LWDefines.h"
#import "UIImage+Color.h"
#import "LWImageTextBtn.h"

@implementation LWSettingPopView {

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

    [self.dayNightBtn setTitle:NSLocalizedString(@"Night Mode", nil) forState:UIControlStateNormal];
    [self.dayNightBtn setTitleColor:UIColorValueFromThemeKey(@"btn.content.color") forState:UIControlStateNormal];
    [self.dayNightBtn setTitleColor:UIColorValueFromThemeKey(@"btn.content.highlightColor") forState:UIControlStateHighlighted];
    [self.dayNightBtn setImage:[[UIImage imageNamed:@"nightmode"] imageWithOverlayColor:UIColorValueFromThemeKey(@"btn.content.color")] forState:UIControlStateNormal];
    [self.dayNightBtn setImage:[[UIImage imageNamed:@"nightmode"] imageWithOverlayColor:UIColorValueFromThemeKey(@"btn.content.highlightColor")] forState:UIControlStateHighlighted];

    [self.enPredictBtn setTitle:NSLocalizedString(@"English Predict", nil) forState:UIControlStateNormal];
    [self.enPredictBtn setTitleColor:UIColorValueFromThemeKey(@"btn.content.color") forState:UIControlStateNormal];
    [self.enPredictBtn setTitleColor:UIColorValueFromThemeKey(@"btn.content.highlightColor") forState:UIControlStateHighlighted];
    [self.enPredictBtn setImage:[[UIImage imageNamed:@"en_predict"] imageWithOverlayColor:UIColorValueFromThemeKey(@"btn.content.color")] forState:UIControlStateNormal];
    [self.enPredictBtn setImage:[[UIImage imageNamed:@"en_predict"] imageWithOverlayColor:UIColorValueFromThemeKey(@"btn.content.highlightColor")] forState:UIControlStateHighlighted];

    [self.simplifyBtn setTitle:NSLocalizedString(@"SimplifyOrTraditional", nil) forState:UIControlStateNormal];
    [self.simplifyBtn setTitleColor:UIColorValueFromThemeKey(@"btn.content.color") forState:UIControlStateNormal];
    [self.simplifyBtn setTitleColor:UIColorValueFromThemeKey(@"btn.content.highlightColor") forState:UIControlStateHighlighted];
    [self.simplifyBtn setImage:[[UIImage imageNamed:@"simplify"] imageWithOverlayColor:UIColorValueFromThemeKey(@"btn.content.color")] forState:UIControlStateNormal];
    [self.simplifyBtn setImage:[[UIImage imageNamed:@"simplify"] imageWithOverlayColor:UIColorValueFromThemeKey(@"btn.content.highlightColor")] forState:UIControlStateHighlighted];

    [self.marsBtn setTitle:NSLocalizedString(@"Mars Mode", nil) forState:UIControlStateNormal];
    [self.marsBtn setTitleColor:UIColorValueFromThemeKey(@"btn.content.color") forState:UIControlStateNormal];
    [self.marsBtn setTitleColor:UIColorValueFromThemeKey(@"btn.content.highlightColor") forState:UIControlStateHighlighted];
    [self.marsBtn setImage:[[UIImage imageNamed:@"mars"] imageWithOverlayColor:UIColorValueFromThemeKey(@"btn.content.color")] forState:UIControlStateNormal];
    [self.marsBtn setImage:[[UIImage imageNamed:@"mars"] imageWithOverlayColor:UIColorValueFromThemeKey(@"btn.content.highlightColor")] forState:UIControlStateHighlighted];

    [self.soundBtn setTitle:NSLocalizedString(@"Key Sound", nil) forState:UIControlStateNormal];
    [self.soundBtn setTitleColor:UIColorValueFromThemeKey(@"btn.content.color") forState:UIControlStateNormal];
    [self.soundBtn setTitleColor:UIColorValueFromThemeKey(@"btn.content.highlightColor") forState:UIControlStateHighlighted];
    [self.soundBtn setImage:[[UIImage imageNamed:@"sound"] imageWithOverlayColor:UIColorValueFromThemeKey(@"btn.content.color")] forState:UIControlStateNormal];
    [self.soundBtn setImage:[[UIImage imageNamed:@"sound"] imageWithOverlayColor:UIColorValueFromThemeKey(@"btn.content.highlightColor")] forState:UIControlStateHighlighted];

    [self.moreSettingBtn setTitle:NSLocalizedString(@"MoreSetting Mode", nil) forState:UIControlStateNormal];
    [self.moreSettingBtn setTitleColor:UIColorValueFromThemeKey(@"btn.content.color") forState:UIControlStateNormal];
    [self.moreSettingBtn setTitleColor:UIColorValueFromThemeKey(@"btn.content.highlightColor") forState:UIControlStateHighlighted];
    [self.moreSettingBtn setImage:[[UIImage imageNamed:@"more"] imageWithOverlayColor:UIColorValueFromThemeKey(@"btn.content.color")] forState:UIControlStateNormal];
    [self.moreSettingBtn setImage:[[UIImage imageNamed:@"more"] imageWithOverlayColor:UIColorValueFromThemeKey(@"btn.content.highlightColor")] forState:UIControlStateHighlighted];

}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.backgroundColor = UIColorValueFromThemeKey(@"popView.backgroundColor");
}


@end
