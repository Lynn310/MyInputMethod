//
// Created by luowei on 15/12/15.
// Copyright (c) 2015 luowei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWSkinGridView.h"

//颜色选择器面板
@interface LWStyleGridView : UICollectionView <UICollectionViewDataSource, UICollectionViewDelegate, LWGridCellDelegate>

@property(nonatomic, assign) BOOL editing;

@property(strong, nonatomic) UIColor *btnNormalColor;
@property(strong, nonatomic) UIColor *btnHighColor;

@property(nonatomic, strong) NSArray<NSNumber *> * btnAlphas;
@property(nonatomic, strong) NSArray<NSNumber *> *btnCornerRadiuses;
@property(nonatomic, strong) NSArray<NSNumber *> *btnBorderShadow;
@property(nonatomic, strong) UIColor *fontColor;
@property(nonatomic, strong) NSArray<NSString *> *fontNames;
@end