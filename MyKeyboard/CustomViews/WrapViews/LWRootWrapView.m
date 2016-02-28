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
#import "LWSkinSettingPopView.h"
#import "LWPhrasePopView.h"
#import "LWEmoticonPopView.h"
#import "LWGraphicPopView.h"
#import "LWEmojiPopView.h"
#import "Categories.h"
#import "MyKeyboardViewController.h"


@interface LWRootWrapView ()
@property(nonatomic, strong) LWSettingPopView *settingPopView;
@property(nonatomic, strong) LWKeyboardSettingPopView *keyboardSettingPopView;
@property(nonatomic, strong) LWSkinSettingPopView *skinSettingPopView;
@property(nonatomic, strong) LWEmojiPopView *emojiPopView;
@property(nonatomic, strong) LWPhrasePopView *phrasePopView;
@property(nonatomic, strong) LWEmoticonPopView *emoticonPopView;
@property(nonatomic, strong) LWGraphicPopView *graphicPopView;

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
            _emojiPopView = [[LWEmojiPopView alloc] initWithFrame:commonPopViewFrame];
            [self addSubview:_emojiPopView];
            break;
        };
        case ToolbarBtn_Phrase: {
            _phrasePopView = [[LWPhrasePopView alloc] initWithFrame:commonPopViewFrame];
            [self addSubview:_phrasePopView];
            break;
        };
        case ToolbarBtn_Emoticon: {
            _emoticonPopView = [[LWEmoticonPopView alloc] initWithFrame:commonPopViewFrame];
            [self addSubview:_emoticonPopView];
            break;
        };
        case ToolbarBtn_Graphic: {
            _graphicPopView = [[LWGraphicPopView alloc] initWithFrame:commonPopViewFrame];
            [self addSubview:_graphicPopView];
            break;
        };
        case ToolbarBtn_SwitchKB: {
            _keyboardSettingPopView = (LWKeyboardSettingPopView *) [[NSBundle mainBundle] loadNibNamed:@"LWKeyboardSettingPopView" owner:self options:nil][0];
            [self addSubview:_keyboardSettingPopView];
            _keyboardSettingPopView.frame = commonPopViewFrame;
            break;
        };
        case ToolbarBtn_Skin: {
            _skinSettingPopView = (LWSkinSettingPopView *) [[NSBundle mainBundle] loadNibNamed:@"LWSkinSettingPopView" owner:self options:nil][0];
            [self addSubview:_skinSettingPopView];
            _skinSettingPopView.frame = commonPopViewFrame;
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
    [self removePopView:_settingPopView withBtn:btn];
    [self removePopView:_keyboardSettingPopView withBtn:btn];
    [self removePopView:_skinSettingPopView withBtn:btn];
    [self removePopView:_emojiPopView withBtn:btn];
    [self removePopView:_phrasePopView withBtn:btn];
    [self removePopView:_emoticonPopView withBtn:btn];
    [self removePopView:_graphicPopView withBtn:btn];
}

- (void)removePopView:(UIView *)popView withBtn:(UIButton *)btn {
    if (popView) {
        [popView removeFromSuperview];
        popView = nil;
        [self.responderKBViewController updateToolbarArrow:(UIButton *) btn];
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
        case ToolbarBtn_Phrase: {

            break;
        };
        case ToolbarBtn_Emoticon: {

            break;
        };
        case ToolbarBtn_Graphic: {

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