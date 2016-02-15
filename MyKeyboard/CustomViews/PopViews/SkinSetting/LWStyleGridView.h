//
// Created by luowei on 15/12/15.
// Copyright (c) 2015 luowei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWSkinGridView.h"

//颜色选择器面板
@interface LWStyleGridView : UICollectionView <UICollectionViewDataSource, UICollectionViewDelegate, LWGridCellDelegate>

@property(strong, nonatomic) UIColor *normalColor;
@property(strong, nonatomic) UIColor *highColor;

@property(nonatomic, assign) BOOL editing;

@end