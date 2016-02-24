//
//  LWEmoticonPopView.m
//  MyInputMethod
//
//  Created by luowei on 16/2/18.
//  Copyright © 2016年 luowei. All rights reserved.
//

#import "LWEmoticonPopView.h"
#import "LWDefines.h"
#import "LWBottomNavBar.h"
#import "Categories.h"
#import "UIImage+Color.h"

static NSString *const EmoticonCellId = @"EmoticonCellId";

static NSString *const EmoticonRightSeparatorId = @"EmoticonSeparatorId";
static NSString *const EmoticonBottomSeparatorId = @"EmoticonBottomSeparatorId";

@implementation LWEmoticonPopView {
    NSDictionary *_emoticonDict;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.backgroundColor = UIColorValueFromThemeKey(@"popView.backgroundColor");

        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.backgroundColor = UIColorValueFromThemeKey(@"popView.backgroundColor");

        NSDictionary *iniDict = [self getEmoticonDictionary];
        NSArray *bottomNavItems = [LWThemeManager getArrByKey:Key_BottomNavEmoticonItems withDefaultArr:iniDict.allKeys];
        _bottomNavBar = [[LWBottomNavBar alloc] initWithFrame:CGRectMake(0, (CGFloat) (frame.size.height - Toolbar_H), frame.size.width, Toolbar_H)
                                                  andNavItems:bottomNavItems];
        _bottomNavBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addSubview:_bottomNavBar];


        //创建layout
//        LWCollectionFlowLayout *layout = [[LWCollectionFlowLayout alloc] init];
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);

        //layout.headerReferenceSize = CGSizeMake(0,self.frame.size.height);

        //设置分隔线
//        [layout registerClass:[LWEmoticonRightSeparator class] forDecorationViewOfKind:EmoticonRightSeparatorId];
//        [layout registerClass:[LWEmoticonBottomSeparator class] forDecorationViewOfKind:EmoticonBottomSeparatorId];
//        [layout registerClass:[LWEmoticonCell class] forDecorationViewOfKind:EmoticonCellId];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;

        //设置cell的大小
        CGFloat cellSideLenght = (CGFloat) ((frame.size.height - Toolbar_H) / 4);
        layout.estimatedItemSize = CGSizeMake(cellSideLenght, cellSideLenght);

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
        _collectionView.pagingEnabled  = YES;

        [_collectionView registerClass:[LWEmoticonCell class] forCellWithReuseIdentifier:EmoticonCellId];

        [self addSubview:_collectionView];

        _collectionView.backgroundColor = UIColorValueFromThemeKey(@"popView.backgroundColor");

        //初始数据源
        _emoticonDict = [self getEmoticonDictionary];

        __weak typeof(self) weakSelf = self;
        self.bottomNavBar.bottomNavScrollview.updateTableDatasouce = ^() {
            [weakSelf reloadCollection];
        };
    }

    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _bottomNavBar.frame = CGRectMake(0, (CGFloat) (self.frame.size.height - Toolbar_H), self.frame.size.width, Toolbar_H);
    //[self collectionView:_collectionView layout:_collectionView.collectionViewLayout sizeForItemAtIndexPath:]
    [_collectionView reloadData];
}

//获得Emoji数据
- (NSDictionary *)getEmoticonDictionary {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"emoticon" ofType:@"ini"];
    NSString *emojiIniStr = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSDictionary *iniDict = [NSDictionary dictFromEmoticonIni:emojiIniStr];
    return iniDict;
}

- (void)reloadCollection {
    _emoticonDict = [self getEmoticonDictionary];
}

#pragma mark UICollectionDataSource Implementation

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    //两个section,一个选择颜色,一个选择图片
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSUInteger idx = (NSUInteger) (_bottomNavBar.bottomNavScrollview->currentBtn.tag - Tag_First_NavItem);

    NSString *key = _emoticonDict.allKeys[idx];
    NSUInteger numOfItems = ((NSArray *) _emoticonDict[key]).count;
    return numOfItems;
}

- (LWEmoticonCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LWEmoticonCell *cell = (LWEmoticonCell *) [collectionView dequeueReusableCellWithReuseIdentifier:EmoticonCellId forIndexPath:indexPath];

    NSUInteger idx = (NSUInteger) (_bottomNavBar.bottomNavScrollview->currentBtn.tag - Tag_First_NavItem);
    NSString *key = _emoticonDict.allKeys[idx];
    NSString *text = (NSString *) ((NSArray *) _emoticonDict[key])[(NSUInteger) indexPath.item];

//    [cell setCellBtnWithText:text];
//    [cell.emoticonBtn setTitle:text forState:UIControlStateNormal];
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
    LWEmoticonCell *cell = (LWEmoticonCell *) [collectionView cellForItemAtIndexPath:indexPath];

}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    //Cell
    NSUInteger idx = (NSUInteger) (_bottomNavBar.bottomNavScrollview->currentBtn.tag - Tag_First_NavItem);
    NSString *key = _emoticonDict.allKeys[idx];
    NSString *text = (NSString *) ((NSArray *) _emoticonDict[key])[(NSUInteger) indexPath.item];

    NSString *fontName = StringValueFromThemeKey(@"btn.mainLabel.fontName");
    CGFloat fontSize = FloatValueFromThemeKey(@"btn.mainLabel.fontSize");
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont fontWithName:fontName size:fontSize],
            NSForegroundColorAttributeName : [UIColor blackColor],
            NSBackgroundColorAttributeName : [UIColor clearColor]};

    CGSize titleSize = [text sizeWithAttributes:attributes];
    CGSize collectionSize = collectionView.frame.size;

    CGFloat cellSideLenght = (CGFloat) collectionSize.height / 4;
    CGSize cellSize = CGSizeMake(cellSideLenght, cellSideLenght);

    //大于总宽度时，缩小字体
    while (titleSize.width > collectionSize.width) {
        fontSize--;
        attributes = @{NSFontAttributeName : [UIFont fontWithName:fontName size:fontSize],
                NSForegroundColorAttributeName : [UIColor blackColor],
                NSBackgroundColorAttributeName : [UIColor clearColor]};
        titleSize = [text sizeWithAttributes:attributes];
    }

    //小于总宽度，大于总宽度1/2时,设为总宽度
    if (collectionSize.width > titleSize.width && titleSize.width > collectionSize.width / 2) {
        titleSize = CGSizeMake(collectionSize.width, cellSize.height);

        //小于总宽度1/2，大于总宽度1/4时，设为总宽度1/2
    }else if (collectionSize.width / 2 > titleSize.width && titleSize.width > collectionSize.width / 4) {
        titleSize = CGSizeMake(collectionSize.width / 2, cellSize.height);

        //小于总宽度1/4，设为总宽度1/4
    }else if (titleSize.width < collectionSize.width / 4) {
        titleSize = CGSizeMake(collectionSize.width / 4, cellSize.height);
    }
    return CGSizeMake(titleSize.width , cellSize.height);;
}


@end


@implementation LWEmoticonCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _emoticonBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _emoticonBtn.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
//        _emoticonBtn.titleLabel.backgroundColor = [UIColor yellowColor];
        _emoticonBtn.layer.borderWidth = 1;
        _emoticonBtn.contentMode = UIViewContentModeCenter;
        _emoticonBtn.imageView.contentMode = UIViewContentModeCenter;
        _emoticonBtn.titleLabel.hidden = YES;
        [self addSubview:_emoticonBtn];
    }

    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _emoticonBtn.frame = self.bounds;
}

//根据text设置Btn
- (void)setCellBtnWithText:(NSString *)text {
    _emoticonBtn.titleLabel.hidden = YES;
    _emoticonBtn.titleLabel.text = text;

    NSString *fontName = StringValueFromThemeKey(@"btn.mainLabel.fontName");
    CGFloat fontSize = FloatValueFromThemeKey(@"btn.mainLabel.fontSize");
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont fontWithName:fontName size:fontSize],
            NSForegroundColorAttributeName : [UIColor blackColor],
            NSBackgroundColorAttributeName : [UIColor clearColor]};
    CGSize textSize = [text sizeWithAttributes:attributes];

    //大于总宽度时，缩小字体
    while (textSize.width > _emoticonBtn.frame.size.width) {
        fontSize--;
        attributes = @{NSFontAttributeName : [UIFont fontWithName:fontName size:fontSize - 1],
                NSForegroundColorAttributeName : [UIColor blackColor],
                NSBackgroundColorAttributeName : [UIColor clearColor]};
        textSize = [text sizeWithAttributes:attributes];
    }
    UIImage *textImg = [UIImage imageFromString:text attributes:attributes size:textSize];

    [_emoticonBtn setImage:textImg forState:UIControlStateNormal];
}

@end


@implementation LWEmoticonRightSeparator

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorValueFromThemeKey(@"btn.borderColor");
    }

    return self;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    self.frame = layoutAttributes.frame;
}

@end

@implementation LWEmoticonBottomSeparator

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorValueFromThemeKey(@"btn.borderColor");
    }

    return self;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    self.frame = layoutAttributes.frame;
}

@end


@implementation LWCollectionFlowLayout

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *layoutAttributesArray = [super layoutAttributesForElementsInRect:rect];

    CGFloat lineWidth = self.minimumLineSpacing;
    NSMutableArray *decorationAttributes = [[NSMutableArray alloc] initWithCapacity:layoutAttributesArray.count];

    for (UICollectionViewLayoutAttributes *layoutAttributes in layoutAttributesArray) {
        //Add separator for every row
        NSIndexPath *indexPath = layoutAttributes.indexPath;
        CGRect cellFrame = layoutAttributes.frame;

        //Cell
        LWEmoticonCell *cell = (LWEmoticonCell *) [self.collectionView cellForItemAtIndexPath:indexPath];

        NSString *fontName = StringValueFromThemeKey(@"btn.mainLabel.fontName");
        CGFloat fontSize = FloatValueFromThemeKey(@"btn.mainLabel.fontSize");
        NSDictionary *attributes = @{NSFontAttributeName : [UIFont fontWithName:fontName size:fontSize],
                NSForegroundColorAttributeName : [UIColor blackColor],
                NSBackgroundColorAttributeName : [UIColor clearColor]};

        NSString *text = cell.emoticonBtn.titleLabel.text;
        CGSize titleSize = [text sizeWithAttributes:attributes];
        CGSize rectSize = self.collectionView.frame.size;

        //大于总宽度时，缩小字体
        while (titleSize.width > rectSize.width) {
            attributes = @{NSFontAttributeName : [UIFont fontWithName:fontName size:fontSize - 1],
                    NSForegroundColorAttributeName : [UIColor blackColor],
                    NSBackgroundColorAttributeName : [UIColor clearColor]};
            titleSize = [text sizeWithAttributes:attributes];
        }
        //小于总宽度，大于总宽度1/2时,设为总宽度
        if (rectSize.width > titleSize.width > rectSize.width / 2) {
            titleSize = CGSizeMake(rectSize.width / 2, rectSize.height);
        }
        //小于总宽度1/2，大于总宽度1/4时，设为总宽度1/2
        if (rectSize.width / 2 > titleSize.width > rectSize.width / 4) {
            titleSize = CGSizeMake(rectSize.width / 2, rectSize.height);
        }
        //小于总宽度1/4，设为总宽度1/4
        if (titleSize.width < rectSize.width / 4) {
            titleSize = CGSizeMake(rectSize.width / 4, rectSize.height);
        }
        cellFrame.size = titleSize;
        layoutAttributes.frame = cellFrame;
        [decorationAttributes addObject:layoutAttributes];

//        //右边线
//        UICollectionViewLayoutAttributes *rightSeparatorAttributes = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:EmoticonRightSeparatorId withIndexPath:indexPath];
//        rightSeparatorAttributes.frame = CGRectMake(cellFrame.origin.x + cellFrame.size.width - lineWidth, cellFrame.origin.y, lineWidth, cellFrame.size.height);
//        [decorationAttributes addObject:rightSeparatorAttributes];
//
//        //底边线
//        UICollectionViewLayoutAttributes *bottomSeparatorAttributes = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:EmoticonBottomSeparatorId withIndexPath:indexPath];
//        bottomSeparatorAttributes.frame = CGRectMake(cellFrame.origin.x, cellFrame.origin.y+cellFrame.size.height-lineWidth, cellFrame.size.width,lineWidth);
//        [decorationAttributes addObject:bottomSeparatorAttributes];


    }
    return [layoutAttributesArray arrayByAddingObjectsFromArray:decorationAttributes];
}


//- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
//    //collect here layout attributes for cells
//    NSArray *layoutAttributesArray = [super layoutAttributesForElementsInRect:rect];
//
//    NSMutableArray *decorationAttributes = [NSMutableArray array];
//    NSArray *visibleIndexPaths = [self indexPathsOfSeparatorsInRect:rect]; // will implement below
//
//    for (NSIndexPath *indexPath in visibleIndexPaths) {
//        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForDecorationViewOfKind:EmoticonSeparatorId atIndexPath:indexPath];
//        [decorationAttributes addObject:attributes];
//    }
//
//    return [layoutAttributesArray arrayByAddingObjectsFromArray:decorationAttributes];
//}
//
//- (NSArray*)indexPathsOfSeparatorsInRect:(CGRect)rect {
//    NSInteger firstCellIndexToShow = floorf(rect.origin.y / self.itemSize.height);
//    NSInteger lastCellIndexToShow = floorf((rect.origin.y + CGRectGetHeight(rect)) / self.itemSize.height);
//    NSInteger countOfItems = [self.collectionView.dataSource collectionView:self.collectionView numberOfItemsInSection:0];
//
//    NSMutableArray* indexPaths = [NSMutableArray new];
//    for (int i = MAX(firstCellIndexToShow, 0); i <= lastCellIndexToShow; i++) {
//        if (i < countOfItems) {
//            [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
//        }
//    }
//    return indexPaths;
//}
//
//- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)decorationViewKind atIndexPath:(NSIndexPath *)indexPath {
//    UICollectionViewLayoutAttributes *layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:decorationViewKind withIndexPath:indexPath];
//    CGFloat decorationOffset = (indexPath.row + 1) * self.itemSize.height + indexPath.row * self.minimumLineSpacing;
//    layoutAttributes.frame = CGRectMake(0.0, decorationOffset, self.collectionViewContentSize.width, self.minimumLineSpacing);
//    layoutAttributes.zIndex = 1000;
//
//    return layoutAttributes;
//}
//
//- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingDecorationElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)decorationIndexPath {
//    UICollectionViewLayoutAttributes *layoutAttributes =  [self layoutAttributesForDecorationViewOfKind:elementKind atIndexPath:decorationIndexPath];
//    return layoutAttributes;
//}
//


@end