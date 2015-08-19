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
#import "UIImage+Color.h"

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
        topBorder.backgroundColor = CGColor_KBBtn_ContentView_Border;
        topBorder.frame = CGRectMake(0, 0, self.bounds.size.width, 0.5);
        [self.layer addSublayer:topBorder];

    }

    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];

    [self updateSubviewsTheme];

    [_logoBtn addTarget:self action:@selector(logoBtnTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [_emojiBtn addTarget:self action:@selector(emojiBtnTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [_switchkbBtn addTarget:self action:@selector(switchkbBtnTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [_skinBtn addTarget:self action:@selector(skinBtnTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [_hideBtn addTarget:self action:@selector(hideBtnTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];

    _arrow.hidden = YES;
}

/**
* 更新subViews的主题
*/
- (void)updateSubviewsTheme {
    if(!_arrow.hidden){
        _arrow.image = [[UIImage imageNamed:@"arrow"] imageWithOverlayColor:Color_KBBtn_Content_Normal];
    }

    [_logoBtn setImage:[[UIImage imageNamed:@"logo"] imageWithOverlayColor:Color_KBBtn_Content_Normal] forState:UIControlStateNormal];
    [_logoBtn setImage:[[UIImage imageNamed:@"logo"] imageWithOverlayColor:Color_KBBtn_Content_Highlight] forState:UIControlStateHighlighted];
    [_emojiBtn setImage:[[UIImage imageNamed:@"emoji"] imageWithOverlayColor:Color_KBBtn_Content_Normal] forState:UIControlStateNormal];
    [_emojiBtn setImage:[[UIImage imageNamed:@"emoji"] imageWithOverlayColor:Color_KBBtn_Content_Highlight] forState:UIControlStateHighlighted];
    [_switchkbBtn setImage:[[UIImage imageNamed:@"switchkb"] imageWithOverlayColor:Color_KBBtn_Content_Normal] forState:UIControlStateNormal];
    [_switchkbBtn setImage:[[UIImage imageNamed:@"switchkb"] imageWithOverlayColor:Color_KBBtn_Content_Highlight] forState:UIControlStateHighlighted];
    [_skinBtn setImage:[[UIImage imageNamed:@"skin"] imageWithOverlayColor:Color_KBBtn_Content_Normal] forState:UIControlStateNormal];
    [_skinBtn setImage:[[UIImage imageNamed:@"skin"] imageWithOverlayColor:Color_KBBtn_Content_Highlight] forState:UIControlStateHighlighted];
    [_hideBtn setImage:[[UIImage imageNamed:@"hide"] imageWithOverlayColor:Color_KBBtn_Content_Normal] forState:UIControlStateNormal];
    [_hideBtn setImage:[[UIImage imageNamed:@"hide"] imageWithOverlayColor:Color_KBBtn_Content_Highlight] forState:UIControlStateHighlighted];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    topBorder.frame = CGRectMake(0, 0, self.bounds.size.width, 0.5);
    [self updateArrow:selectedBtn];
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
- (void)hideBtnTouchUpInside:(UIButton *)btn {
    [self.delegate dismiss];
}

//打开皮肤设置窗体被按下
- (void)skinBtnTouchUpInside:(UIButton *)btn {
    btn.selected = !btn.selected;
    [self updateArrow:btn];
    [self.delegate toolbarBtnTouchUpInside:btn withType:ToolbarBtn_Skin];
}

//切换键盘被按下
- (void)switchkbBtnTouchUpInside:(UIButton *)btn {
    btn.selected = !btn.selected;
    [self updateArrow:btn];
    [self.delegate toolbarBtnTouchUpInside:btn withType:ToolbarBtn_SwitchKB];
}

//打开表情浮层被按下
- (void)emojiBtnTouchUpInside:(UIButton *)btn {
    btn.selected = !btn.selected;
    [self updateArrow:btn];
    [self.delegate toolbarBtnTouchUpInside:btn withType:ToolbarBtn_Emoji];
}

//logo设置键被按下
- (void)logoBtnTouchUpInside:(UIButton *)btn {
    btn.selected = !btn.selected;
    [self updateArrow:btn];
    [self.delegate toolbarBtnTouchUpInside:btn withType:ToolbarBtn_Logo];
}

/**
* 更新工具栏小三角
*/
- (void)updateArrow:(UIButton *)button {
    selectedBtn = button;
    //如果select还为空
    if(!selectedBtn){
        return;
    }

    _arrow.hidden = !button.selected;
    if(!_arrow.hidden){
        _arrow.frame = CGRectMake(selectedBtn.frame.origin.x+(selectedBtn.frame.size.width-_arrow.frame.size.width)/2, selectedBtn.frame.size.height-_arrow.frame.size.height+1,
                _arrow.frame.size.width, _arrow.frame.size.height);
    }
}

@end
