//
//  LWBaseKBBtn.m
//  MyInputMethod
//
//  Created by luowei on 15/7/1.
//  Copyright (c) 2015 luowei. All rights reserved.
//

#import "LWBaseKBBtn.h"
#import "LWDefines.h"
#import "LWThemeManager.h"


@implementation LWBaseKBBtn {
    CALayer *_shadowlayer;      //阴影
    CALayer *_innerGlow;        //内边框
}

- (id)initWithCoder:(NSCoder *)coder {
//    Log(@"--------%d:%s：", __LINE__, __func__);
    self = [super initWithCoder:coder];
    if (self) {

        //构建子视图
        [self setupSubViews];
    }

    return self;
}


/**
* layout 子视图
*/
- (void)layoutSubviews {
    _contentView.frame = CGRectInset(self.bounds, FloatValueFromThemeKey(@"btn.space.horizon"), FloatValueFromThemeKey(@"btn.space.verticel"));

    //重设阴影大小
    _shadowlayer.frame = CGRectOffset(_contentView.frame, 0, FloatValueFromThemeKey(@"btn.shadow.offsetY"));
    _shadowlayer.frame = CGRectMake(_contentView.frame.origin.x, (CGFloat) (_contentView.frame.origin.y + _contentView.frame.size.height - FloatValueFromThemeKey(@"btn.shadow.height") + FloatValueFromThemeKey(@"btn.shadow.offsetY")),
            _contentView.frame.size.width, FloatValueFromThemeKey(@"btn.shadow.height"));

    //重设置内边框、背景、高亮背景大小
    _innerGlow.frame = CGRectInset(self.bounds, 1, 1);

    _backgroundLayer.frame = CGRectInset(_contentView.frame, 0, 0);
    _highlightBackgroundLayer.frame = CGRectInset(_contentView.frame, 0, 0);

    if(_tipLb){
        [_tipLb sizeToFit];
        CGSize tipLbSize = _tipLb.frame.size;
        _tipLb.frame = CGRectMake(_contentView.frame.size.width-tipLbSize.width, 0, tipLbSize.width, 20);
    }
    [super layoutSubviews];

}

/**
* 重载setHightlighted方法
*/
- (void)setHighlighted:(BOOL)highlighted {
    // Disable隐式动画
    [CATransaction begin];
    [CATransaction setDisableActions:YES];

    //隐藏/显示反转的背景图层
    _highlightBackgroundLayer.hidden = !highlighted;
    [CATransaction commit];

    [super setHighlighted:highlighted];
}

/**
* 重载setImage: forState方法
*/
- (void)setImage:(UIImage *)image forState:(UIControlState)state {
    if (state & UIControlStateHighlighted || state & UIControlStateSelected) {
        [self setupHighlightBackgroundLayer:image withGravity:kCAGravityCenter];
    } else {
        [self setupBackgroundLayer:image withGravity:kCAGravityCenter];
    }
}

/**
* 设置子视图
*/
- (void)setupSubViews {
    self.backgroundColor = [UIColor clearColor];

    if (_contentView) {
        [_contentView removeFromSuperview];
        _contentView = nil;
    }
    //如果是加入毛玻璃效果
//    _contentView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    _contentView = [[UIView alloc] initWithFrame:CGRectInset(self.bounds, FloatValueFromThemeKey(@"btn.space.horizon"), FloatValueFromThemeKey(@"btn.space.verticel"))];
    _contentView.userInteractionEnabled = NO;
    [self addSubview:_contentView];

    //设置背景图层
    [self setupBackgroundLayer:nil withGravity:kCAGravityCenter];
    [self setupHighlightBackgroundLayer:nil withGravity:kCAGravityCenter];
    _highlightBackgroundLayer.hidden = YES;

    //给contentView添加内外边框
//    [self setupInnerGlow];
    [self setupBorder];

    //给contentView添加阴影
    [self setupShadowLayer];
}

/**
* 按Normal状态时的背景色
*/
- (void)setupBackgroundLayer:(UIImage *)image withGravity:(NSString *)gravity {
    //创建背景图层
    if (!_backgroundLayer) {
        _backgroundLayer = [CALayer layer];
        _backgroundLayer.cornerRadius = FloatValueFromThemeKey(@"btn.cornerRadius");
        _backgroundLayer.masksToBounds = YES;
        _backgroundLayer.frame = CGRectInset(_contentView.frame, 0, 0);
        [self.layer insertSublayer:_backgroundLayer atIndex:0];
    }

    //背景用图片设置
    if (image) {
        _backgroundLayer.backgroundColor = [UIColor clearColor].CGColor;
        _backgroundLayer.opacity = 1.0;
        _backgroundLayer.contents = (__bridge id) image.CGImage;
        _backgroundLayer.contentsScale = [[UIScreen mainScreen] scale];
        _backgroundLayer.contentsGravity = gravity;//kCAGravityResizeAspect;

        //否则用颜色值
    } else {
        _backgroundLayer.backgroundColor = [UIColor clearColor].CGColor;
        _backgroundLayer.opacity = 1.0;
    }
}

/**
* 按Highlight状态时的背景色
*/
- (void)setupHighlightBackgroundLayer:(UIImage *)image withGravity:(NSString *)gravity {
    //创建高亮背景图层
    if (!_highlightBackgroundLayer) {
        _highlightBackgroundLayer = [CALayer layer];
        _highlightBackgroundLayer.cornerRadius = FloatValueFromThemeKey(@"btn.cornerRadius");
        _highlightBackgroundLayer.frame = CGRectInset(_contentView.frame, 0, 0);
        [self.layer insertSublayer:_highlightBackgroundLayer atIndex:1];
    }

    //背景用图片设置
    if (image) {
        _highlightBackgroundLayer.backgroundColor = [UIColor clearColor].CGColor;
        _highlightBackgroundLayer.opacity = 1.0;
        _highlightBackgroundLayer.contents = (__bridge id) image.CGImage;
        _highlightBackgroundLayer.contentsScale = [[UIScreen mainScreen] scale];
        _highlightBackgroundLayer.contentsGravity = gravity;//kCAGravityResizeAspect;
    } else {
        //否则用颜色值
        _highlightBackgroundLayer.backgroundColor = CGColorValueFromThemeKey(@"btn.content.highlightColor");
    }
}

/**
* 给contentView添加内边框
*/
- (void)setupInnerGlow {
    if (!_innerGlow) {
        _innerGlow = [CALayer layer];
        _innerGlow.cornerRadius = FloatValueFromThemeKey(@"btn.innerBorder.cornerRadius");
        _innerGlow.borderWidth = FloatValueFromThemeKey(@"btn.innerBorder.borderWidth");
        _innerGlow.borderColor = CGColorValueFromThemeKey(@"btn.innerBorder.borderColor");
        _innerGlow.opacity = 0.5;

        [_contentView.layer insertSublayer:_innerGlow atIndex:2];
    }
}

/**
* 给contentView添加外边框
*/
- (void)setupBorder {
    CALayer *layer = _contentView.layer;
    layer.cornerRadius = FloatValueFromThemeKey(@"btn.cornerRadius");
    layer.borderWidth = FloatValueFromThemeKey(@"btn.borderWidth");
    layer.borderColor = CGColorValueFromThemeKey(@"btn.borderColor");
}

/**
* 给contentView添加阴影
*/
- (void)setupShadowLayer {

    if (_shadowlayer) {
        [_shadowlayer removeFromSuperlayer];
        _shadowlayer = nil;
    }
    // 给按钮添加阴影层
    _shadowlayer = [CALayer layer];
    _shadowlayer.contentsScale = self.layer.contentsScale;
    _shadowlayer.contentsScale = self.layer.contentsScale;
    _shadowlayer.backgroundColor = CGColorValueFromThemeKey(@"btn.shadow.color");
    _shadowlayer.cornerRadius = (CGFloat)(FloatValueFromThemeKey(@"btn.cornerRadius")+FloatValueFromThemeKey(@"btn.shadow.offsetY"));

    _shadowlayer.frame = CGRectMake(_contentView.frame.origin.x, (CGFloat) (_contentView.frame.origin.y + _contentView.frame.size.height - FloatValueFromThemeKey(@"btn.shadow.height") + FloatValueFromThemeKey(@"btn.shadow.offsetY")),
            _contentView.frame.size.width, FloatValueFromThemeKey(@"btn.shadow.height"));
    [self.layer insertSublayer:_shadowlayer below:_contentView.layer];
}

//设置提示到按键上
- (void)setupTip:(NSString *)tip {
    if(!self.tipLb){
        self.tipLb = [[UILabel alloc] initWithFrame:CGRectMake(_contentView.frame.size.width-60, 0, 60, 20)];
        self.tipLb.text = tip;
        self.tipLb.textColor = UIColorValueFromThemeKey(@"font.color");
        self.tipLb.font = [UIFont fontWithName:StringValueFromThemeKey(@"btn.topLabel.fontName") size:FloatValueFromThemeKey(@"btn.topLabel.fontSize")];
        [self.contentView addSubview:self.tipLb];
    }
}

@end
