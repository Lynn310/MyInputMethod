//
//  LWPredictiveView.h
//  MyInputMethod
//
//  Created by luowei on 16/3/8.
//  Copyright © 2016年 luowei. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - 预选词集合视图的布局

@interface LWPredictiveCollectionViewLayout:UICollectionViewFlowLayout

@end


#pragma mark - 预选词集合视图

@interface LWPredictiveCollectionView : UICollectionView

@end


#pragma mark - 首个预选词(Header View)

@interface LWFirstSuggestionReusableView : UICollectionReusableView

@property(nonatomic, strong) UIButton *firstSuggestionButton;

@end


#pragma mark - 末个预选词(Footer View)

@interface LWLoadMoreReusableView : UICollectionReusableView

@property(nonatomic, strong) UIButton *loadMoreButton;

@end


#pragma mark - 预选词

@interface LWPredictiveView : UIView<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic, weak) IBOutlet UILabel *pinyinLabel;
@property(nonatomic, weak) IBOutlet LWPredictiveCollectionView *predictiveCollectionView;
@property(nonatomic, weak) IBOutlet UIButton *moreButton;

@property(nonatomic, strong)  UIButton *clearButton;
@property(nonatomic, strong) LWFirstSuggestionReusableView *firstSuggestionView;

@property(nonatomic, strong) LWLoadMoreReusableView *footerView;


- (IBAction)moreBtnTapped:(UIButton *)sender;


@end
