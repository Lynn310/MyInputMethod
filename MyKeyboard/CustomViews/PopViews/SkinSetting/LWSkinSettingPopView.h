//
// Created by luowei on 15/8/19.
// Copyright (c) 2015 luowei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LWRightSettingView;
@class LWLeftTabSelView;
@class LWSkinGridView;
@class LWStyleGridView;


@interface LWSkinSettingPopView : UIView

//左边的组件
@property (weak, nonatomic) IBOutlet LWLeftTabSelView *leftTabSelView;
@property (weak, nonatomic) IBOutlet LWRightSettingView *rightSettingView;


@end


#pragma mark -------- 右边的组件 --------

