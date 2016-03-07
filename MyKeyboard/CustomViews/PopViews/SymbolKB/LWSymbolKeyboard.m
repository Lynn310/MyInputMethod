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
#import "UIImage+Color.h"

#define NavItem_W 60

#define SymbolGridViewCellId @"SymbolGridViewCell"

@implementation LWSymbolKeyboard{

}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.backgroundColor = [LWDataConfig getKBBackGroundColor];

        //底边工具条
        _bottomToolBar = [[LWBottomToolBar alloc] initWithFrame:CGRectMake(0, (CGFloat) (frame.size.height - Toolbar_H), frame.size.width, Toolbar_H)];
        [self addSubview:_bottomToolBar];

        //左边分类选择
        NSArray *symbolNavs = [LWDataConfig getSymbolNavs];
        _leftNavScrollView = [[LWLeftNavScrollView alloc] initWithFrame:CGRectMake(0, 0, NavItem_W, frame.size.height - Toolbar_H) andNavItems:symbolNavs];
        [self addSubview:_leftNavScrollView];

        //右边符号内容
        CGRect gridFrame = CGRectMake(NavItem_W, 0, frame.size.width - NavItem_W, frame.size.height - Toolbar_H);
        _symbolGridView = [[LWSymbolGridView alloc] initWithFrame:gridFrame collectionViewLayout:[UICollectionViewFlowLayout new]];
        [self addSubview:_symbolGridView];

        //重新加载数据block
        __weak LWSymbolGridView *weakSymbolGridView = _symbolGridView;
        _leftNavScrollView.updateTableDatasouce = ^() {
            [weakSymbolGridView reloadData];
        };
    }

    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    _bottomToolBar.frame = CGRectMake(0, (CGFloat) (self.frame.size.height - Toolbar_H), self.frame.size.width, Toolbar_H);
    _leftNavScrollView.frame = CGRectMake(0, 0, NavItem_W, self.frame.size.height - Toolbar_H);
    _symbolGridView.frame = CGRectMake(NavItem_W, 0, self.frame.size.width - NavItem_W, self.frame.size.height - Toolbar_H);
}

@end

//底部工具条
@implementation LWBottomToolBar{
//    LWTopSeparatorLayer *_topLine;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        //返回键
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setTitle:NSLocalizedString(@"Back", nil) forState:UIControlStateNormal];
        _backBtn.frame = CGRectMake(0, 0, NavItem_W, self.frame.size.height);
        [_backBtn addTarget:self action:@selector(backBtnTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_backBtn];
        //设置按键外观
        [self setBtnAppearance:_backBtn];

//        //添加上边线
//        _topLine = [LWTopSeparatorLayer layer];
//        [self.layer addSublayer:_topLine];
//        _topLine.backgroundColor = CGColorValueFromThemeKey(@"btn.borderColor");
//        _topLine.frame = CGRectMake(0, 0, self.bounds.size.width, NarrowLine_W);
    }

    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];

    CGFloat backWidth = NavItem_W;
    _backBtn.frame = CGRectMake(0, 0, backWidth, self.frame.size.height);
//    _topLine.frame = CGRectMake(0, 0, self.bounds.size.width, NarrowLine_W);
}

//返回键按下
- (void)backBtnTouchUpInside:(UIButton *)btn {
    [self.responderKBViewController backFromPopView];
}

//设置按键外观
- (void)setBtnAppearance:(UIButton *)btn {
    //back添加右部分隔线
    if ([btn.titleLabel.text isEqualToString:NSLocalizedString(@"Back", nil)]) {
        CALayer *rightLine = [LWRightSeparatorLayer layer];
        [btn.layer addSublayer:rightLine];
        rightLine.backgroundColor = CGColorValueFromThemeKey(@"btn.borderColor");
        rightLine.frame = CGRectMake(btn.frame.size.width - NarrowLine_W, 0, NarrowLine_W, btn.frame.size.height);
    }

    btn.titleLabel.font = [UIFont fontWithName:StringValueFromThemeKey(@"font.name")
                                          size:FloatValueFromThemeKey(@"btn.mainLabel.fontSize")];
    [btn setTitleColor:UIColorValueFromThemeKey(@"font.color") forState:UIControlStateNormal];
    [btn setTitleColor:UIColorValueFromThemeKey(@"font.highlightColor") forState:UIControlStateHighlighted];
}


@end

//左部符号分类区
@implementation LWLeftNavScrollView {
    NSArray *_navItems;
    CALayer *_rightLine;
}

- (instancetype)initWithFrame:(CGRect)frame andNavItems:(NSArray *)navItems {
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;

        self.pagingEnabled = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.scrollsToTop = NO;

        _navItems = navItems;

        self.contentSize = CGSizeMake(NavItem_W, self.frame.size.height / 4 * _navItems.count);

        //设置底部分类条
        [self setupBottomNavItemBtns];
        //默认设置当前item为第一个
        id value = [LWDataConfig getUserDefaultValueByKey:Key_CurrentSymbol_Index];
        NSInteger idx = value ? ((NSNumber *) value).intValue : 0;
        currentBtn = (UIButton *) [self viewWithTag:Tag_First_NavItem+idx];
        currentBtn.selected = YES;
        [self setContentOffset:CGPointMake(0,currentBtn.frame.origin.y) animated:NO];

        //添加右部分隔线
        _rightLine = [LWRightSeparatorLayer layer];
        [self.layer addSublayer:_rightLine];
        _rightLine.backgroundColor = CGColorValueFromThemeKey(@"btn.borderColor");
        _rightLine.frame = CGRectMake(self.frame.size.width - NarrowLine_W, 0, NarrowLine_W, self.contentSize.height);

    }

    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat navItem_H = self.frame.size.height / 4;
    self.contentSize = CGSizeMake(NavItem_W, navItem_H * _navItems.count);
    //更新分隔线位置
    for (CALayer *layer in self.layer.sublayers) {
        if ([layer isKindOfClass:[LWBottomSeparatorLayer class]]) {
            layer.frame = CGRectMake(0, layer.frame.size.height - NarrowLine_W, layer.frame.size.width, NarrowLine_W);
        }
    }
    _rightLine.frame = CGRectMake(self.frame.size.width - NarrowLine_W, 0, NarrowLine_W, self.contentSize.height);
}

- (void)rotationToInterfaceOrientation:(UIInterfaceOrientation)orientation {
    [super rotationToInterfaceOrientation:orientation];

    //屏幕发生旋转,需要刷新layout
    self.contentSize = CGSizeMake(NavItem_W, self.frame.size.height / 4 * _navItems.count);
    _rightLine.frame = CGRectMake(self.frame.size.width - NarrowLine_W, 0, NarrowLine_W, self.contentSize.height);
    [self setupBottomNavItemBtns];
}


//设置顶行分类滚动条的按钮
- (void)setupBottomNavItemBtns {

    UIColor *normalBGColor = [LWDataConfig getKBBackGroundColor];
    UIColor *selectedBGColor = [LWDataConfig getPopViewBackGroundColor];

    CGRect imgRect = CGRectMake(0, 0, NavItem_W, self.frame.size.width);
    UIImage *normalImg = [UIImage imageFromColor:normalBGColor withRect:imgRect];
    UIImage *selectecImg = [UIImage imageFromColor:selectedBGColor withRect:imgRect];

    //设置标签
    CGFloat y = 0;
    CGFloat navItem_H = self.frame.size.height / 4;
    for (int i = 0; i < [_navItems count]; i++) {

        UIButton *button = (UIButton *) [self viewWithTag:i + Tag_First_NavItem];
        if (!button) {
            button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTag:i + Tag_First_NavItem];
            [button setTitle:[NSString stringWithFormat:@"%@", _navItems[(NSUInteger) i]] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont fontWithName:StringValueFromThemeKey(@"font.name")
                                                     size:FloatValueFromThemeKey(@"btn.mainLabel.fontSize")];
            [button setTitleColor:UIColorValueFromThemeKey(@"font.color") forState:UIControlStateNormal];
            [button setTitleColor:UIColorValueFromThemeKey(@"font.highlightColor") forState:UIControlStateHighlighted];

            [button addTarget:self action:@selector(bottomNavBtnTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
        }
        button.frame = CGRectMake(0, y, NavItem_W, navItem_H);
        y += navItem_H;

        [button setBackgroundImage:normalImg forState:UIControlStateNormal];
        [button setBackgroundImage:selectecImg forState:UIControlStateSelected];

        //底部分隔线,最后一个不添加
        if (i < _navItems.count - 1) {
            BOOL hasBottomeLine = NO;
            for(CALayer *bLine in button.layer.sublayers){
                if([bLine isKindOfClass:[LWBottomSeparatorLayer class]]){
                    hasBottomeLine = YES;
                    bLine.frame = CGRectMake(0, button.frame.size.height - NarrowLine_W, button.frame.size.width, NarrowLine_W);
                }
            }
            if(!hasBottomeLine){
                CALayer *bottomLine = [LWBottomSeparatorLayer layer];
                [button.layer addSublayer:bottomLine];
                bottomLine.backgroundColor = CGColorValueFromThemeKey(@"btn.borderColor");
                bottomLine.frame = CGRectMake(0, button.frame.size.height - NarrowLine_W, button.frame.size.width, NarrowLine_W);
            }
        }


    }
}

//当选择一个分类
- (void)bottomNavBtnTouchUpInside:(UIButton *)btn {
    for(UIView *v in self.subviews){
        if([v isKindOfClass:[UIButton class]] && ![v isEqual:btn]){
            ((UIButton *)v).selected = NO;
        }
    }
    btn.selected = YES;
    currentBtn = btn;
    [LWDataConfig setUserDefaultValue:@(btn.tag - Tag_First_NavItem) withKey:Key_CurrentSymbol_Index];
    self.updateTableDatasouce();
}


@end


//右部符号内容区
@implementation LWSymbolGridView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewFlowLayout *)layout {
    layout.itemSize = CGSizeMake(frame.size.width / 4, frame.size.height / 4);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;

    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.backgroundColor = [LWDataConfig getPopViewBackGroundColor];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.pagingEnabled = YES;
        self.dataSource = self;
        self.delegate = self;
    }

    [self registerClass:[LWSymbolGridViewCell class] forCellWithReuseIdentifier:SymbolGridViewCellId];

    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)rotationToInterfaceOrientation:(UIInterfaceOrientation)orientation {
    [super rotationToInterfaceOrientation:orientation];

    //屏幕发生旋转,需要刷新layout
    [self.collectionViewLayout invalidateLayout];
}


- (void)reloadData {
    [super reloadData];
    [self setContentOffset:CGPointZero animated:NO];
}


#pragma mark UICollectionDataSource Implementation

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    //两个section,一个选择颜色,一个选择图片
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    id value = [LWDataConfig getUserDefaultValueByKey:Key_CurrentSymbol_Index];
    NSInteger idx = value ? ((NSNumber *) value).intValue : 0;

    NSDictionary *symbolDict = [LWDataConfig getSymbolDictionary];
    NSString *group = symbolDict.allKeys[idx];

    NSDictionary *graphics = symbolDict[group];
    NSUInteger numOfItems = graphics.count;
    return numOfItems;
}

- (LWSymbolGridViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LWSymbolGridViewCell *cell = (LWSymbolGridViewCell *) [collectionView dequeueReusableCellWithReuseIdentifier:SymbolGridViewCellId forIndexPath:indexPath];

    //获得group
    id value = [LWDataConfig getUserDefaultValueByKey:Key_CurrentSymbol_Index];
    NSInteger idx = value ? ((NSNumber *) value).intValue : 0;

    NSDictionary *symbolDict = [LWDataConfig getSymbolDictionary];
    NSString *group = symbolDict.allKeys[idx];

    //获得group下的表情
    NSArray *symbols = symbolDict[group];
    NSString *text = symbols[(NSUInteger) indexPath.item];
    [cell setCellBtnWithText:text];

    return cell;
}


#pragma mark - UICollectionDelegate Implementation

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    LWGraphicCell *cell = (LWGraphicCell *) [collectionView cellForItemAtIndexPath:indexPath];
    //获得group
    id value = [LWDataConfig getUserDefaultValueByKey:Key_CurrentSymbol_Index];
    NSInteger idx = value ? ((NSNumber *) value).intValue : 0;

    NSDictionary *symbolDict = [LWDataConfig getSymbolDictionary];
    NSString *group = symbolDict.allKeys[idx];

    //获得group下的表情
    NSArray *symbols = symbolDict[group];
    NSString *text = symbols[(NSUInteger) indexPath.item];

    MyKeyboardViewController *kbVC = [self responderKBViewController];
    if (kbVC) {
        [kbVC insertText:text];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize cellSize = CGSizeMake(self.frame.size.width / 4, self.frame.size.height / 4);
    if(Screen_W > Screen_H){
        cellSize = CGSizeMake(self.frame.size.width / 6, self.frame.size.height / 4);
    }
    return cellSize;
}


@end


@implementation LWSymbolGridViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _textLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_textLabel];

        _textLabel.textColor = UIColorValueFromThemeKey(@"font.color");
        NSString *fontName = StringValueFromThemeKey(@"font.name");
        CGFloat fontSize = FloatValueFromThemeKey(@"btn.mainLabel.fontSize");
        _textLabel.font = [UIFont fontWithName:fontName size:fontSize];

        //添加右边线
        CALayer *rightLine = [LWRightSeparatorLayer layer];
        [self.layer addSublayer:rightLine];
        rightLine.backgroundColor = CGColorValueFromThemeKey(@"btn.borderColor");
        rightLine.frame = CGRectMake(self.bounds.size.width - NarrowLine_W, 0, NarrowLine_W, self.bounds.size.height);

        //添加底边线
        CALayer *bottomLine = [LWBottomSeparatorLayer layer];
        [self.layer addSublayer:bottomLine];
        bottomLine.backgroundColor = CGColorValueFromThemeKey(@"btn.borderColor");
        bottomLine.frame = CGRectMake(0, self.bounds.size.height - NarrowLine_W, self.bounds.size.width, NarrowLine_W);
    }

    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    [self setCellBtnWithText:_textLabel.text];

    //更新分隔线位置
    for (CALayer *layer in self.layer.sublayers) {
        if ([layer isKindOfClass:[LWRightSeparatorLayer class]]) {
            layer.frame = CGRectMake(layer.superlayer.bounds.size.width - NarrowLine_W, 0, NarrowLine_W, layer.superlayer.bounds.size.height);
        }
        if ([layer isKindOfClass:[LWBottomSeparatorLayer class]]) {
            layer.frame = CGRectMake(0, self.bounds.size.height - NarrowLine_W, self.bounds.size.width, NarrowLine_W);
        }
    }
}

- (void)rotationToInterfaceOrientation:(UIInterfaceOrientation)orientation {
    [super rotationToInterfaceOrientation:orientation];

    [self setCellBtnWithText:_textLabel.text];
}


//根据text设置Btn
- (void)setCellBtnWithText:(NSString *)text {
    _textLabel.text = text;

    NSString *fontName = StringValueFromThemeKey(@"font.name");
    CGFloat fontSize = FloatValueFromThemeKey(@"btn.mainLabel.fontSize");


    NSDictionary *attributes = @{NSFontAttributeName : [UIFont fontWithName:fontName size:fontSize]};
    CGSize textSize = [text sizeWithAttributes:attributes];

    //大于总宽度时，缩小字体
    while (textSize.width > self.frame.size.width) {
        fontSize--;
        attributes = @{NSFontAttributeName : [UIFont fontWithName:fontName size:fontSize]};
        textSize = [text sizeWithAttributes:attributes];
    }
    _textLabel.font = [UIFont fontWithName:fontName size:fontSize];
    _textLabel.bounds = CGRectMake(0,0,textSize.width + 4,self.bounds.size.height);
    _textLabel.center = CGPointMake(self.bounds.size.width/2,self.bounds.size.height/2);
}

@end