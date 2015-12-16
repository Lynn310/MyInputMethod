//
// Created by luowei on 15/12/11.
// Copyright (c) 2015 luowei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LWColorGridView;
@class LWSkinGridView;


@interface LWSkinSettingView : UIView

@property (strong, nonatomic) LWSkinGridView *skinSelecterView;
@property (strong, nonatomic) LWColorGridView *colorSelecterView;

//显示皮肤选择面板
- (void)showSkinPickerView;

//显示颜色选择面板
- (void)showColorPickerView;

@end

