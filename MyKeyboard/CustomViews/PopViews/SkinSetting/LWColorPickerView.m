//
// Created by luowei on 15/12/11.
// Copyright (c) 2015 luowei. All rights reserved.
//

#import <RSColorPicker/RSColorPickerView.h>
#import "LWColorPickerView.h"

@implementation LWColorPickerView {

}

- (void)awakeFromNib {
    [super awakeFromNib];

    if(_colorPicker && _brightnessSlider && _opacitySlider){
        _colorPicker.delegate = self;
        [_brightnessSlider setColorPicker:_colorPicker];
        [_opacitySlider setColorPicker:_colorPicker];
    }
}


- (IBAction)okAction:(UIButton *)sender {
    [self removeFromSuperview];
    if(self.addColorBlock){
        self.addColorBlock(_colorPatch.backgroundColor);
        self.addColorBlock = nil;
    }
    if(self.updateColorBlock){
        self.updateColorBlock(_colorPatch.backgroundColor);
        self.updateColorBlock = nil;
    }

}

- (IBAction)circleSwitchAction:(UISwitch *)circleSwitch {
    _colorPicker.cropToCircle = circleSwitch.isOn;
}

#pragma mark - RSColorPickerView delegate methods

- (void)colorPickerDidChangeSelection:(RSColorPickerView *)cp {

    // Get color data
    UIColor *color = [cp selectionColor];

    CGFloat r, g, b, a;
    [[cp selectionColor] getRed:&r green:&g blue:&b alpha:&a];

    // Update important UI
    _colorPatch.backgroundColor = color;
    _brightnessSlider.value = [cp brightness];
    _opacitySlider.value = [cp opacity];


    // Debug
    NSString *colorDesc = [NSString stringWithFormat:@"rgba: %f, %f, %f, %f", r, g, b, a];
    NSLog(@"%@", colorDesc);
    int ir = r * 255;
    int ig = g * 255;
    int ib = b * 255;
    int ia = a * 255;
    colorDesc = [NSString stringWithFormat:@"rgba: %d, %d, %d, %d", ir, ig, ib, ia];
    NSLog(@"%@", colorDesc);
    _rgbLabel.text = colorDesc;

    NSLog(@"%@", NSStringFromCGPoint(cp.selection));
}

@end





#pragma mark - RSBrightnessSlider

#import "CGContextCreator.h"

/**
 * Returns Image with hourglass looking slider that looks something like:
 *
 *  6 ______ 5
 *    \    /
 *   7 \  / 4
 *    ->||<--- cWidth (Center Width)
 *      ||
 *   8 /  \ 3
 *    /    \
 *  1 ------ 2
 */
UIImage * RSHourGlassThumbImage(CGSize size, CGFloat cWidth){

    //Set Size
    CGFloat width = size.width;
    CGFloat height = size.height;

    //Setup Context
    CGContextRef ctx = [CGContextCreator newARGBBitmapContextWithSize:size];

    //Set Colors
    CGContextSetFillColorWithColor(ctx, [UIColor blackColor].CGColor);
    CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);

    //Draw Slider, See Diagram above for point numbers
    CGFloat yDist83 = sqrtf(3)/2*width;
    CGFloat yDist74 = height - yDist83;
    CGPoint addLines[] = {
            CGPointMake(0, -1),                          //Point 1
            CGPointMake(width, -1),                      //Point 2
            CGPointMake(width/2+cWidth/2, yDist83),      //Point 3
            CGPointMake(width/2+cWidth/2, yDist74),      //Point 4
            CGPointMake(width, height+1),                //Point 5
            CGPointMake(0, height+1),                    //Point 6
            CGPointMake(width/2-cWidth/2, yDist74),      //Point 7
            CGPointMake(width/2-cWidth/2, yDist83)       //Point 8
    };
    //Fill Path
    CGContextAddLines(ctx, addLines, sizeof(addLines)/sizeof(addLines[0]));
    CGContextFillPath(ctx);

    //Stroke Path
    CGContextAddLines(ctx, addLines, sizeof(addLines)/sizeof(addLines[0]));
    CGContextClosePath(ctx);
    CGContextStrokePath(ctx);

    CGImageRef cgImage = CGBitmapContextCreateImage(ctx);
    CGContextRelease(ctx);

    UIImage *image = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);

    return image;
}

/**
 * Returns image that looks like a square arrow loop, something like:
 *
 * +-----+
 * | +-+ | ------------------------
 * | | | |                       |
 * ->| |<--- loopSize.width     loopSize.height
 * | | | |                       |
 * | +-+ | ------------------------
 * +-----+
 */
UIImage * RSArrowLoopThumbImage(CGSize size, CGSize loopSize){

    //Setup Rects
    CGRect outsideRect = CGRectMake(0, 0, size.width, size.height);
    CGRect insideRect;
    insideRect.size = loopSize;
    insideRect.origin.x = (size.width - loopSize.width)/2;
    insideRect.origin.y = (size.height - loopSize.height)/2;

    //Setup Context
    CGContextRef ctx = [CGContextCreator newARGBBitmapContextWithSize:size];

    //Set Colors
    CGContextSetFillColorWithColor(ctx, [UIColor blackColor].CGColor);
    CGContextSetStrokeColorWithColor(ctx, [UIColor whiteColor].CGColor);

    CGMutablePathRef loopPath = CGPathCreateMutable();
    CGPathAddRect(loopPath, nil, outsideRect);
    CGPathAddRect(loopPath, nil, insideRect);


    //Fill Path
    CGContextAddPath(ctx, loopPath);
    CGContextEOFillPath(ctx);

    //Stroke Path
    CGContextAddRect(ctx, insideRect);
    CGContextStrokePath(ctx);

    CGImageRef cgImage = CGBitmapContextCreateImage(ctx);

    //Memory
    CGPathRelease(loopPath);
    CGContextRelease(ctx);

    UIImage *image = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);

    return image;
}


@implementation RSBrightnessSlider

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initRoutine];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initRoutine];
    }
    return self;
}

- (void)initRoutine {
    self.minimumValue = 0.0;
    self.maximumValue = 1.0;
    self.continuous = YES;

    self.enabled = YES;
    self.userInteractionEnabled = YES;

    [self addTarget:self action:@selector(myValueChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void)myValueChanged:(id)notif {
    [_colorPicker setBrightness:self.value];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();

    CGColorSpaceRef space = CGColorSpaceCreateDeviceGray();
    NSArray *colors = @[(id)[UIColor colorWithWhite:0 alpha:1].CGColor,
            (id)[UIColor colorWithWhite:1 alpha:1].CGColor];

    CGGradientRef myGradient = CGGradientCreateWithColors(space, (__bridge CFArrayRef)colors, NULL);

    CGContextDrawLinearGradient(ctx, myGradient, CGPointZero, CGPointMake(rect.size.width, 0), 0);
    CGGradientRelease(myGradient);
    CGColorSpaceRelease(space);
}

- (void)setColorPicker:(RSColorPickerView*)cp {
    _colorPicker = cp;
    if (!_colorPicker) { return; }
    self.value = [_colorPicker brightness];
}

@end



#pragma mark - RSOpacitySlider

#import "RSColorFunctions.h"

@implementation RSOpacitySlider

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initRoutine];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initRoutine];
    }
    return self;
}

- (void)initRoutine {
    self.minimumValue = 0.0;
    self.maximumValue = 1.0;
    self.continuous = YES;

    self.enabled = YES;
    self.userInteractionEnabled = YES;

    [self addTarget:self action:@selector(myValueChanged:) forControlEvents:UIControlEventValueChanged];
}

-  (void)didMoveToWindow {
    if (!self.window) return;

    UIImage *backgroundImage = RSOpacityBackgroundImage(16.f, self.window.screen.scale, [UIColor colorWithWhite:0.5 alpha:1.0]);
    self.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
}

- (void)myValueChanged:(id)notif {
    _colorPicker.opacity = self.value;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();

    CGColorSpaceRef space = CGColorSpaceCreateDeviceGray();
    NSArray *colors = [[NSArray alloc] initWithObjects:
            (id)[UIColor colorWithWhite:0 alpha:0].CGColor,
            (id)[UIColor colorWithWhite:1 alpha:1].CGColor,nil];

    CGGradientRef myGradient = CGGradientCreateWithColors(space, (__bridge CFArrayRef)colors, NULL);

    CGContextDrawLinearGradient(ctx, myGradient, CGPointZero, CGPointMake(rect.size.width, 0), 0);
    CGGradientRelease(myGradient);
    CGColorSpaceRelease(space);
}

- (void)setColorPicker:(RSColorPickerView *)cp {
    _colorPicker = cp;
    if (!_colorPicker) { return; }
    self.value = [_colorPicker brightness];
}

@end