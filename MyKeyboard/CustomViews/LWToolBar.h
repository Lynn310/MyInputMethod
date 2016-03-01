//
//  LWToolbar.h
//  MyInputMethod
//
//  Created by luowei on 15/7/6.
//  Copyright (c) 2015年 luowei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWDefines.h"


@interface LWToolBar : UIView


@property(nonatomic, weak) IBOutlet UIButton *logoBtn;
@property(nonatomic, weak) IBOutlet UIButton *emojiBtn;
@property(weak, nonatomic) IBOutlet UIButton *switchkbBtn;
@property(weak, nonatomic) IBOutlet UIButton *skinBtn;
@property(nonatomic, weak) IBOutlet UIButton *hideBtn;
@property (weak, nonatomic) IBOutlet UIImageView *arrow;

//hide button
@property (weak, nonatomic) IBOutlet UIButton *phraseBtn;
@property (weak, nonatomic) IBOutlet UIButton *emoticonBtn;
@property (weak, nonatomic) IBOutlet UIButton *graphicBtn;


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

//恢复工具栏有所按键到初始状态
- (void)resumeAllBtnStatus;

@end
