//
//  LWSymbolKeyboard.m
//  MyInputMethod
//
//  Created by luowei on 16/3/4.
//  Copyright © 2016年 luowei. All rights reserved.
//

#import "LWSymbolKeyboard.h"
#import "LWDefines.h"
#import "LWBottomSeparatorLayer.h"
#import "LWDataConfig.h"
#import "Categories.h"
#import "MyKeyboardViewController.h"

#define NavItem_W 60

@implementation LWSymbolKeyboard

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.backgroundColor = [LWDataConfig getPopViewBackGroundColor];
    
        _bottomToolBar = [[LWBottomToolBar alloc]initWithFrame:CGRectMake(0, (CGFloat) (frame.size.height-Toolbar_H),frame.size.width,Toolbar_H)];
        _bottomToolBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addSubview:_bottomToolBar];

    }

    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    _bottomToolBar.frame = CGRectMake(0, (CGFloat) (self.frame.size.height-Toolbar_H),self.frame.size.width,Toolbar_H);
}


@end

//底部工具条
@implementation LWBottomToolBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

        //返回键
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setTitle:NSLocalizedString(@"Back", nil)forState:UIControlStateNormal];
        _backBtn.frame = CGRectMake(0, 0, NavItem_W, self.frame.size.height);
        [_backBtn addTarget:self action:@selector(backBtnTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_backBtn];
        //设置按键外观
        [self setBtnAppearance:_backBtn];

    }

    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];

    CGFloat backWidth = NavItem_W;
    _backBtn.frame = CGRectMake(0, 0, backWidth, self.frame.size.height);
}

//返回键按下
- (void)backBtnTouchUpInside:(UIButton *)btn {
    [self.responderKBViewController backFromPopView];
}

//设置按键外观
- (void)setBtnAppearance:(UIButton *)btn {
    //back添加右部分隔线
    if([btn.titleLabel.text isEqualToString:NSLocalizedString(@"Back", nil)]){
        CALayer *rightLine = [LWRightSeparatorLayer layer];
        [btn.layer addSublayer:rightLine];
        rightLine.backgroundColor = CGColorValueFromThemeKey(@"btn.borderColor");
        rightLine.frame = CGRectMake(btn.frame.size.width-NarrowLine_W,0,NarrowLine_W,btn.frame.size.height);
    }

    btn.titleLabel.font = [UIFont fontWithName:StringValueFromThemeKey(@"font.name")
                                          size:FloatValueFromThemeKey(@"btn.mainLabel.fontSize")];
    [btn setTitleColor:UIColorValueFromThemeKey(@"font.color") forState:UIControlStateNormal];
    [btn setTitleColor:UIColorValueFromThemeKey(@"font.highlightColor") forState:UIControlStateHighlighted];
}


@end

//左部符号分类区
@implementation LWLeftNavScrollView{
    NSArray *_navItems;
}

- (instancetype)initWithFrame:(CGRect)frame andNavItems:(NSArray *)navItems{
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;

        self.pagingEnabled = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.scrollsToTop = NO;

        _navItems = navItems;
        CGFloat navItemsWidth = NavItem_W;

        self.contentSize = CGSizeMake(navItemsWidth, frame.size.height);

        //设置底部分类条
        [self setupBottomNavItemBtns];
        //默认设置当前item为第一个
        currentBtn = (UIButton *)[self viewWithTag:Tag_First_NavItem];
    }

    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //更新分隔线位置
    for(CALayer *layer in self.layer.sublayers){
        if([layer isKindOfClass:[LWBottomSeparatorLayer class]]){
            layer.frame = CGRectMake(0,layer.frame.size.height-NarrowLine_W,layer.frame.size.width,NarrowLine_W);
        }
    }
}

//设置顶行分类滚动条的按钮
- (void)setupBottomNavItemBtns {

    //设置标签
    CGFloat x = 0;
    for (int i = 0; i < [_navItems count]; i++) {

        UIButton *button = (UIButton *) [self viewWithTag:i + Tag_First_NavItem];
        if (!button) {
            button = [UIButton buttonWithType:UIButtonTypeCustom];
        }
        [button setFrame:CGRectMake(x, 0, NavItem_W, self.frame.size.height)];
        x += NavItem_W;
        [button setTag:i + Tag_First_NavItem];
        [button setTitle:[NSString stringWithFormat:@"%@", _navItems[(NSUInteger) i]] forState:UIControlStateNormal];

        [button addTarget:self action:@selector(bottomNavBtnTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];


        //添加右部分隔线,最后一个不添加
        if(i<_navItems.count-1){
            CALayer *bottomLine = [LWBottomSeparatorLayer layer];
            [button.layer addSublayer:bottomLine];
            bottomLine.backgroundColor = CGColorValueFromThemeKey(@"btn.borderColor");
            bottomLine.frame = CGRectMake(0,button.frame.size.height-NarrowLine_W,button.frame.size.width,NarrowLine_W);

        }

        button.titleLabel.font = [UIFont fontWithName:StringValueFromThemeKey(@"font.name")
                                                 size:FloatValueFromThemeKey(@"btn.mainLabel.fontSize")];
        [button setTitleColor:UIColorValueFromThemeKey(@"font.color") forState:UIControlStateNormal];
        [button setTitleColor:UIColorValueFromThemeKey(@"font.highlightColor") forState:UIControlStateHighlighted];

    }

}

//当选择一个分类
- (void)bottomNavBtnTouchUpInside:(UIButton *)btn {
    currentBtn = btn;
    self.updateTableDatasouce();
}


@end


//右部符号内容区
@implementation LWSymbolGridView



@end

