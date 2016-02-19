//
//  LWPhrasePopView.h
//  MyInputMethod
//
//  Created by luowei on 16/2/18.
//  Copyright © 2016年 luowei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LWBottomNavBar;

@interface LWPhrasePopView : UIView<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSDictionary<NSString *,NSArray<NSString *> *> *phrasesDict;
@property(nonatomic, strong) LWBottomNavBar *bottomNavBar;

@end
