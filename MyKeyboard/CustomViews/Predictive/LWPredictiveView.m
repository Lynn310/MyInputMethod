//
//  LWPredictiveView.m
//  MyInputMethod
//
//  Created by luowei on 16/3/8.
//  Copyright © 2016年 luowei. All rights reserved.
//

#import "LWPredictiveView.h"

#pragma mark - 预选词集合视图的布局

@implementation LWPredictiveCollectionViewLayout

@end


#pragma mark - 预选词集合视图

@implementation LWPredictiveCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {

    }

    return self;
}


- (BOOL)touchesShouldCancelInContentView:(UIView *)view {
    return YES;
}

@end


#pragma mark - 首个预选词(Header View)

@implementation LWFirstSuggestionReusableView

@end


#pragma mark - 末个预选词(Footer View)

@implementation LWLoadMoreReusableView

@end


#pragma mark - 预选词

@implementation LWPredictiveView{

}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }

    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor greenColor];

    _predictiveCollectionView.dataSource = self;
    _predictiveCollectionView.delegate = self;
}


#pragma mark - UICollectionViewDataSource Implementation

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

//添加了头注/脚注
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    //头注
    if (kind == UICollectionElementKindSectionHeader) {

        //脚注
    }else if (kind == UICollectionElementKindSectionFooter) {

    }
    return nil;
}


#pragma mark - UICollectionViewDelegate Implementation

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

}



//Header 或者 Footer
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(1, 1);
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(1, 1);
}

- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    if (elementKind == UICollectionElementKindSectionFooter) {
        //todo:显示更多候选
    }
}

//展开更多按下
- (IBAction)moreBtnTapped:(UIButton *)sender {
}


@end
