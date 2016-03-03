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
#import "MyKeyboardViewController.h"
#import "LWDataConfig.h"

static NSString *const EmoticonCellId = @"EmoticonCellId";


@implementation LWEmoticonPopView {
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.backgroundColor = [LWDataConfig getPopViewBackGroundColor];

        NSDictionary *iniDict = [LWDataConfig getEmoticonDictionary];
        NSArray *bottomNavItems = [LWThemeManager getArrByKey:Key_BottomNavEmoticonItems withDefaultArr:iniDict.allKeys];
        _bottomNavBar = [[LWBottomNavBar alloc] initWithFrame:CGRectMake(0, (CGFloat) (frame.size.height - Toolbar_H), frame.size.width, Toolbar_H)
                                                  andNavItems:bottomNavItems andShowAdd:NO];
        _bottomNavBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addSubview:_bottomNavBar];


        //创建layout
        LWCollectionFlowLayout *layout = [[LWCollectionFlowLayout alloc] init];

        //设置cell的大小
        CGFloat cellSideLenght = (CGFloat) ((frame.size.height - Toolbar_H) / 4);
        layout.estimatedItemSize = CGSizeMake((frame.size.width / 4), cellSideLenght);

        _collectionView = [[LWEmoticonCollectionView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - Toolbar_H)
                                                     collectionViewLayout:layout];
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

        _collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = YES;
        _collectionView.alwaysBounceHorizontal = YES;
//        _collectionView.alwaysBounceVertical = YES;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;

        [_collectionView registerClass:[LWEmoticonCell class] forCellWithReuseIdentifier:EmoticonCellId];

        [self addSubview:_collectionView];

        _collectionView.backgroundColor = [LWDataConfig getPopViewBackGroundColor];

        //初始数据源
        _collectionView.emotions = [self getEmoticons];

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
//    [_collectionView reloadData];
//    [_collectionView.collectionViewLayout invalidateLayout];
}

//重新reloadCollection
- (void)reloadCollection {
    [_collectionView setContentOffset:CGPointMake(0, 0) animated:NO];
    [_collectionView reloadData:[self getEmoticons]];
}

//获得当前分类下的emoticons
- (NSArray *)getEmoticons {
    NSDictionary *emoticonDict = [LWDataConfig getEmoticonDictionary];
    NSUInteger idx = (NSUInteger) (_bottomNavBar.bottomNavScrollview->currentBtn.tag - Tag_First_NavItem);

    NSString *key = emoticonDict.allKeys[idx];
    NSArray *emoticons = (NSArray *) emoticonDict[key];
    return emoticons;
}


#pragma mark UICollectionDataSource Implementation

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    //两个section,一个选择颜色,一个选择图片
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    NSArray *emoticons = [self getEmoticons];
    NSUInteger numOfItems = emoticons.count;
    return numOfItems;
}

- (LWEmoticonCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LWEmoticonCell *cell = (LWEmoticonCell *) [collectionView dequeueReusableCellWithReuseIdentifier:EmoticonCellId forIndexPath:indexPath];

    NSArray *emoticons = [self getEmoticons];
    NSString *text = (NSString *) emoticons[(NSUInteger) indexPath.item];

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
    //LWEmoticonCell *cell = (LWEmoticonCell *) [collectionView cellForItemAtIndexPath:indexPath];

    NSArray *emoticons = [self getEmoticons];
    NSString *text = (NSString *) emoticons[(NSUInteger) indexPath.item];
    MyKeyboardViewController *kbVC = [self responderKBViewController];
    if(kbVC){
        [kbVC insertText:text];
    }
}

@end


@implementation LWEmoticonCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _emoticonBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _emoticonBtn.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        _emoticonBtn.contentMode = UIViewContentModeCenter;
        _emoticonBtn.imageView.contentMode = UIViewContentModeCenter;
        _emoticonBtn.titleLabel.hidden = NO;
        _emoticonBtn.userInteractionEnabled = NO;
        [self addSubview:_emoticonBtn];

        //添加右边线
        CALayer *rightLine = [LWRightSeparatorLayer layer];
        [self.layer addSublayer:rightLine];
        rightLine.backgroundColor = CGColorValueFromThemeKey(@"btn.borderColor");
        rightLine.frame = CGRectMake(self.bounds.size.width-NarrowLine_W,0,NarrowLine_W,self.bounds.size.height);

        //添加底边线
        CALayer *bottomLine = [LWBottomSeparatorLayer layer];
        [self.layer addSublayer:bottomLine];
        bottomLine.backgroundColor = CGColorValueFromThemeKey(@"btn.borderColor");
        bottomLine.frame = CGRectMake(0,self.bounds.size.height - NarrowLine_W,self.bounds.size.width,NarrowLine_W);
    }

    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _emoticonBtn.frame = self.bounds;
    //更新分隔线位置
    for(CALayer *layer in self.layer.sublayers){
        if([layer isKindOfClass:[LWRightSeparatorLayer class]]){
            layer.frame = CGRectMake(layer.superlayer.bounds.size.width-NarrowLine_W,0,NarrowLine_W,layer.superlayer.bounds.size.height);
        }
        if([layer isKindOfClass:[LWBottomSeparatorLayer class]]){
            layer.frame = CGRectMake(0,self.bounds.size.height - NarrowLine_W,self.bounds.size.width,NarrowLine_W);
        }
    }
}

//根据text设置Btn
- (void)setCellBtnWithText:(NSString *)text {
    _emoticonBtn.titleLabel.hidden = YES;
    _emoticonBtn.titleLabel.text = text;

    NSString *fontName = StringValueFromThemeKey(@"font.name");
    CGFloat fontSize = FloatValueFromThemeKey(@"btn.mainLabel.fontSize");
//    NSDictionary *attributes = @{NSFontAttributeName : [UIFont fontWithName:fontName size:fontSize],
//            NSForegroundColorAttributeName : [UIColor blackColor],
//            NSBackgroundColorAttributeName : [UIColor clearColor]};
//    CGSize textSize = [text sizeWithAttributes:attributes];
//
//    //大于总宽度时，缩小字体
//    while (textSize.width > _emoticonBtn.frame.size.width) {
//        fontSize--;
//        attributes = @{NSFontAttributeName : [UIFont fontWithName:fontName size:fontSize],
//                NSForegroundColorAttributeName : [UIColor blackColor],
//                NSBackgroundColorAttributeName : [UIColor clearColor]};
//        textSize = [text sizeWithAttributes:attributes];
//    }
//    UIImage *textImg = [UIImage imageFromString:text attributes:attributes size:textSize];
//    [_emoticonBtn setImage:textImg forState:UIControlStateNormal];



    NSDictionary *attributes = @{NSFontAttributeName : [UIFont fontWithName:fontName size:fontSize]};
    CGSize textSize = [text sizeWithAttributes:attributes];

    //大于总宽度时，缩小字体
    while (textSize.width > _emoticonBtn.frame.size.width) {
        fontSize--;
        attributes = @{NSFontAttributeName : [UIFont fontWithName:fontName size:fontSize]};
        textSize = [text sizeWithAttributes:attributes];
    }

    _emoticonBtn.titleLabel.font = [UIFont fontWithName:fontName size:fontSize];
    [_emoticonBtn setTitle:text forState:UIControlStateNormal];
}

@end


@implementation LWEmoticonCollectionView

- (void)reloadData:(NSArray *)dataSource {
    _emotions = dataSource;
//    [self.collectionViewLayout invalidateLayout];
    [self reloadData];
}

//根据indexPath取得text的大小
- (CGSize)getTextSizeFromItem:(NSUInteger)indexPathItem {
    NSString *text = (NSString *) self.emotions[indexPathItem];

    NSString *fontName = StringValueFromThemeKey(@"font.name");
    CGFloat fontSize = FloatValueFromThemeKey(@"btn.mainLabel.fontSize");
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont fontWithName:fontName size:fontSize]};

    CGSize textSize = [text sizeWithAttributes:attributes];

    //~~~~~ 根据text计算cellSize ~~~~~
    //大于总宽度时，缩小字体
    CGSize collectionSize = self.frame.size;
    while (textSize.width > collectionSize.width) {
        fontSize--;
        attributes = @{NSFontAttributeName : [UIFont fontWithName:fontName size:fontSize]};
        textSize = [text sizeWithAttributes:attributes];
    }
    return textSize;
}


@end


//可选方案
//UICollectionView Horizontal Scroll with Horizontal Alignment:http://stackoverflow.com/questions/25963987/uicollectionview-horizontal-scroll-with-horizontal-alignment
//UICollectionView horizontal paging : http://stackoverflow.com/questions/16678474/uicollectionview-horizontal-paging-can-i-use-flow-layout
//RDHCollectionViewGridLayout:https://github.com/rhodgkins/RDHCollectionViewGridLayout
//创建自定义UICollectionView layout: http://www.jianshu.com/p/40868928a1cf

@implementation LWCollectionFlowLayout {
    NSInteger _cellCount;
    CGRect _cllectionBounds;
    NSMutableArray *_allAttributes;
    NSMutableDictionary *_maxX;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.minimumLineSpacing = 0;
        self.minimumInteritemSpacing = 0;
        self.nbColumns = -1;
        self.nbLines = -1;
    }
    return self;
}

- (void)invalidateLayout {
    [super invalidateLayout];
}


- (void)prepareLayout {
//    Log(@"--------%d:%s \n\n", __LINE__, __func__);
    // Get the number of cells and the bounds size
    _cellCount = [self.collectionView numberOfItemsInSection:0];
    _cllectionBounds = self.collectionView.bounds;
    _allAttributes = [NSMutableArray arrayWithCapacity:(NSUInteger) _cellCount];

    //约定1行,1列都为4个unit单位
    _maxX = @{
              @(0):@(0.0),
              @(1):@(0.0),
              @(2):@(0.0),
              @(3):@(0.0),
              }.mutableCopy;
    NSUInteger row = 0;
    for (NSUInteger i = 0; i < _cellCount; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];

        CGSize collectionSize = _cllectionBounds.size;
        CGSize textSize = [self getTextUnitSizeFromItem:(NSUInteger) indexPath.item];

        CGFloat x = [_maxX[@(row)] floatValue];
        CGFloat y = row * textSize.height;
        //如果此行剩下的空间容不下这个text，把它前的text区域改大，并修改row和x
        CGFloat unuseWidth = (CGFloat) (collectionSize.width - fmod(x, collectionSize.width));
        if (unuseWidth < textSize.width) {
            UICollectionViewLayoutAttributes *preAttr = _allAttributes.lastObject;
            if (preAttr) {
                preAttr.frame = CGRectMake(preAttr.frame.origin.x, preAttr.frame.origin.y,
                                           preAttr.frame.size.width + unuseWidth, preAttr.frame.size.height);
            }
            _maxX[@(row)] = @(x + unuseWidth);
            row = (row+1)>=4?0:(row+1);
            x = [_maxX[@(row)] floatValue];
            y = row * textSize.height;
            unuseWidth = (CGFloat) (collectionSize.width - fmod(x, collectionSize.width));
        }
        
        _maxX[@(row)] = @(x + textSize.width);
        
        attr.frame = CGRectMake(x, y, textSize.width, textSize.height);
        
        if (unuseWidth == textSize.width) {
            row = (row+1)>=4?0:(row+1);
        }

        [_allAttributes addObject:attr];
    }

}

- (CGSize)getTextUnitSizeFromItem:(NSUInteger)item {
    LWEmoticonCollectionView *collectionView = (LWEmoticonCollectionView *) (self.collectionView);
    if (item >= collectionView.emotions.count) {
        return CGSizeMake(0, 0);
    }
    CGSize cellSize = CGSizeMake(_cllectionBounds.size.width / 4, _cllectionBounds.size.height / 4);

    CGSize textSize = [collectionView getTextSizeFromItem:item];
    if (textSize.width > cellSize.width * 4) {
        textSize = CGSizeMake(cellSize.width * 4, cellSize.height);
        //小于总宽度，大于总宽度1/2时,设为总宽度
    } else if (cellSize.width * 4 > textSize.width && textSize.width > cellSize.width * 2) {
        textSize = CGSizeMake(cellSize.width * 4, cellSize.height);
        //小于总宽度1/2，大于总宽度1/4时，设为总宽度1/2
    } else if (cellSize.width * 2 > textSize.width && textSize.width > cellSize.width) {
        textSize = CGSizeMake(cellSize.width * 2, cellSize.height);
        //小于总宽度1/4，设为总宽度1/4
    } else if (textSize.width < cellSize.width) {
        textSize = CGSizeMake(cellSize.width, cellSize.height);
    }
    return textSize;
}


- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    return [super targetContentOffsetForProposedContentOffset:proposedContentOffset withScrollingVelocity:velocity];
}


- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    return _allAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    Log(@"**************** %d:%s \n\n", __LINE__, __func__);
    return (UICollectionViewLayoutAttributes *)(_allAttributes[(NSUInteger) indexPath.item]);

}


- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (CGSize)collectionViewContentSize {
    CGSize size = [super collectionViewContentSize];
    CGSize newSize = CGSizeMake([_maxX[@(0)] floatValue], size.height);

    return newSize;
}

@end