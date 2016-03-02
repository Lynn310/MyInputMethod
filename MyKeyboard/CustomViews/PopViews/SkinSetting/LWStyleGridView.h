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

@property(nonatomic, strong) NSDictionary *btnAlphaDic;
@property(nonatomic, strong) NSDictionary  *btnCornerRadiuseDic;
@property(nonatomic, strong) NSDictionary  *btnBorderWidthDic;
@property(nonatomic, strong) UIColor  *btnBorderColor;
@property(nonatomic, strong) NSDictionary  *btnShadowWidthDic;
@property(nonatomic, strong) UIColor  *btnShadowColor;


@property(nonatomic, strong) UIColor *fontColor;
@property(nonatomic, strong) UIColor *fontHighColor;
@property(nonatomic, strong) NSArray *fontNames;

@property(nonatomic, strong) LWColorPickerView *colorPickerView;

@end