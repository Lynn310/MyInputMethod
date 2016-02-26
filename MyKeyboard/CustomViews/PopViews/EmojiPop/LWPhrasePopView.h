//
//  LWPhrasePopView.h
//  MyInputMethod
//
//  Created by luowei on 16/2/18.
//  Copyright © 2016年 luowei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LWBottomNavBar;
@protocol LWInputPopViewDelegate;

@interface LWPhrasePopView : UIView<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, assign) id<LWInputPopViewDelegate> delegate;

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSDictionary *phrasesDict;
@property(nonatomic, strong) LWBottomNavBar *bottomNavBar;

@end
