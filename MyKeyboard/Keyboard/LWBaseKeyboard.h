//
//  LWBaseKeyboard.h
//  MyInputMethod
//  键盘基类
//  Created by luowei on 15/7/28.
//  Copyright (c) 2015 luowei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWDefines.h"

@class LWCharKBBtn;
@class LWKeyKBBtn;
@class LWBaseKBBtn;
@class LWShiftBtn;
@class LWShiftBtn;


@interface LWBaseKeyboard : UIView

//键盘水平方向上的约束
@property(nonatomic, strong) NSArray *keyboardHorizonConstraints;
//键盘垂直方向上的约束
@property(nonatomic, strong) NSArray *keyboardVerticelConstraints;


/**
* 给键盘设置约束
*/
- (void)setupKeyboardConstraints;
/**
* 设置背景颜色
*/
- (void)setupBackgroundColor:(UIColor *)color;

/**
* 设置背景图片
*/
- (void)setupBackground:(UIImage *)image;

/**
* 设置键盘提示文字
*/
-(void)setBtnTip:(NSString *)tip withTag:(NSInteger)tag;

/**
* 设置字符按键显示及事件处理
*/
- (void)setupCharKBBtns:(NSDictionary *)charTextTagDict;

/**
* 设置功能按键显示及事件处理
*/
- (void)setupKeyKBBtns:(NSDictionary *)keyTextTagDict;


#pragma mark CharKBBtn's Touch and Gesture Event

- (void)charKBBtnTouchDown:(LWCharKBBtn *)charKBBtnTouchDown;

- (void)charKBBtnTouchRepeat:(LWCharKBBtn *)charKBBtnTouchRepeat;

- (void)charKBBtnTouchUpInside:(LWCharKBBtn *)charKBBtnTouchUpInside;

- (void)charKBBtnTouchCancel:(LWCharKBBtn *)charKBBtnTouchCancel;

- (void)charKBBtnPan:(UIPanGestureRecognizer *)panGesture ;

- (void)charKBBtnSwip:(UISwipeGestureRecognizer *)swipeGesture;

#pragma mark KeyKBBtn's Touch and Gesture Event

- (void)keyKBBtnTouchDown:(LWKeyKBBtn *)keyKBBtnTouchDown;

- (void)keyKBBtnTouchUpInside:(LWKeyKBBtn *)keyKBBtnTouchUpInside;

- (void)keyKBBtnTouchCancel:(LWKeyKBBtn *)keyKBBtnTouchCancel;

- (void)keyKBBtnLongPress:(UILongPressGestureRecognizer *)keyKBBtnLongPress;

- (void)keyKBBtnSwip:(UISwipeGestureRecognizer *)keyKBBtnSwip;

- (void)keyKBBtnPan:(UIPanGestureRecognizer *)keyKBBtnPanUp;

@end
