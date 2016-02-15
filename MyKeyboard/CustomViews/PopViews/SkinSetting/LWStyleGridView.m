//
// Created by luowei on 15/12/15.
// Copyright (c) 2015 luowei. All rights reserved.
//

#import "LWStyleGridView.h"
#import "UIResponder+Ext.h"
#import "LWDefines.h"
#import "UIImage+Color.h"

//样式设置
@implementation LWStyleGridView {

}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {

        self.backgroundColor = UIColorValueFromThemeKey(@"popView.backgroundColor");

        self.contentInset = UIEdgeInsetsMake(GridView_Padding, GridView_Padding, GridView_Padding, GridView_Padding);
        self.delegate = self;
        self.dataSource = self;
        self.scrollEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.alwaysBounceHorizontal = YES;
//        self.alwaysBounceVertical = YES;
        self.showsVerticalScrollIndicator = NO;

        [self registerClass:[LWGridViewCell class] forCellWithReuseIdentifier:StyleCell];
        [self registerClass:[LWGridHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
    }

    return self;
}


//加载皮肤源数据
- (void)reloadData {
    [super reloadData];

    //读取文字Normal颜色数据
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *dat = [userDefaults objectForKey:Key_Word_NormalColor];
    if (!dat) {
        _normalColor = [UIColor darkGrayColor];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_normalColor];
        [userDefaults setObject:data forKey:Key_Word_NormalColor];
        [userDefaults synchronize];
    }else{
        _normalColor = (UIColor *) [NSKeyedUnarchiver unarchiveObjectWithData:dat];
    }

    //读取文字High颜色数据
    NSData *dat2 = [userDefaults objectForKey:Key_Word_HighColor];
    if (!dat2) {
        _highColor = [UIColor lightGrayColor];
        NSData *data2 = [NSKeyedArchiver archivedDataWithRootObject:_highColor];
        [userDefaults setObject:data2 forKey:Key_Word_HighColor];
        [userDefaults synchronize];
    }else{
        _highColor = (UIColor *) [NSKeyedUnarchiver unarchiveObjectWithData:dat2];
    }

}

#pragma mark UICollectionDataSource Implementation

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    //section,一个选择颜色
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    switch (section) {
        //选择文字颜色
        case 0: {
            return 2;
            break;
        }
            //选择High
//        case 1: {
//            return _highColors.count + 1;
//            break;
//        }
        default:
            break;
    }

    return 2;
}

- (LWGridViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    LWGridViewCell *cell = (LWGridViewCell *) [collectionView dequeueReusableCellWithReuseIdentifier:StyleCell forIndexPath:indexPath];

    switch (indexPath.section) {
        //文字颜色
        case 0: {
            [self setupColorSkinCell:cell WithIndexPath:indexPath];
            break;
        }
//            //其他
//        case 1: {
//            [self setupColorSkinCell:cell WithIndexPath:indexPath];
//            break;
//        }
        default:
            break;
    }


    [cell updateLabelTextSize];
    cell.delegate = self;

    return cell;
}

//设置CollectionView的header,footer
- (LWGridHeader *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        LWGridHeader *header = (LWGridHeader *) [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"Header" forIndexPath:indexPath];
        switch (indexPath.section) {
            case 0: {
                header.titleLbl.text = NSLocalizedString(@"Set Word Color", nil);
                break;
            }
//            case 1:{
//                header.titleLbl.text = NSLocalizedString(@"Set Skin From Color", nil);
//                break;
//            }
            default:
                break;
        }

        return header;
    }
    return nil;
}


//给指定indexPath位置的cell设置样式
- (void)setupColorSkinCell:(LWGridViewCell *)cell WithIndexPath:(NSIndexPath *)indexPath {
    //文字颜色
    UIColor *color = _normalColor;
    cell.titleLbl.text = NSLocalizedString(@"Normal Color",nil);
    if (indexPath.item == 1) {
        color = _highColor;
        cell.titleLbl.text = NSLocalizedString(@"High Color",nil);
    }

    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize cellImgSize = CGSizeMake(Grid_Cell_W * scale, Grid_Cell_W * scale);

    UIImage *colorImage = [UIImage imageFromColor:color withRect:CGRectMake(0, 0, cellImgSize.width, cellImgSize.height)];
    cell.iconImageView.image = colorImage;
}

#pragma mark - UICollectionDelegate Implementation

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return !self.editing;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    LWGridViewCell *cell = (LWGridViewCell *) [collectionView cellForItemAtIndexPath:indexPath];

    //todo:选择颜色

}


#pragma mark - LWSkinGridCellDelegate Implementation

//删除一个样式宫格
- (void)deleteButtonClickedInGridViewCell:(LWGridViewCell *)cell {

}


@end