//
// Created by luowei on 15/12/11.
// Copyright (c) 2015 luowei. All rights reserved.
//
//颜色选择器

#import <UIKit/UIKit.h>

@class RSColorPickerView;
@class RSOpacitySlider;
@class RSBrightnessSlider;
@class RSBrightnessSlider;


@interface LWColorPickerView : UIView<UIPickerViewDelegate>

@property (nonatomic) IBOutlet RSColorPickerView *colorPicker;
@property (nonatomic) IBOutlet RSBrightnessSlider *brightnessSlider;
@property (nonatomic) IBOutlet RSOpacitySlider *opacitySlider;
@property (nonatomic) IBOutlet UIView *colorPatch;
@property (nonatomic) IBOutlet UILabel *rgbLabel;

@property(nonatomic, copy) void (^addColorBlock)(UIColor *);

@property(nonatomic, copy) void (^updateColorBlock)(UIColor *);

- (IBAction)okAction:(UIButton *)sender;
- (IBAction)circleSwitchAction:(UISwitch *)sender;


@end


#pragma makr - RSBrightnessSlider

@interface RSBrightnessSlider : UISlider

@property (nonatomic) RSColorPickerView *colorPicker;

@end


#pragma mark - RSOpacitySlider

@interface RSOpacitySlider : UISlider

@property (nonatomic) RSColorPickerView *colorPicker;

@end