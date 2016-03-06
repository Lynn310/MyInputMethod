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
    
        //底边工具条
        _bottomToolBar = [[LWBottomToolBar alloc]initWithFrame:CGRectMake(0, (CGFloat) (frame.size.height-Toolbar_H),frame.size.width,Toolbar_H)];
        [self addSubview:_bottomToolBar];

        //左边分类选择
        NSArray *symbolNavs = [LWDataConfig getSymbolNavs];
        _leftNavScrollView = [[LWLeftNavScrollView alloc] initWithFrame:CGRectMake(0, 0, NavItem_W, frame.size.height- Toolbar_H) andNavItems:symbolNavs];
        [self addSubview:_leftNavScrollView];

        //右边符号内容
        CGRect gridFrame = CGRectMake(NavItem_W, 0, frame.size.width- NavItem_W, frame.size.height- Toolbar_H);
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake((frame.size.width- NavItem_W)/4, (frame.size.height- Toolbar_H)/4);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        _symbolGridView = [[LWSymbolGridView alloc] initWithFrame:gridFrame collectionViewLayout:layout];
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

    _bottomToolBar.frame = CGRectMake(0, (CGFloat) (self.frame.size.height-Toolbar_H),self.frame.size.width,Toolbar_H);
}

@end

//底部工具条
@implementation LWBottomToolBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
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

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;

    }

    return self;
}

#pragma mark UICollectionDataSource Implementation

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    //两个section,一个选择颜色,一个选择图片
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    id value = [LWDataConfig getUserDefaultValueByKey:Key_CurrentSymbol_Index];
    NSInteger idx = value ? ((NSNumber *) value).intValue : 0;

    NSString *group = [LWDataConfig getSymbolDictionary].allKeys[idx];

    NSDictionary *graphics = _graphicDict[group];
    NSUInteger numOfItems = graphics.count;
    return numOfItems;
}

- (LWGraphicCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LWGraphicCell *cell = (LWGraphicCell *) [collectionView dequeueReusableCellWithReuseIdentifier:GraphicCellId forIndexPath:indexPath];

    //获得group
    NSUInteger idx = (NSUInteger) (_bottomNavBar.bottomNavScrollview->currentBtn.tag - Tag_First_NavItem);
    NSString *group = _graphicDict.allKeys[idx];

    //获得group下的表情
    NSDictionary *graphics = _graphicDict[group];
    NSString *key = graphics.allKeys[(NSUInteger) indexPath.item];

    //根据表情字符串从指定路径读取图片
    NSString *graphicPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"graphics"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *imgName = [NSString stringWithFormat:@"%@.png",key];
    NSString *filePath = [[graphicPath stringByAppendingPathComponent:group] stringByAppendingPathComponent:imgName];
    if([fileManager fileExistsAtPath:filePath]) {
        UIImage *image = [UIImage imageWithContentsOfFile:filePath];
        [cell setIconImage:image withText:graphics[key]];
    }
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
    NSUInteger idx = (NSUInteger) (_bottomNavBar.bottomNavScrollview->currentBtn.tag - Tag_First_NavItem);
    NSString *group = _graphicDict.allKeys[idx];
    //获得group下的表情
    NSDictionary *graphics = _graphicDict[group];
    NSString *key = graphics.allKeys[(NSUInteger) indexPath.item];

    NSString *text = graphics[key];
    MyKeyboardViewController *kbVC = [self responderKBViewController];
    if(kbVC){
        [kbVC insertText:text];
    }
}

@end

