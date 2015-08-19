//
// Created by luowei on 15/8/5.
// Copyright (c) 2015 luowei. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "LWDefines.h"

@class LWSettingPopView;
@class LWOftenWordsPopView;
@class LWKeyboardSettingPopView;

@protocol LWRootWrapViewDelegate<NSObject>

- (void)updateToolbarArrow:(UIButton *)btn;

@end

@interface LWRootWrapView : UIView

@property (nonatomic, weak) id<LWRootWrapViewDelegate> delegate;

/**
* 根据按键类型添加PopView
*/
- (void)addPopViewByBtn:(UIView *)btn withType:(BtnType)type;

/**
* 根据btn与类型移除popView
*/
- (void)removePopViewByBtn:(UIView *)view withType:(BtnType)type;

@end