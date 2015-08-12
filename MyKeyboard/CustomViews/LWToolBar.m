//
//  LWToolbar.m
//  MyInputMethod
//
//  Created by luowei on 15/7/6.
//  Copyright (c) 2015年 luowei. All rights reserved.
//

#import "LWToolBar.h"
#import "LWDefines.h"
#import "LWKeyboardConfig.h"

@class LWKeyboardConfig;

@implementation LWToolBar{
    CALayer *topBorder;
    UIButton *selectedBtn;
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        self.backgroundColor = [UIColor clearColor];

        //添加边框
        topBorder = [CALayer layer];
        topBorder.backgroundColor = COLOR_KBBTN_CONTENTVIEW_BORDER;
        topBorder.frame = CGRectMake(0, 0, self.bounds.size.width, 0.5);
        [self.layer addSublayer:topBorder];
    }

    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [_logoBtn addTarget:self action:@selector(logoBtnTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
    [_emojiBtn addTarget:self action:@selector(emojiBtnTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
    [_switchkbBtn addTarget:self action:@selector(switchkbBtnTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
    [_skinBtn addTarget:self action:@selector(skinBtnTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
    [_hideBtn addTarget:self action:@selector(hideBtnTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    topBorder.frame = CGRectMake(0, 0, self.bounds.size.width, 0.5);
}

/**
 * 给ToolBar设置约束
 */
- (void)setupToolBarConstraints {
    //keyboard加约束
    self.translatesAutoresizingMaskIntoConstraints = NO;
    _toolBarHorizonConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[toolBar]|" options:0 metrics:nil views:@{@"toolBar" : self}];
    _toolBarVerticelConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(spaceY)-[toolBar]|" options:0 metrics:@{@"spaceY" : @Toolbar_Y} views:@{@"toolBar" : self}];
    [NSLayoutConstraint activateConstraints:_toolBarHorizonConstraints];
    [NSLayoutConstraint activateConstraints:_toolBarVerticelConstraints];
}

//隐藏键盘键被按下
- (void)hideBtnTouchUpInside {
    [self.delegate dismiss];
}

//打开皮肤设置窗体被按下
- (void)skinBtnTouchUpInside {

}

//切换键盘被按下
- (void)switchkbBtnTouchUpInside {

}

//打开表情浮层被按下
- (void)emojiBtnTouchUpInside {

}

//logo设置键被按下
- (void)logoBtnTouchUpInside {

}


@end
