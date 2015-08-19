//
//  LWToolbar.h
//  MyInputMethod
//
//  Created by luowei on 15/7/6.
//  Copyright (c) 2015年 luowei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWDefines.h"

@protocol LWToolbarDelegate <NSObject>

/**
* 根据类型添加浮窗
*/
- (void)toolbarBtnTouchUpInside:(UIView *)button withType:(BtnType)type;

/**
* 删除浮窗
*/
- (void)removePopViewByBtn:(UIView *)btn withType:(BtnType)type;

/**
* 隐藏键盘
*/
- (void)dismiss;

@end

@interface LWToolBar : UIView

@property(nonatomic, weak) id <LWToolbarDelegate> delegate;

@property(nonatomic, weak) IBOutlet UIButton *logoBtn;
@property(nonatomic, weak) IBOutlet UIButton *emojiBtn;
@property(weak, nonatomic) IBOutlet UIButton *switchkbBtn;
@property(weak, nonatomic) IBOutlet UIButton *skinBtn;
@property(nonatomic, weak) IBOutlet UIButton *hideBtn;
@property (weak, nonatomic) IBOutlet UIImageView *arrow;

@property(nonatomic, strong) NSArray *toolBarHorizonConstraints;
@property(nonatomic, strong) NSArray *toolBarVerticelConstraints;


/**
* 更新subViews的主题
*/
- (void)updateSubviewsTheme;

/**
 * 给ToolBar设置约束
 */
- (void)setupToolBarConstraints;

- (void)updateArrow:(UIButton *)button;
@end
