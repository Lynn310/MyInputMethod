//
//  LWGraphicPopView.m
//  MyInputMethod
//
//  Created by luowei on 16/2/18.
//  Copyright © 2016年 luowei. All rights reserved.
//

#import "LWGraphicPopView.h"
#import "LWDefines.h"
#import "LWBottomNavBar.h"
#import "MyKeyboardViewController.h"
#import "Categories.h"
#import "LWDataConfig.h"

static NSString *const GraphicCellId = @"GraphicCellId";

@implementation LWGraphicPopView{
    NSDictionary *_graphicDict;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.backgroundColor = UIColorValueFromThemeKey(@"popView.backgroundColor");

        //读取plist
        _graphicDict = [LWDataConfig getGraphicPlistDictionary];
        NSMutableArray *allValues = @[].mutableCopy;
        for(NSString *key in _graphicDict.allKeys){
            [allValues addObject:NSLocalizedString(key,nil)];
        }

        self.bottomNavBar = [[LWBottomNavBar alloc] initWithFrame:CGRectMake(0, (CGFloat) (frame.size.height - Toolbar_H), frame.size.width, Toolbar_H)
                                                  andNavItems:allValues andShowAdd:YES];
        _bottomNavBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addSubview:_bottomNavBar];
    
    
        //创建layout
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

        layout.minimumLineSpacing = 4;
        layout.minimumInteritemSpacing = 0;
        //设置cell的大小
        CGFloat cellSideLenght = (CGFloat) ((frame.size.height - Toolbar_H - layout.minimumLineSpacing) / 2);
        layout.itemSize = CGSizeMake(cellSideLenght, cellSideLenght);

        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - Toolbar_H)
                                                     collectionViewLayout:layout];
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
        _collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.alwaysBounceHorizontal = YES;
//        _collectionView.alwaysBounceVertical = YES;
        _collectionView.showsVerticalScrollIndicator = NO;

        [_collectionView registerClass:[LWGraphicCell class] forCellWithReuseIdentifier:GraphicCellId];
    
        [self addSubview:_collectionView];

        _collectionView.backgroundColor = UIColorValueFromThemeKey(@"popView.backgroundColor");
    
        __weak typeof(self) weakSelf = self;
        self.bottomNavBar.bottomNavScrollview.updateTableDatasouce = ^() {
            [weakSelf reloadCollection];
        };
    
    }

    return self;
}

- (void)reloadCollection {
    _graphicDict = [LWDataConfig getGraphicPlistDictionary];
    [_collectionView setContentOffset:CGPointMake(0, 0) animated:NO];
    [_collectionView reloadData];
}



- (void)layoutSubviews {
    [super layoutSubviews];
    _bottomNavBar.frame = CGRectMake(0, (CGFloat) (self.frame.size.height-Toolbar_H),self.frame.size.width,Toolbar_H);
    _collectionView.frame = CGRectMake(0,0,self.frame.size.width, (CGFloat) (self.frame.size.height-Toolbar_H));

    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)_collectionView.collectionViewLayout;
    CGFloat cellSideLenght = (CGFloat) ((_collectionView.frame.size.height - layout.minimumLineSpacing) / 2);
    layout.itemSize = CGSizeMake(cellSideLenght, cellSideLenght);
}


#pragma mark UICollectionDataSource Implementation

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    //两个section,一个选择颜色,一个选择图片
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSUInteger idx = (NSUInteger) (_bottomNavBar.bottomNavScrollview->currentBtn.tag - Tag_First_NavItem);
    NSString *group = _graphicDict.allKeys[idx];

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


@implementation LWGraphicCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //图片
        CGSize cellSize = self.frame.size;
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cellSize.width, cellSize.height - 14)];
        _iconImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
        _iconImageView.layer.masksToBounds = YES;
        _iconImageView.layer.cornerRadius = FloatValueFromThemeKey(@"btn.cornerRadius");
        [self.contentView addSubview:_iconImageView];
    
        //文字标题
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectIntegral(CGRectMake(-3.5, cellSize.height - self.maxCellTitleSize.height, cellSize.width + 7, self.maxCellTitleSize.height))];
        _titleLbl.text = @"";
        _titleLbl.font = [UIFont systemFontOfSize:12];
        _titleLbl.textColor = UIColorValueFromThemeKey(@"btn.content.color");
        _titleLbl.textAlignment = NSTextAlignmentCenter;
        _titleLbl.lineBreakMode = NSLineBreakByTruncatingTail;
        [self.contentView addSubview:_titleLbl];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGSize cellSize = self.frame.size;
    _iconImageView.frame = CGRectMake(0, 0, cellSize.width, cellSize.height - 14);
    _titleLbl.frame = CGRectIntegral(CGRectMake(-3.5, cellSize.height - self.maxCellTitleSize.height, cellSize.width + 7, self.maxCellTitleSize.height));
}


//cell titleLabel的最大大小
- (CGSize)maxCellTitleSize {
    return CGSizeMake(self.frame.size.width + 7, 14);
}

//给cell设置图片以及Text
-(void)setIconImage:(UIImage *)image withText:(NSString *)text{
    _iconImageView.image = image;
    _titleLbl.text = text;

    NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:12]};
    CGSize textSize = [text sizeWithAttributes:attrs];

    CGSize cellSize = self.bounds.size;
    CGFloat titleLblWidth = textSize.width > self.maxCellTitleSize.width ? self.maxCellTitleSize.width : textSize.width;

    self.titleLbl.center = CGPointMake((CGFloat) (cellSize.width * 0.5), (CGFloat) (cellSize.height - self.maxCellTitleSize.height * 0.5));
    self.titleLbl.bounds = CGRectMake(0, 0, titleLblWidth, self.maxCellTitleSize.height);
}

@end

