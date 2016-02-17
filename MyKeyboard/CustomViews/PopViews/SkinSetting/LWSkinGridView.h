//
// Created by luowei on 15/12/15.
// Copyright (c) 2015 luowei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LWGridViewCell;

@protocol LWGridCellDelegate;
@class LWColorPickerView;

//皮肤选择面板(默认,或颜色透明)
@interface LWSkinGridView : UICollectionView <UICollectionViewDataSource, UICollectionViewDelegate, LWGridCellDelegate>

@property(strong, nonatomic) NSMutableArray<NSString *> *skins;
@property(strong, nonatomic) NSMutableArray<UIColor *> *colors;

@property(nonatomic, assign) BOOL editing;

@property(nonatomic, strong) LWColorPickerView *colorPickerView;
@end



@protocol LWGridCellDelegate <NSObject>

//删除一个皮肤宫格
- (void)deleteButtonClickedInGridViewCell:(LWGridViewCell *)cell;

@end


//皮肤宫格Cell
@interface LWGridViewCell : UICollectionViewCell

@property(nonatomic, assign) id <LWGridCellDelegate> delegate;

@property(nonatomic, assign) BOOL editing;

@property(nonatomic, retain) UIImageView *iconImageView;
@property(nonatomic, strong) UILabel *titleLbl;


//cell titleLabel的最大大小
- (CGSize)maxCellTitleSize;

//刷新Cell的TttleLabel的Text大小
- (void)updateLabelTextSize;

@end


//宫格Header
@interface LWGridHeader:UICollectionReusableView

@property(nonatomic, strong) UILabel *titleLbl;

@end