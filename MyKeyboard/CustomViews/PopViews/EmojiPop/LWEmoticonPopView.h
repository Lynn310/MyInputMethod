//
//  LWEmoticonPopView.h
//  MyInputMethod
//
//  Created by luowei on 16/2/18.
//  Copyright © 2016年 luowei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LWBottomNavBar;

@interface LWEmoticonPopView : UIView<UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic, strong) LWBottomNavBar *bottomNavBar;
@property(nonatomic, strong) UICollectionView *collectionView;


@end



@interface LWEmoticonCell:UICollectionViewCell

@property(nonatomic, strong) UIButton *emoticonBtn;

//根据text设置Btn
- (void)setCellBtnWithText:(NSString *)text;

@end


//UICollectionView custom line separators: http://stackoverflow.com/questions/28691408/uicollectionview-custom-line-separators

