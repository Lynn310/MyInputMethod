//
// Created by luowei on 15/12/11.
// Copyright (c) 2015 luowei. All rights reserved.
//

#import "LWTabSelView.h"
#import "LWDefines.h"


@implementation LWTabSelView {
    CALayer *_rightLine;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    _upBtn = [[LWTabSelBtn alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height / 2) andText:NSLocalizedString(@"Select Skin", nil)];
    _downBtn = [[LWTabSelBtn alloc] initWithFrame:CGRectMake(0, self.frame.size.height / 2, self.frame.size.width, self.frame.size.height / 2) andText:NSLocalizedString(@"Select Color", nil)];

    [self addSubview:_upBtn];
    [self addSubview:_downBtn];

    _rightLine = [CALayer layer];
    _rightLine.backgroundColor = CGColorValueFromThemeKey(@"btn.borderColor");
    _rightLine.frame = CGRectMake(self.frame.size.width - NarrowLine_W,0,NarrowLine_W,self.frame.size.height);
    [self.layer addSublayer:_rightLine];

}

- (void)layoutSubviews {
    [super layoutSubviews];
    _upBtn.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height / 2);
    _downBtn.frame = CGRectMake(0, self.frame.size.height / 2, self.frame.size.width, self.frame.size.height / 2);

    _rightLine.frame = CGRectMake(self.frame.size.width - NarrowLine_W,0,NarrowLine_W,self.frame.size.height);
}



@end

@implementation LWVerticelTextStorage

@end

@implementation LWVerticalTextContainer
- (CGRect)lineFragmentRectForProposedRect:(CGRect)proposedRect atIndex:(NSUInteger)characterIndex writingDirection:(NSWritingDirection)baseWritingDirection remainingRect:(CGRect *)remainingRect {
//    return [super lineFragmentRectForProposedRect:proposedRect atIndex:characterIndex writingDirection:baseWritingDirection remainingRect:remainingRect];
    *remainingRect = CGRectZero;
    // Return a rect whose width is the current height,whose width is the current width
    return CGRectMake(0, proposedRect.origin.y, self.size.height, proposedRect.size.width);
}

@end

@implementation LWVerticelTextView
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];

    CGContextRef context = UIGraphicsGetCurrentContext();

    [self.layoutManager enumerateLineFragmentsForGlyphRange:NSMakeRange(0, self.layoutManager.numberOfGlyphs)
                                                 usingBlock:^(CGRect lineRect, CGRect usedRect, NSTextContainer *textContainer, NSRange glyphRange, BOOL *stop) {
                                                     CGContextSaveGState(context);

                                                     // Lay the text vertically, reading top-left to bottom-right
                                                     CGContextScaleCTM(context, -1, 1);
                                                     CGContextRotateCTM(context, (CGFloat) M_PI_2);

                                                     // Flip text line fragment along X axis
                                                     CGContextTranslateCTM(context, 0, lineRect.origin.y);
                                                     CGContextScaleCTM(context, 1, -1);
                                                     CGContextTranslateCTM(context, 0, -(lineRect.origin.y + lineRect.size.height));

                                                     // Draw the line fragment
                                                     [self.layoutManager drawBackgroundForGlyphRange:glyphRange atPoint:CGPointZero];

                                                     CGContextRestoreGState(context);
                                                 }];

}

@end



@implementation LWTabSelBtn

- (instancetype)initWithFrame:(CGRect)frame andText:(NSString *)text {
    self = [super initWithFrame:frame];
    if (self) {
        _textLabel = [[UILabel alloc] initWithFrame:frame];
        _textLabel.adjustsFontSizeToFitWidth = YES;
        _textLabel.minimumScaleFactor = 0.5;
        _textLabel.text = text;
        _textLabel.textColor = UIColorValueFromThemeKey(@"btn.content.color");
        _textLabel.font = [UIFont fontWithName:StringValueFromThemeKey(@"btn.mainLabel.fontName") size:FloatValueFromThemeKey(@"btn.mainLabel.fontSize")];
        [self addSubview:_textLabel];


/*
        //方法二:
        _textLabel.transform = CGAffineTransformMakeRotation((CGFloat) ((M_PI)/2));

        //方法三:
        //创建textStorage
        LWVerticelTextStorage *textStorage = [LWVerticelTextStorage new];
        //创建textLayoutManager
        NSLayoutManager *textLayoutManager = [NSLayoutManager new];
        //创建textContainer
        NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:frame.size];

        //为 textStorage 添加 text
        [textStorage replaceCharactersInRange:NSMakeRange(0, 0) withString:text];
        //为 textLayoutManager 添加 textContainer
        [textLayoutManager addTextContainer:textContainer];
        //为 textStorage 添加 textLayoutManager
        [textStorage addLayoutManager:textLayoutManager];

        _textView = [[LWVerticelTextView alloc] initWithFrame:frame textContainer:textContainer];
        _textView.editable = NO;
*/


    }

    return self;
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGSize textSize = [_textLabel sizeThatFits:size];
    _textLabel.frame = CGRectMake(self.center.x, self.center.y, textSize.width, textSize.height);
    return [super sizeThatFits:size];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGSize textSize = [_textLabel sizeThatFits:self.frame.size];
    _textLabel.frame = CGRectMake(self.center.x, self.center.y, textSize.width, textSize.height);
}


@end

