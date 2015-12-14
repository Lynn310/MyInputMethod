//
// Created by luowei on 15/12/11.
// Copyright (c) 2015 luowei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LWTabSelBtn;


@interface LWTabSelView : UIView

@property (strong, nonatomic) LWTabSelBtn *upBtn;
@property (strong, nonatomic) LWTabSelBtn *downBtn;

@end

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
