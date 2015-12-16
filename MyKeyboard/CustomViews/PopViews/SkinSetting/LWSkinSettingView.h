//
// Created by luowei on 15/12/11.
// Copyright (c) 2015 luowei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LWColorSelecterView;
@class LWSkinSelecterView;


@interface LWSkinSettingView : UIView

@property (strong, nonatomic) LWSkinSelecterView *skinSelecterView;
@property (strong, nonatomic) LWColorSelecterView *colorSelecterView;

//显示皮肤选择面板
- (void)showSkinPickerView;

//显示颜色选择面板
- (void)showColorPickerView;

@end

