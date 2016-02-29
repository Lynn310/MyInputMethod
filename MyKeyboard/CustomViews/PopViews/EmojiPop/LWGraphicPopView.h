//
//  LWGraphicPopView.h
//  MyInputMethod
//
//  Created by luowei on 16/2/18.
//  Copyright © 2016年 luowei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LWBottomNavBar;

@interface LWGraphicPopView : UIView<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong) LWBottomNavBar *bottomNavBar;
@property(nonatomic, strong) UICollectionView *collectionView;

- (void)reloadCollection;
@end


@interface LWGraphicCell:UICollectionViewCell

@property(nonatomic, strong) UIButton *graphicBtn;

@property(nonatomic, strong) UIImageView *iconImageView;
@property(nonatomic, strong) UILabel *titleLbl;

//给cell设置图片以及Text
-(void)setIconImage:(UIImage *)image withText:(NSString *)text;

@end