//
//  LWSymbolKeyboard.h
//  MyInputMethod
//
//  Created by luowei on 16/3/4.
//  Copyright © 2016年 luowei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LWBottomToolBar;

@interface LWSymbolKeyboard : UIView

@property(nonatomic, strong) LWBottomToolBar *bottomToolBar;
@end

//底部工具条
@interface LWBottomToolBar:UIView

@property(nonatomic, strong) UIButton *backBtn;

@end


//右部符号区
@interface LWLeftNavScrollView : UIScrollView {
@public
    UIButton *currentBtn;
}

@property(nonatomic, copy) void (^updateTableDatasouce)();

- (instancetype)initWithFrame:(CGRect)frame andNavItems:(NSArray *)navItems;

@end

//左部符号分类区
@interface LWSymbolGridView:UICollectionView

@property(nonatomic, strong) UILabel *textLabel;

@end