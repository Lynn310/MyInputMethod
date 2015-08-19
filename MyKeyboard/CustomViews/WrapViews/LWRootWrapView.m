//
// Created by luowei on 15/8/5.
// Copyright (c) 2015 luowei. All rights reserved.
//

#import "LWRootWrapView.h"
#import "LWSettingPopView.h"
#import "LWDefines.h"
#import "LWKeyboardConfig.h"
#import "LWOftenWordsPopView.h"
#import "LWKeyboardSettingPopView.h"


@interface LWRootWrapView ()
@property(nonatomic, strong) LWSettingPopView *settingPopView;
@property(nonatomic, strong) LWOftenWordsPopView *oftenWordsPop;
@property(nonatomic, strong) LWKeyboardSettingPopView *keyboardSettingPopView;
@end

@implementation LWRootWrapView {

}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }

    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (_settingPopView) {
        _settingPopView.frame = CGRectMake(0, TopView_H, self.frame.size.width, self.frame.size.height - TopView_H);
    }
    if (_oftenWordsPop) {
        _oftenWordsPop.frame = CGRectMake(0, TopView_H, self.frame.size.width, self.frame.size.height - TopView_H);
    }
    
}

/**
* 根据按键类型添加PopView
*/
- (void)addPopViewByBtn:(UIView *)btn withType:(BtnType)type {
    //删除其他的popView
    UIButton *button = (UIButton *) btn;
    if(!button.selected){
        [self removeAllOtherPopView:button];
        return;
    }

    CGRect commonPopViewFrame = CGRectMake(0, TopView_H, self.frame.size.width, self.frame.size.height - TopView_H);
    switch (type) {
        case ToolbarBtn_Logo: {
            _settingPopView = (LWSettingPopView *) [[NSBundle mainBundle] loadNibNamed:@"LWSettingPopView" owner:self options:nil][0];
            [self addSubview:_settingPopView];
            _settingPopView.frame = commonPopViewFrame;
            break;
        };
        case ToolbarBtn_Emoji: {

            break;
        };
        case ToolbarBtn_SwitchKB: {
            _keyboardSettingPopView = (LWKeyboardSettingPopView *) [[NSBundle mainBundle] loadNibNamed:@"LWKeyboardSettingPopView" owner:self options:nil][0];
            [self addSubview:_keyboardSettingPopView];
            _keyboardSettingPopView.frame = commonPopViewFrame;
            break;
        };
        case ToolbarBtn_Skin: {

            break;
        };
        case ToolbarBtn_OftenWords: {
            _oftenWordsPop = [[LWOftenWordsPopView alloc] initWithFrame:commonPopViewFrame];
            [self addSubview:_oftenWordsPop];
            break;
        };
        case KBBtn_Next: {

            break;
        };
        case KBBtn_FullChar: {

            break;
        };
        default:
            break;
    }
}

/**
* 移除其他的popView
*/
- (void)removeAllOtherPopView:(UIButton *)btn {
    if (_settingPopView) {
        [_settingPopView removeFromSuperview];
        _settingPopView = nil;
        [self.delegate updateToolbarArrow:(UIButton *) btn];
    }
    if (_keyboardSettingPopView) {
        [_keyboardSettingPopView removeFromSuperview];
        _keyboardSettingPopView = nil;
        [self.delegate updateToolbarArrow:(UIButton *) btn];
    }
    if (_oftenWordsPop) {
        [_oftenWordsPop removeFromSuperview];
        _oftenWordsPop = nil;
        [self.delegate updateToolbarArrow:(UIButton *) btn];
    }
}

/**
* 根据btn与类型移除popView
*/
- (void)removePopViewByBtn:(UIView *)view withType:(BtnType)type {
    switch (type) {
        case ToolbarBtn_Logo: {
            [_settingPopView removeFromSuperview];
            _settingPopView = nil;
            break;
        };
        case ToolbarBtn_Emoji: {
            
            break;
        };
        case ToolbarBtn_SwitchKB: {
            [_keyboardSettingPopView removeFromSuperview];
            _keyboardSettingPopView = nil;
            break;
        };
        case ToolbarBtn_Skin: {

            break;
        };
        case ToolbarBtn_OftenWords: {
            [_oftenWordsPop removeFromSuperview];
            _oftenWordsPop = nil;
            break;
        };
        case KBBtn_Next: {
            
            break;
        };
        case KBBtn_FullChar: {
            
            break;
        };
        default:
            break;
    }
}


@end