//
// Created by luowei on 15/12/11.
// Copyright (c) 2015 luowei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LWTabSelViewDelegate<NSObject>

//显示皮肤选择面板
- (void)showSkinPickerView:(UIButton *)btn;

//显示颜色选择面板
- (void)showColorPickerView:(UIButton *)btn;

@end


@interface LWTabSelView : UIView

@property (weak, nonatomic) id<LWTabSelViewDelegate> delegate;

@property (strong, nonatomic) UIButton *upBtn;
@property (strong, nonatomic) UIButton *downBtn;

@end



//===========下面是其他方法实现,暂无用===========

@class LWVerticelTextView;

@interface LWTabSelBtn:UIButton

@property(nonatomic, strong) UILabel *textLabel;

@property(nonatomic, strong) LWVerticelTextView *textView;

- (instancetype)initWithFrame:(CGRect)frame andText:(NSString*)text;

@end


//竖向排列的Label
@interface LWVerticelLabel:UILabel

@end

//竖向排列的TextView
@interface LWVerticelTextView:UITextView

@end

@interface LWVerticelTextStorage:NSTextStorage
@end

@interface LWVerticalTextContainer:NSTextContainer
@end