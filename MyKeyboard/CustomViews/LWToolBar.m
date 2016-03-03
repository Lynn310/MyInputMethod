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
#import "Categories.h"
#import "MyKeyboardViewController.h"
#import "LWDataConfig.h"

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
        topBorder.backgroundColor = CGColorValueFromThemeKey(@"btn.borderColor");
        topBorder.frame = CGRectMake(0, 0, self.bounds.size.width, NarrowLine_W);
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


    //hide button
    [_phraseBtn addTarget:self action:@selector(phraseBtnTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [_emoticonBtn addTarget:self action:@selector(emoticonBtnTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [_graphicBtn addTarget:self action:@selector(graphicBtnTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];

    _arrow.hidden = YES;

}


/**
* 更新subViews的主题
*/
- (void)updateSubviewsTheme {
    if(!_arrow.hidden){
        _arrow.image = [[UIImage imageNamed:@"arrow"] imageWithOverlayColor:[LWDataConfig getPopViewBackGroundColor]];
    }

    [_logoBtn setImage:[[UIImage imageNamed:@"logo"] imageWithOverlayColor:UIColorValueFromThemeKey(@"font.color")] forState:UIControlStateNormal];
    [_logoBtn setImage:[[UIImage imageNamed:@"logo"] imageWithOverlayColor:UIColorValueFromThemeKey(@"font.highlightColor")] forState:UIControlStateHighlighted];
    [_emojiBtn setImage:[[UIImage imageNamed:@"emoji"] imageWithOverlayColor:UIColorValueFromThemeKey(@"font.color")] forState:UIControlStateNormal];
    [_emojiBtn setImage:[[UIImage imageNamed:@"emoji"] imageWithOverlayColor:UIColorValueFromThemeKey(@"font.highlightColor")] forState:UIControlStateHighlighted];
    [_switchkbBtn setImage:[[UIImage imageNamed:@"switchkb"] imageWithOverlayColor:UIColorValueFromThemeKey(@"font.color")] forState:UIControlStateNormal];
    [_switchkbBtn setImage:[[UIImage imageNamed:@"switchkb"] imageWithOverlayColor:UIColorValueFromThemeKey(@"font.highlightColor")] forState:UIControlStateHighlighted];
    [_skinBtn setImage:[[UIImage imageNamed:@"skin"] imageWithOverlayColor:UIColorValueFromThemeKey(@"font.color")] forState:UIControlStateNormal];
    [_skinBtn setImage:[[UIImage imageNamed:@"skin"] imageWithOverlayColor:UIColorValueFromThemeKey(@"font.highlightColor")] forState:UIControlStateHighlighted];
    [_hideBtn setImage:[[UIImage imageNamed:@"hide"] imageWithOverlayColor:UIColorValueFromThemeKey(@"font.color")] forState:UIControlStateNormal];
    [_hideBtn setImage:[[UIImage imageNamed:@"hide"] imageWithOverlayColor:UIColorValueFromThemeKey(@"font.highlightColor")] forState:UIControlStateHighlighted];

    [_phraseBtn setImage:[[UIImage imageNamed:@"phrase"] imageWithOverlayColor:UIColorValueFromThemeKey(@"font.color")] forState:UIControlStateNormal];
    [_phraseBtn setImage:[[UIImage imageNamed:@"phrase"] imageWithOverlayColor:UIColorValueFromThemeKey(@"font.highlightColor")] forState:UIControlStateHighlighted];
    [_emoticonBtn setImage:[[UIImage imageNamed:@"emoticon"] imageWithOverlayColor:UIColorValueFromThemeKey(@"font.color")] forState:UIControlStateNormal];
    [_emoticonBtn setImage:[[UIImage imageNamed:@"emoticon"] imageWithOverlayColor:UIColorValueFromThemeKey(@"font.highlightColor")] forState:UIControlStateHighlighted];
    [_graphicBtn setImage:[[UIImage imageNamed:@"graphic"] imageWithOverlayColor:UIColorValueFromThemeKey(@"font.color")] forState:UIControlStateNormal];
    [_graphicBtn setImage:[[UIImage imageNamed:@"graphic"] imageWithOverlayColor:UIColorValueFromThemeKey(@"font.highlightColor")] forState:UIControlStateHighlighted];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    topBorder.frame = CGRectMake(0, 0, self.bounds.size.width, NarrowLine_W);
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

//恢复工具栏有所按键到初始状态
- (void)resumeAllBtnStatus{
    _logoBtn.selected = _switchkbBtn.selected = _skinBtn.selected =
            _phraseBtn.selected = _emojiBtn.selected = _emoticonBtn.selected = _graphicBtn.selected = NO;
    _logoBtn.hidden = _switchkbBtn.hidden = _skinBtn.hidden = NO;
    _phraseBtn.hidden = _emoticonBtn.hidden = _graphicBtn.hidden = _arrow.hidden = YES;
}


//logo设置键被按下
- (void)logoBtnTouchUpInside:(UIButton *)btn {
    btn.selected = !btn.selected;
    [self updateArrow:btn];
    [self.responderKBViewController toolbarBtnTouchUpInside:btn withType:ToolbarBtn_Logo];
}


//打开表情浮层被按下,分情况处理
- (void)emojiBtnTouchUpInside:(UIButton *)btn {

    //emojiPopView默认要打开的PopView
    id value = [LWDataConfig getUserDefaultValueByKey:Key_LastEmojiPop_Index];
    NSInteger lastEmojiIdx = value? ((NSNumber *)value).intValue : 0;

    BOOL emojiPopOpened = _phraseBtn.selected || _emojiBtn.selected || _emoticonBtn.selected || _graphicBtn.selected;
    //如果emojiPopView已经是处理打开的状态,并且是emojiBtn被按下
    if(emojiPopOpened){
        [self emojiBtnSelect:btn];
        return;
    }

    switch (lastEmojiIdx){
        //约定Idx : emoji为0, phrase为1, emoticon为2, graphic为3
        //打开快捷短语
        case 1:{
            [self phraseBtnTouchUpInside:_phraseBtn];
            break;
        }
            //打开颜文字表情
        case 2:{
            [self emoticonBtnTouchUpInside:_emoticonBtn];
            break;
        }
            //打开图片表情
        case 3:{
            [self graphicBtnTouchUpInside:_graphicBtn];
            break;
        }
            //默认打开emoji
        default:{
            [self emojiBtnSelect:btn];
            break;
        }

    }


}

//选择emojiBtn
- (void)emojiBtnSelect:(UIButton *)btn {
    btn.selected = !btn.selected;
    [self updateArrow:btn];
    [self updateBtnsHiddenStatus:btn];
    [self.responderKBViewController toolbarBtnTouchUpInside:btn withType:ToolbarBtn_Emoji];

    //如emoji弹窗打开了,则工具栏显示出其他的表情按键
    if(btn.selected){
                //显示phraseBtn,隐藏logoBtn
                _logoBtn.hidden = _switchkbBtn.hidden = _skinBtn.hidden = YES;
                _phraseBtn.hidden = _emoticonBtn.hidden = _graphicBtn.hidden = NO;
            }

    if(btn.selected){
        //约定Idx : emoji为0, phrase为1, emoticon为2, graphic为3
        [LWDataConfig setUserDefaultValue:@0 withKey:Key_LastEmojiPop_Index];
    }
}

//自定义短语键被按下
- (void)phraseBtnTouchUpInside:(UIButton *)btn {
    btn.selected = !btn.selected;
    [self updateArrow:btn];
    [self updateBtnsHiddenStatus:btn];
    [self.responderKBViewController toolbarBtnTouchUpInside:btn withType:ToolbarBtn_Phrase];

    if(btn.selected){
        //约定Idx : emoji为0, phrase为1, emoticon为2, graphic为3
        [LWDataConfig setUserDefaultValue:@1 withKey:Key_LastEmojiPop_Index];
    }
}

//颜文字表情键被按下
- (void)emoticonBtnTouchUpInside:(UIButton *)btn {
    btn.selected = !btn.selected;
    [self updateArrow:btn];
    [self updateBtnsHiddenStatus:btn];
    [self.responderKBViewController toolbarBtnTouchUpInside:btn withType:ToolbarBtn_Emoticon];

    if(btn.selected){
        //约定Idx : emoji为0, phrase为1, emoticon为2, graphic为3
        [LWDataConfig setUserDefaultValue:@2 withKey:Key_LastEmojiPop_Index];
    }
}

//图像表情键被按下
- (void)graphicBtnTouchUpInside:(UIButton *)btn {
    btn.selected = !btn.selected;
    [self updateArrow:btn];
    [self updateBtnsHiddenStatus:btn];
    [self.responderKBViewController toolbarBtnTouchUpInside:btn withType:ToolbarBtn_Graphic];

    if(btn.selected){
        //约定Idx : emoji为0, phrase为1, emoticon为2, graphic为3
        [LWDataConfig setUserDefaultValue:@3 withKey:Key_LastEmojiPop_Index];
    }
}

//切换键盘被按下
- (void)switchkbBtnTouchUpInside:(UIButton *)btn {
    btn.selected = !btn.selected;
    [self updateArrow:btn];
    [self.responderKBViewController toolbarBtnTouchUpInside:btn withType:ToolbarBtn_SwitchKB];
}

//打开皮肤设置窗体被按下
- (void)skinBtnTouchUpInside:(UIButton *)btn {
    btn.selected = !btn.selected;
    [self updateArrow:btn];
    [self.responderKBViewController toolbarBtnTouchUpInside:btn withType:ToolbarBtn_Skin];
}

//隐藏键盘键被按下
- (void)hideBtnTouchUpInside:(UIButton *)btn {
    [self.responderKBViewController dismiss];
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

//隐藏phraseBtn,显示logoBtn
-(void)updateBtnsHiddenStatus:(UIButton *)btn{
    if(!btn.selected){
        _logoBtn.hidden = _switchkbBtn.hidden = _skinBtn.hidden = NO;
        _phraseBtn.hidden = _emoticonBtn.hidden = _graphicBtn.hidden = YES;
    }
}

@end
