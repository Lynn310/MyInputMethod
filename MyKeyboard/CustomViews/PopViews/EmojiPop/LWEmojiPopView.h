//
//  LWEmojiPopView.h
//  MyInputMethod
//
//  Created by luowei on 16/2/18.
//  Copyright © 2016年 luowei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LWBottomNavBar;

@interface LWEmojiPopView : UIView<UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic, strong) LWBottomNavBar *bottomNavBar;
@property(nonatomic, strong) UICollectionView *collectionView;


@end



@interface LWEmojiCell:UICollectionViewCell


@property(nonatomic, strong) UIButton *emojiBtn;
@end