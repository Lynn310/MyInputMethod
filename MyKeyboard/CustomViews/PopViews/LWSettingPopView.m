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
        self.backgroundColor = Color_KBBtn_PopView_BG;
    }

    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];

    [self.dayNightBtn setTitle:NSLocalizedString(@"Night Mode", nil) forState:UIControlStateNormal];
    [self.dayNightBtn setTitleColor:Color_KBBtn_Content_Normal forState:UIControlStateNormal];
    [self.dayNightBtn setTitleColor:Color_KBBtn_Content_Highlight forState:UIControlStateHighlighted];
    [self.dayNightBtn setImage:[[UIImage imageNamed:@"nightmode"] imageWithOverlayColor:Color_KBBtn_Content_Normal] forState:UIControlStateNormal];
    [self.dayNightBtn setImage:[[UIImage imageNamed:@"nightmode"] imageWithOverlayColor:Color_KBBtn_Content_Highlight] forState:UIControlStateHighlighted];

    [self.enPredictBtn setTitle:NSLocalizedString(@"English Predict", nil) forState:UIControlStateNormal];
    [self.enPredictBtn setTitleColor:Color_KBBtn_Content_Normal forState:UIControlStateNormal];
    [self.enPredictBtn setTitleColor:Color_KBBtn_Content_Highlight forState:UIControlStateHighlighted];
    [self.enPredictBtn setImage:[[UIImage imageNamed:@"en_predict"] imageWithOverlayColor:Color_KBBtn_Content_Normal] forState:UIControlStateNormal];
    [self.enPredictBtn setImage:[[UIImage imageNamed:@"en_predict"] imageWithOverlayColor:Color_KBBtn_Content_Highlight] forState:UIControlStateHighlighted];

    [self.simplifyBtn setTitle:NSLocalizedString(@"SimplifyOrTraditional", nil) forState:UIControlStateNormal];
    [self.simplifyBtn setTitleColor:Color_KBBtn_Content_Normal forState:UIControlStateNormal];
    [self.simplifyBtn setTitleColor:Color_KBBtn_Content_Highlight forState:UIControlStateHighlighted];
    [self.simplifyBtn setImage:[[UIImage imageNamed:@"simplify"] imageWithOverlayColor:Color_KBBtn_Content_Normal] forState:UIControlStateNormal];
    [self.simplifyBtn setImage:[[UIImage imageNamed:@"simplify"] imageWithOverlayColor:Color_KBBtn_Content_Highlight] forState:UIControlStateHighlighted];

    [self.marsBtn setTitle:NSLocalizedString(@"Mars Mode", nil) forState:UIControlStateNormal];
    [self.marsBtn setTitleColor:Color_KBBtn_Content_Normal forState:UIControlStateNormal];
    [self.marsBtn setTitleColor:Color_KBBtn_Content_Highlight forState:UIControlStateHighlighted];
    [self.marsBtn setImage:[[UIImage imageNamed:@"mars"] imageWithOverlayColor:Color_KBBtn_Content_Normal] forState:UIControlStateNormal];
    [self.marsBtn setImage:[[UIImage imageNamed:@"mars"] imageWithOverlayColor:Color_KBBtn_Content_Highlight] forState:UIControlStateHighlighted];

    [self.soundBtn setTitle:NSLocalizedString(@"Key Sound", nil) forState:UIControlStateNormal];
    [self.soundBtn setTitleColor:Color_KBBtn_Content_Normal forState:UIControlStateNormal];
    [self.soundBtn setTitleColor:Color_KBBtn_Content_Highlight forState:UIControlStateHighlighted];
    [self.soundBtn setImage:[[UIImage imageNamed:@"sound"] imageWithOverlayColor:Color_KBBtn_Content_Normal] forState:UIControlStateNormal];
    [self.soundBtn setImage:[[UIImage imageNamed:@"sound"] imageWithOverlayColor:Color_KBBtn_Content_Highlight] forState:UIControlStateHighlighted];

    [self.moreSettingBtn setTitle:NSLocalizedString(@"MoreSetting Mode", nil) forState:UIControlStateNormal];
    [self.moreSettingBtn setTitleColor:Color_KBBtn_Content_Normal forState:UIControlStateNormal];
    [self.moreSettingBtn setTitleColor:Color_KBBtn_Content_Highlight forState:UIControlStateHighlighted];
    [self.moreSettingBtn setImage:[[UIImage imageNamed:@"more"] imageWithOverlayColor:Color_KBBtn_Content_Normal] forState:UIControlStateNormal];
    [self.moreSettingBtn setImage:[[UIImage imageNamed:@"more"] imageWithOverlayColor:Color_KBBtn_Content_Highlight] forState:UIControlStateHighlighted];

}


@end
