//
//  MyKeyboardViewController.h
//  MyKeyboard
//
//  Created by luowei on 15/6/30.
//  Copyright (c) 2015年 luowei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWDefines.h"

@class LWBaseKeyboard;
@class LWToolBar;
@class LWRootWrapView;
@class LWBaseKBBtn;
@class LWKeyKBBtn;
@class LWShiftBtn;
@class LWKeyboardWrap;
@class LWTopView;
@class LWSingleHandView;
@class LWSymbolKeyboard;
@class LWPredictiveView;


@interface MyKeyboardViewController : UIInputViewController

//单手之外区域
@property(nonatomic, strong) LWRootWrapView *rootWrapView;

//包裹keyboard的视图
@property(nonatomic, strong) LWKeyboardWrap *keyboardWrap;
//包裹toolbar 或 predictive 的视图
@property(nonatomic, strong) LWTopView *topView;
//单手模式视图
@property(nonatomic, strong) LWSingleHandView *singleHandView;

//工具条
@property(nonatomic, strong) LWToolBar *toolbar;

//键盘
@property(nonatomic, strong) LWBaseKeyboard *keyboard;

//inputView的约束
@property(nonatomic, strong) NSMutableArray *inputViewConstraints;


@property(nonatomic, strong) LWPredictiveView *predictiveView;

//提交字符串
- (void)insertText:(NSString *)text;

//切换输入法
- (void)switchInputMethod;

//切换键盘
- (void)swithcKeyboard:(KeyboardType)type;

//按键按下
- (void)kbBtnTouchDown:(UIButton *)btn;

//按键重复按
- (void)kbBtnTouchRepeat:(LWBaseKBBtn *)btn;

//按键按下
- (void)kbBtnTouchUpInside:(LWBaseKBBtn *)btn;

//删除键按下
- (void)deleteBtnTouchUpInside:(UIButton *)btn;

//shift键按下
- (void)shiftBtnTouchUpInside:(LWShiftBtn *)btn;

//换行键按下
- (void)breakLineBtnTouchUpInside:(LWKeyKBBtn *)btn;

//按键Touch取消
- (void)kbBtnTouchCancel:(LWBaseKBBtn *)btn;

//按键轻扫
- (void)kbBtnSwipe:(UISwipeGestureRecognizer *)recognizer;

//按键滑动
- (void)kbBtnPan:(UIPanGestureRecognizer *)recognizer;

//按键长按
- (void)kbBtnLongPress:(UILongPressGestureRecognizer *)recognizer;

//更新工具栏小三角
- (void)updateToolbarArrow:(UIButton *)btn;

//根据类型添加浮窗
- (void)toolbarBtnTouchUpInside:(UIView *)button withType:(BtnType)type;

//隐藏键盘
- (void)dismiss;

//从工具栏浮窗返回
- (void)backFromPopView;

@end
