//
// Created by luowei on 15/12/11.
// Copyright (c) 2015 luowei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWTabSelView.h"

@class LWStyleGridView;
@class LWSkinGridView;


@interface LWSkinSettingView : UIView<LWTabSelViewDelegate>

@property (strong, nonatomic) LWSkinGridView *skinSelecterView;
@property (strong, nonatomic) LWStyleGridView *styleSelecterView;

@end

