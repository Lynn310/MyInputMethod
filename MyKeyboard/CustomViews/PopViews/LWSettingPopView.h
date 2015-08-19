//
//  LWSettingPopView.h
//  MyInputMethod
//  logo设置弹窗
//  Created by luowei on 15/7/28.
//  Copyright (c) 2015 luowei. All rights reserved.
//



#import <UIKit/UIKit.h>

@protocol LWSettingPopViewDelegate <NSObject>

@end


@interface LWSettingPopView : UIView

@property (nonatomic, weak) id<LWSettingPopViewDelegate> delegate;

@end
