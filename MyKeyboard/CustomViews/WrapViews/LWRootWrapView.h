//
// Created by luowei on 15/8/5.
// Copyright (c) 2015 luowei. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "LWDefines.h"

@class LWSettingPopView;
@class LWKeyboardSettingPopView;
@class LWSkinSettingPopView;
@class LWPhrasePopView;
@class LWEmoticonPopView;
@class LWGraphicPopView;
@class LWEmojiPopView;


@interface LWRootWrapView : UIView

/**
* 根据按键类型添加PopView
*/
- (void)addPopViewByBtn:(UIView *)btn withType:(BtnType)type;

/**
* 根据btn与类型移除popView
*/
- (void)removePopViewByBtn:(UIView *)view withType:(BtnType)type;

@end