//
// Created by luowei on 15/12/15.
// Copyright (c) 2015 luowei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LWSkinGridViewCell;

@protocol LWSkinGridCellDelegate;

//皮肤选择面板(默认,或颜色透明)
@interface LWSkinSelecterView : UICollectionView <UICollectionViewDataSource, UICollectionViewDelegate,LWSkinGridCellDelegate>

@property(strong, nonatomic) NSMutableArray *skins;

@property(nonatomic, assign) BOOL editing;

@end



@protocol LWSkinGridCellDelegate <NSObject>

//删除一个皮肤宫格
- (void)deleteButtonClickedInGridViewCell:(LWSkinGridViewCell *)cell;

@end


//皮肤宫格Cell
@interface LWSkinGridViewCell : UICollectionViewCell

@property(nonatomic, assign) id <LWSkinGridCellDelegate> delegate;

@property(nonatomic, assign) BOOL editing;

@property(nonatomic, retain) UIImageView *iconImageView;
@property(nonatomic, strong) UILabel *titleLbl;


//cell titleLabel的最大大小
- (CGSize)maxCellTitleSize;

@end