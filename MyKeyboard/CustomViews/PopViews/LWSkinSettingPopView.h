//
// Created by luowei on 15/8/19.
// Copyright (c) 2015 luowei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LWSkinSettingView;
@class LWTabSelView;


@interface LWSkinSettingPopView : UIView

@property (weak, nonatomic) IBOutlet LWTabSelView *tabSelView;
@property (weak, nonatomic) IBOutlet LWSkinSettingView *skinSettingView;


@end

#pragma mark --------- 左边的组件 ---------

@interface LWVerticelTextStorage:NSTextStorage
@end

@interface LWVerticalTextContainer:NSTextContainer
@end

@interface LWVerticelTextView:UITextView
@end

@interface LWTabSelBtn:UIButton

@property(nonatomic, strong) UILabel *textLabel;

@property(nonatomic, strong) LWVerticelTextView *textView;

- (instancetype)initWithFrame:(CGRect)frame andText:(NSString*)text;

@end

@interface LWTabSelView:UIView

@property (strong, nonatomic) LWTabSelBtn *upBtn;
@property (strong, nonatomic) LWTabSelBtn *downBtn;

@end


#pragma mark -------- 右边的组件 --------

@interface LWSkinSettingView:UIView

@end