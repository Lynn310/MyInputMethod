//
//  LWBottomNavBar.m
//  MyInputMethod
//
//  Created by luowei on 16/2/18.
//  Copyright © 2016年 luowei. All rights reserved.
//

#import "LWBottomNavBar.h"
#import "LWDefines.h"
#import "UIImage+Color.h"
#import "Categories.h"
#import "MyKeyboardViewController.h"

#define DelBtn_Width 50

@implementation LWBottomNavBar{
    BOOL showAddBtn;
}

- (instancetype)initWithFrame:(CGRect)frame andNavItems:(NSArray *)navItems andShowAdd:(BOOL)showAdd{
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        showAddBtn = showAdd;

        //顶部分隔线
        _topLine = [CALayer layer];
        [self.layer addSublayer:_topLine];
        _topLine.backgroundColor = CGColorValueFromThemeKey(@"btn.borderColor");
        _topLine.frame = CGRectMake(0,0,frame.size.width,NarrowLine_W);

        //设置 返回 与 "+" 按钮
        [self setupBackAndAddBtnWithFrame:frame];

        CGFloat width = frame.size.width-_backBtn.frame.size.width-DelBtn_Width;
        if(showAdd){
            width = frame.size.width-_backBtn.frame.size.width-_addBtn.frame.size.width-DelBtn_Width;
        }
        CGRect navScrollFrame = CGRectMake(_backBtn.frame.size.width,0,width,frame.size.height);
        _bottomNavScrollview = [[LWBottomNavScrollView alloc] initWithFrame:navScrollFrame andNavItems:navItems];
        [self addSubview:_bottomNavScrollview];

    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    _topLine.frame = CGRectMake(0,0,super.frame.size.width,NarrowLine_W);
    
    [self setFixBtnFrame:self.frame];
    CGFloat width = self.frame.size.width-_backBtn.frame.size.width-DelBtn_Width;
    if(showAddBtn){
        width = self.frame.size.width-_backBtn.frame.size.width-_addBtn.frame.size.width-DelBtn_Width;
    }
    CGRect navScrollFrame = CGRectMake(_backBtn.frame.size.width,0,width,self.frame.size.height);
    _bottomNavScrollview.frame = navScrollFrame;
}


//构建并设置返回和添加按键
- (void)setupBackAndAddBtnWithFrame:(CGRect)frame {
    //返回键
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backBtn setTitle:NSLocalizedString(@"Back", nil)forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(backBtnTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_backBtn];

    //添加键
    if(showAddBtn){
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn setTitle:@"+" forState:UIControlStateNormal];
        [_addBtn addTarget:self action:@selector(addBtnTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_addBtn];
    }

    //删除键
    _delBtn = [LWEmojiDelBtn buttonWithType:UIButtonTypeCustom];
    _delBtn.titleLabel.text = @"";
    UIImage *delImg = [UIImage imageNamed:@"delete"];
    UIImage *normalImg = [delImg imageWithOverlayColor:UIColorValueFromThemeKey(@"btn.content.color")];
    [_delBtn setImage:normalImg forState:UIControlStateNormal];
    UIImage *highLightImg = [delImg imageWithOverlayColor:UIColorValueFromThemeKey(@"btn.content.highlightColor")];
    [_delBtn setImage:highLightImg forState:UIControlStateHighlighted];
    [_delBtn addTarget:self action:@selector(delBtnTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_delBtn];

    //设置frame
    [self setFixBtnFrame:frame];

    //设置按键外观
    [self setBtnAppearance:_backBtn];
    [self setBtnAppearance:_delBtn];
    if(showAddBtn){
        [self setBtnAppearance:_addBtn];
    }

}

- (void)setFixBtnFrame:(CGRect)frame {
    CGFloat backWidth = [self getTextWidth:NSLocalizedString(@"Back", nil)];
    [_backBtn setFrame:CGRectMake(0, 0, backWidth, frame.size.height)];
    CGFloat addWidth = [self getTextWidth:@"+"];
    if(showAddBtn){
        [_addBtn setFrame:CGRectMake(frame.size.width - addWidth - DelBtn_Width, 0, addWidth, frame.size.height)];
    }
    [_delBtn setFrame:CGRectMake(frame.size.width - DelBtn_Width, 0, DelBtn_Width, frame.size.height)];

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
    //+,del添加左部分隔线
    if([btn.titleLabel.text isEqualToString:@"+"] || [btn.titleLabel.text isEqualToString:@""]){
        CALayer *leftLine = [LWLeftSeparatorLayer layer];
        [btn.layer addSublayer:leftLine];
        leftLine.backgroundColor = CGColorValueFromThemeKey(@"btn.borderColor");
        leftLine.frame = CGRectMake(0,0,NarrowLine_W,btn.frame.size.height);
    }
//    btn.layer.borderWidth = FloatValueFromThemeKey(@"btn.borderWidth");
//    btn.layer.borderColor = CGColorValueFromThemeKey(@"btn.borderColor");

    btn.titleLabel.font = [UIFont fontWithName:StringValueFromThemeKey(@"btn.mainLabel.fontName")
                                               size:FloatValueFromThemeKey(@"btn.mainLabel.fontSize")];
    [btn setTitleColor:UIColorValueFromThemeKey(@"btn.content.color") forState:UIControlStateNormal];
    [btn setTitleColor:UIColorValueFromThemeKey(@"btn.content.highlightColor") forState:UIControlStateHighlighted];
}

//返回键按下
- (void)backBtnTouchUpInside:(UIButton *)btn {
    [self.responderKBViewController backFromPopView];
}

//添加键按下
- (void)addBtnTouchUpInside:(UIButton *)btn {

}

//删除键按下
- (void)delBtnTouchUpInside:(UIButton *)btn {
    [self.responderKBViewController kbBtnTouchDown:btn];
}

//获得text的宽度
-(CGFloat)getTextWidth:(NSString *)text{
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont fontWithName:StringValueFromThemeKey(@"btn.mainLabel.fontName")
                                                                       size:FloatValueFromThemeKey(@"btn.mainLabel.fontSize")],
            NSForegroundColorAttributeName : UIColorValueFromThemeKey(@"btn.content.color"),
            NSBackgroundColorAttributeName : [UIColor clearColor]};
    NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:text attributes:attributes];
    return attrText.size.width + 20;
}

@end


@implementation LWBottomNavScrollView{
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
        CGFloat navItemsWidth = [self getNavItemsWidth:navItems];

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
        if([layer isKindOfClass:[LWRightSeparatorLayer class]]){
            layer.frame = CGRectMake(layer.superlayer.frame.size.width-NarrowLine_W,0,NarrowLine_W,layer.superlayer.frame.size.height);
        }
    }
}

//获得NavItems的宽度
- (CGFloat)getNavItemsWidth:(NSArray *)navItems {
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont fontWithName:StringValueFromThemeKey(@"btn.mainLabel.fontName")
                                                                       size:FloatValueFromThemeKey(@"btn.mainLabel.fontSize")],
            NSForegroundColorAttributeName : UIColorValueFromThemeKey(@"btn.content.color"),
            NSBackgroundColorAttributeName : [UIColor clearColor]};
    CGFloat navItemsWidth = 0;
    for(NSString *itemText in navItems){
        NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:itemText attributes:attributes];
        navItemsWidth = navItemsWidth + attrText.size.width+20;
    }
    return navItemsWidth;
}

//获得text的宽度
-(CGFloat)getTextWidth:(NSString *)text{
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont fontWithName:StringValueFromThemeKey(@"btn.mainLabel.fontName")
                                                                       size:FloatValueFromThemeKey(@"btn.mainLabel.fontSize")],
            NSForegroundColorAttributeName : UIColorValueFromThemeKey(@"btn.content.color"),
            NSBackgroundColorAttributeName : [UIColor clearColor]};
    NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:text attributes:attributes];
    return attrText.size.width + 20;
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
        CGFloat width = [self getTextWidth:_navItems[(NSUInteger) i]];
        [button setFrame:CGRectMake(x, 0, width, self.frame.size.height)];
        x += width;
        [button setTag:i + Tag_First_NavItem];
        [button setTitle:[NSString stringWithFormat:@"%@", _navItems[(NSUInteger) i]] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(bottomNavBtnTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];


        //添加右部分隔线,最后一个不添加
        if(i<_navItems.count-1){
            CALayer *rightLine = [LWRightSeparatorLayer layer];
            [button.layer addSublayer:rightLine];
            rightLine.backgroundColor = CGColorValueFromThemeKey(@"btn.borderColor");
            rightLine.frame = CGRectMake(button.frame.size.width-NarrowLine_W,0,NarrowLine_W,button.frame.size.height);

        }

        button.titleLabel.font = [UIFont fontWithName:StringValueFromThemeKey(@"btn.mainLabel.fontName")
                                                 size:FloatValueFromThemeKey(@"btn.mainLabel.fontSize")];
        [button setTitleColor:UIColorValueFromThemeKey(@"btn.content.color") forState:UIControlStateNormal];
        [button setTitleColor:UIColorValueFromThemeKey(@"btn.content.highlightColor") forState:UIControlStateHighlighted];
        
    }
    
}

//当选择一个分类
- (void)bottomNavBtnTouchUpInside:(UIButton *)btn {
    currentBtn = btn;
    self.updateTableDatasouce();
}


@end

@implementation LWEmojiDelBtn
@end

@implementation LWRightSeparatorLayer
@end

@implementation LWBottomSeparatorLayer
@end

@implementation LWLeftSeparatorLayer
@end