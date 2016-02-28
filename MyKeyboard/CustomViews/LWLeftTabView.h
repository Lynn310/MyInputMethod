//
// Created by luowei on 15/8/4.
// Copyright (c) 2015 luowei. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LWLeftTabView : UIView<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UITableView *contentView;

@property(nonatomic, strong) NSArray *dataList;

/**
* 设置dataList数据源
*/
- (void)setupDataList:(NSArray *)dataList;

/**
* 给contentView添加内边框
*/
- (void)setupInnerGlow;

/**
* 给contentView添加外边框
*/
- (void)setupBorder;

/**
* 给contentView添加阴影
*/
- (void)setupShadowLayer;

@end
