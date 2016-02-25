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
    //约定1行4个unit
    NSUInteger _unitCounter;
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
        LWCollectionFlowLayout *layout = [[LWCollectionFlowLayout alloc] init];

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
    [_collectionView setContentOffset:CGPointMake(0,0) animated:NO];
    [_collectionView reloadData];
}

#pragma mark UICollectionDataSource Implementation

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    //两个section,一个选择颜色,一个选择图片
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    _unitCounter = 0;

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
    Log(@"--------%d:%s \n\n", __LINE__, __func__);

    CGSize textSize = [self getTextFromIndexPath:(NSUInteger) indexPath.item];

    CGSize collectionSize = collectionView.frame.size;
    CGFloat cellSideLenght = (CGFloat) collectionSize.height / 4;
    CGSize cellSize = CGSizeMake(cellSideLenght, cellSideLenght);

    //小于总宽度，大于总宽度1/2时,设为总宽度
    if (collectionSize.width > textSize.width && textSize.width > collectionSize.width / 2) {
        textSize = CGSizeMake(collectionSize.width, cellSize.height);
        _unitCounter+=4;

        //小于总宽度1/2，大于总宽度1/4时，设为总宽度1/2
    }else if (collectionSize.width / 2 > textSize.width && textSize.width > collectionSize.width / 4) {

        //如果位置在前两个
        if(_unitCounter%4 <= 2){
            textSize = CGSizeMake(collectionSize.width / 2, cellSize.height);
            _unitCounter+=2;
        }else{

        }


        //小于总宽度1/4，设为总宽度1/4
    }else if (textSize.width < collectionSize.width / 4) {
        textSize = CGSizeMake(collectionSize.width / 4, cellSize.height);
        _unitCounter+=1;
    }
    cellSize = CGSizeMake(textSize.width , cellSize.height);;

    //~~~~~ 根据位置计算cellSize ~~~~~


    return cellSize;
}

//根据indexPath取得text的大小
- (CGSize)getTextFromIndexPath:(NSUInteger)indexPathItem {
    NSUInteger idx = (NSUInteger) (_bottomNavBar.bottomNavScrollview->currentBtn.tag - Tag_First_NavItem);
    NSString *key = _emoticonDict.allKeys[idx];
    NSString *text = (NSString *) ((NSArray *) _emoticonDict[key])[indexPathItem];

    NSString *fontName = StringValueFromThemeKey(@"btn.mainLabel.fontName");
    CGFloat fontSize = FloatValueFromThemeKey(@"btn.mainLabel.fontSize");
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont fontWithName:fontName size:fontSize],
            NSForegroundColorAttributeName : [UIColor blackColor],
            NSBackgroundColorAttributeName : [UIColor clearColor]};

    CGSize textSize = [text sizeWithAttributes:attributes];

    //~~~~~ 根据text计算cellSize ~~~~~
    //大于总宽度时，缩小字体
    CGSize collectionSize = _collectionView.frame.size;
    while (textSize.width > collectionSize.width) {
        fontSize--;
        attributes = @{NSFontAttributeName : [UIFont fontWithName:fontName size:fontSize],
                NSForegroundColorAttributeName : [UIColor blackColor],
                NSBackgroundColorAttributeName : [UIColor clearColor]};
        textSize = [text sizeWithAttributes:attributes];
    }
    return textSize;
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
        _emoticonBtn.titleLabel.hidden = NO;
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



    NSDictionary *attributes = @{NSFontAttributeName : [UIFont fontWithName:fontName size:fontSize],
            NSForegroundColorAttributeName : [UIColor blackColor],
            NSBackgroundColorAttributeName : [UIColor clearColor]};
    CGSize textSize = [text sizeWithAttributes:attributes];

    //大于总宽度时，缩小字体
    while (textSize.width > _emoticonBtn.frame.size.width) {
        fontSize--;
        attributes = @{NSFontAttributeName : [UIFont fontWithName:fontName size:fontSize],
                NSForegroundColorAttributeName : [UIColor blackColor],
                NSBackgroundColorAttributeName : [UIColor clearColor]};
        textSize = [text sizeWithAttributes:attributes];
    }

    _emoticonBtn.titleLabel.font = [UIFont fontWithName:fontName size:fontSize];
    [_emoticonBtn setTitle:text forState:UIControlStateNormal];
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


//可选方案
//UICollectionView Horizontal Scroll with Horizontal Alignment:http://stackoverflow.com/questions/25963987/uicollectionview-horizontal-scroll-with-horizontal-alignment
//UICollectionView horizontal paging : http://stackoverflow.com/questions/16678474/uicollectionview-horizontal-paging-can-i-use-flow-layout
//RDHCollectionViewGridLayout:https://github.com/rhodgkins/RDHCollectionViewGridLayout

@implementation LWCollectionFlowLayout

- (instancetype)init{
    self = [super init];
    if(self){
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.minimumLineSpacing = 0;
        self.minimumInteritemSpacing = 0;
        self.nbColumns = -1;
        self.nbLines = -1;
    }
    return self;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger nbColumns = self.nbColumns != -1 ? self.nbColumns : (int)(self.collectionView.frame.size.width / self.itemSize.width);
    NSInteger nbLines = self.nbLines != -1 ? self.nbLines : (int)(self.collectionView.frame.size.height / self.itemSize.height);

    NSInteger idxPage = (int)indexPath.row/(nbColumns * nbLines);

    NSInteger O = indexPath.row - (idxPage * nbColumns * nbLines);

    NSInteger xD = (int)(O / nbColumns);
    NSInteger yD = O % nbColumns;

    NSInteger D = xD + yD * nbLines + idxPage * nbColumns * nbLines;

    NSIndexPath *fakeIndexPath = [NSIndexPath indexPathForItem:D inSection:indexPath.section];
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:fakeIndexPath];

    // return them to collection view
    return attributes;
}

- (NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    CGFloat newX = MIN(0, rect.origin.x - rect.size.width/2);
    CGFloat newWidth = rect.size.width*2 + (rect.origin.x - newX);

    CGRect newRect = CGRectMake(newX, rect.origin.y, newWidth, rect.size.height);

    // Get all the attributes for the elements in the specified frame
    NSArray *allAttributesInRect = [[NSArray alloc] initWithArray:[super layoutAttributesForElementsInRect:newRect] copyItems:YES];

    for (UICollectionViewLayoutAttributes *attr in allAttributesInRect) {
        UICollectionViewLayoutAttributes *newAttr = [self layoutAttributesForItemAtIndexPath:attr.indexPath];

        attr.frame = newAttr.frame;
        attr.center = newAttr.center;
        attr.bounds = newAttr.bounds;
        attr.hidden = newAttr.hidden;
        attr.size = newAttr.size;
    }

    return allAttributesInRect;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

- (CGSize)collectionViewContentSize{
    CGSize size = [super collectionViewContentSize];

    CGFloat collectionViewWidth = self.collectionView.frame.size.width;
    NSInteger nbOfScreens = (int)ceil((size.width / collectionViewWidth));

    CGSize newSize = CGSizeMake((nbOfScreens) * collectionViewWidth, size.height);

    return newSize;
}

@end