//
//  LWBottomNavBar.h
//  MyInputMethod
//
//  Created by luowei on 16/2/18.
//  Copyright © 2016年 luowei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LWBottomNavScrollView;


@protocol LWInputPopViewDelegate<NSObject>

//上屏插入字符
- (void)insertText:(NSString *)text;

@end

@interface LWBottomNavBar : UIView {
}

@property(nonatomic, strong) UIButton *backBtn;
@property(nonatomic, strong) UIButton *addBtn;
@property(nonatomic, strong) LWBottomNavScrollView *bottomNavScrollview;

@property(nonatomic, strong) CALayer *topLine;

- (instancetype)initWithFrame:(CGRect)frame andNavItems:(NSArray *)navItems;

@end


@interface LWBottomNavScrollView : UIScrollView {
@public
    UIButton *currentBtn;
}

@property(nonatomic, copy) void (^updateTableDatasouce)();

- (instancetype)initWithFrame:(CGRect)frame andNavItems:(NSArray *)navItems;

@end


@interface LWRightSeparatorLayer : CALayer
@end

@interface LWLeftSeparatorLayer : CALayer
@end


