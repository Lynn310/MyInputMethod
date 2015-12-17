//
// Created by luowei on 15/12/11.
// Copyright (c) 2015 luowei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LWTabSelBtn;
@class LWVerticelTextView;


@interface LWTabSelView : UIView

@property (strong, nonatomic) LWTabSelBtn *upBtn;
@property (strong, nonatomic) LWTabSelBtn *downBtn;

@end

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