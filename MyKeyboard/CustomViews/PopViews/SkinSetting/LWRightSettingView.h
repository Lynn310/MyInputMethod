//
// Created by luowei on 15/12/11.
// Copyright (c) 2015 luowei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWLeftTabSelView.h"

@class LWStyleGridView;
@class LWSkinGridView;


@interface LWRightSettingView : UIView<LWLeftTabSelViewDelegate>

@property (strong, nonatomic) LWSkinGridView *skinGridView;
@property (strong, nonatomic) LWStyleGridView *styleGridView;

@end

