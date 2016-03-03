//
// Created by luowei on 15/8/19.
// Copyright (c) 2015 luowei. All rights reserved.
//

#import "LWSkinSettingPopView.h"
#import "LWLeftTabSelView.h"
#import "LWDefines.h"
#import "LWDataConfig.h"


@implementation LWSkinSettingPopView {

}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        self.backgroundColor = [LWDataConfig getPopViewBackGroundColor];
    }

    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
}


@end





#pragma mark -------- 右边的组件 --------

