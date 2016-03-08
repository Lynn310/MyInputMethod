//
//  LWPredictiveView.h
//  MyInputMethod
//
//  Created by luowei on 16/3/8.
//  Copyright © 2016年 luowei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LWPredictiveCollectionView;
@class LWFirstSuggestionReusableView;
@class LWLoadMoreReusableView;


#pragma mark - 预选词

@interface LWPredictiveView : UIView<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic, weak) IBOutlet UILabel *pinyinLabel;
@property(nonatomic, weak) IBOutlet LWPredictiveCollectionView *predictiveCollectionView;
@property(nonatomic, weak) IBOutlet UIButton *moreButton;

@property(nonatomic, strong)  UIButton *clearButton;
@property(nonatomic, strong) LWFirstSuggestionReusableView *firstSuggestionView;

@property(nonatomic, strong) LWLoadMoreReusableView *footerView;


//展开更多按下
- (IBAction)moreBtnTapped:(UIButton *)sender;


//插入按键按下传来的字符
- (void)insertTapedText:(NSString *)lowercaseString;


@end


#pragma mark - LWPredictiveCell

@interface LWPredictiveCell : UICollectionViewCell

@property(nonatomic, weak) IBOutlet UILabel *suggestionTitleLabel;

@end



#pragma mark - 首个预选词(Header View)

@interface LWFirstSuggestionReusableView : UICollectionReusableView

@property(nonatomic, strong) UIButton *firstSuggestionButton;

@end





#pragma mark - 末个预选词(Footer View)

@interface LWLoadMoreReusableView : UICollectionReusableView

@property(nonatomic, strong) UIButton *loadMoreButton;

@end





#pragma mark - 预选词集合视图

@interface LWPredictiveCollectionView : UICollectionView

@end





#pragma mark - 预选词集合视图的布局

@interface LWPredictiveCollectionViewLayout:UICollectionViewFlowLayout

@end


