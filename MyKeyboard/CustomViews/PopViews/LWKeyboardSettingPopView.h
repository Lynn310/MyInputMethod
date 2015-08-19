//
// Created by luowei on 15/8/19.
// Copyright (c) 2015 luowei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWImageTextBtn.h"

@protocol LWKeyboardSettingPopViewDelegate <NSObject>

@end

@interface LWKeyboardSettingPopView : UIView

@property(nonatomic, weak) id <LWKeyboardSettingPopViewDelegate> delegate;

@property(nonatomic, weak) IBOutlet LWImageTextBtn *pinyinFullBtn;
@property(weak, nonatomic) IBOutlet LWImageTextBtn *pinyinNineBtn;
@property(weak, nonatomic) IBOutlet LWImageTextBtn *wubiFullBtn;
@property(weak, nonatomic) IBOutlet LWImageTextBtn *bihuaNineBtn;

@end