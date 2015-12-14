//
// Created by luowei on 15/8/19.
// Copyright (c) 2015 luowei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LWSkinSettingView;
@class LWTabSelView;
@class LWSkinSelecterView;
@class LWColorSelecterView;


@interface LWSkinSettingPopView : UIView

//左边的组件
@property (weak, nonatomic) IBOutlet LWTabSelView *tabSelView;
@property (weak, nonatomic) IBOutlet LWSkinSettingView *skinSettingView;


@end


#pragma mark -------- 右边的组件 --------

