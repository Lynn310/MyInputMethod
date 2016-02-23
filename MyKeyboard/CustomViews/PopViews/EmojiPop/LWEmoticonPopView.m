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

static NSString *const EmoticonCellId = @"EmoticonCell";

@implementation LWEmoticonPopView{
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
        _bottomNavBar = [[LWBottomNavBar alloc]initWithFrame:CGRectMake(0, (CGFloat) (frame.size.height-Toolbar_H),frame.size.width,Toolbar_H)
                                                 andNavItems:bottomNavItems];
        _bottomNavBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addSubview:_bottomNavBar];


        CGFloat cellSideLenght = (frame.size.height-Toolbar_H)/4;
        //创建layout
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);

        //layout.headerReferenceSize = CGSizeMake(0,self.frame.size.height);

        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        //设置cell的大小
        layout.itemSize = CGSizeMake(cellSideLenght, cellSideLenght);

        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0,frame.size.width,frame.size.height-Toolbar_H)
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

        [_collectionView registerClass:[LWEmoticonCell class] forCellWithReuseIdentifier:EmoticonCellId];
        [_collectionView registerClass:[LWEmoticonCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
        [self addSubview:_collectionView];

        _collectionView.backgroundColor = UIColorValueFromThemeKey(@"popView.backgroundColor");

        //初始数据源
        _emoticonDict = [self getEmoticonDictionary];

        __weak typeof(self) weakSelf = self;
        self.bottomNavBar.bottomNavScrollview.updateTableDatasouce=^(){
            [weakSelf reloadCollection];
        };
    }

    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _bottomNavBar.frame = CGRectMake(0, (CGFloat) (self.frame.size.height-Toolbar_H),self.frame.size.width,Toolbar_H);
}

//获得Emoji数据
- (NSDictionary *)getEmoticonDictionary {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"emoticon" ofType:@"ini"];
    NSString *emojiIniStr = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSDictionary *iniDict = [NSDictionary dictFromEmoticonIni:emojiIniStr];
    return iniDict;
}

-(void)reloadCollection{
    _emoticonDict = [self getEmoticonDictionary];
    [_collectionView reloadData];
}

#pragma mark UICollectionDataSource Implementation

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    //两个section,一个选择颜色,一个选择图片
    return _emoticonDict.allKeys.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSUInteger idx = (NSUInteger) (_bottomNavBar.bottomNavScrollview->currentBtn.tag - Tag_First_NavItem);

    NSString *key = _emoticonDict.allKeys[idx];
    return ((NSDictionary *)_emoticonDict[key]).count;
}

- (LWEmoticonCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LWEmoticonCell *cell = (LWEmoticonCell *) [collectionView dequeueReusableCellWithReuseIdentifier:EmoticonCellId forIndexPath:indexPath];

    NSUInteger idx = (NSUInteger) (_bottomNavBar.bottomNavScrollview->currentBtn.tag - Tag_First_NavItem);
    NSString *key = _emoticonDict.allKeys[idx];
    NSString *text = ((NSArray *)_emoticonDict[key])[(NSUInteger) indexPath.item];

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


@end


@implementation LWEmoticonCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _emoticonBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _emoticonBtn.frame = CGRectMake(0,0,frame.size.width,frame.size.height);
        _emoticonBtn.titleLabel.hidden = YES;
        [self addSubview:_emoticonBtn];
    }

    return self;
}

//重写sizeThatFits
// (注意:在iOS9下如果同时重写 collectionView:layout:sizeForItemAtIndexPath 和以下这个方法,会出现死循环调用)
- (CGSize)sizeThatFits:(CGSize)size {
    NSString *text = _emoticonBtn.titleLabel.text;

    CGRect textFrame = [self rectFromText:text];
    _emoticonBtn.frame = textFrame;

    return textFrame.size;
}

//根据text设置Btn
- (void)setCellBtnWithText:(NSString *)text {

    CGRect attrTextRect = [self rectFromText:text];
    NSDictionary *attributes = [self getAttributes];
    UIImage *textImg = [UIImage imageFromString:text attributes:attributes size:attrTextRect.size];

    _emoticonBtn.titleLabel.text = text;
    _emoticonBtn.titleLabel.hidden = YES;
    [_emoticonBtn setImage:textImg forState:UIControlStateNormal];
}

//获得Attributes的属性
- (NSDictionary *)getAttributes {
    NSString *fontName = StringValueFromThemeKey(@"btn.mainLabel.fontName");
    CGFloat fontSize = FloatValueFromThemeKey(@"btn.mainLabel.fontSize");
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont fontWithName:fontName size:fontSize],
            NSForegroundColorAttributeName : [UIColor blackColor],
            NSBackgroundColorAttributeName : [UIColor clearColor]};
    return attributes;
}

//根据text得到一个矩形
- (CGRect)rectFromText:(NSString *)text {
    NSDictionary *attributes = [self getAttributes];
    NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:text attributes:attributes];

    CGRect attrTextRect = [attrText boundingRectWithSize:CGSizeMake(attrText.size.width, CGFLOAT_MAX)
                                             options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    return attrTextRect;

}


@end


