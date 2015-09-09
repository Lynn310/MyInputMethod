//
//  LWSettingPopView.h
//  MyInputMethod
//  logo设置弹窗
//  Created by luowei on 15/7/28.
//  Copyright (c) 2015 luowei. All rights reserved.
//



#import <UIKit/UIKit.h>

@class LWImageTextBtn;

@protocol LWSettingPopViewDelegate <NSObject>

@end


@interface LWSettingPopView : UIView

@property (nonatomic, weak) id<LWSettingPopViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet LWImageTextBtn *dayNightBtn;
@property (weak, nonatomic) IBOutlet LWImageTextBtn *enPredictBtn;
@property (weak, nonatomic) IBOutlet LWImageTextBtn *simplifyBtn;
@property (weak, nonatomic) IBOutlet LWImageTextBtn *marsBtn;
@property (weak, nonatomic) IBOutlet LWImageTextBtn *soundBtn;
@property (weak, nonatomic) IBOutlet LWImageTextBtn *moreSettingBtn;

@end
