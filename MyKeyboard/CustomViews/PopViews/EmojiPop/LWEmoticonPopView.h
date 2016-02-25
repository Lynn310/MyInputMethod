//
//  LWEmoticonPopView.h
//  MyInputMethod
//
//  Created by luowei on 16/2/18.
//  Copyright © 2016年 luowei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LWBottomNavBar;
@class LWEmoticonCollectionView;

@interface LWEmoticonPopView : UIView<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>{

}

@property(nonatomic, strong) LWBottomNavBar *bottomNavBar;
@property(nonatomic, strong) LWEmoticonCollectionView *collectionView;

//获得当前分类下的emoticons
- (NSArray *)getEmoticons;

@end



@interface LWEmoticonCell:UICollectionViewCell

@property(nonatomic, strong) UIButton *emoticonBtn;

//根据text设置Btn
- (void)setCellBtnWithText:(NSString *)text;

@end

//分隔线
//UICollectionView custom line separators: http://stackoverflow.com/questions/28691408/uicollectionview-custom-line-separators


@interface LWEmoticonCollectionView:UICollectionView{
}

@property(nonatomic, strong) NSArray *emotions;

- (void)reloadData:(NSArray *)dataSource;

//根据indexPath取得text的大小
- (CGSize)getTextSizeFromItem:(NSUInteger)indexPathItem;

@end

//Layout
@interface LWCollectionFlowLayout:UICollectionViewFlowLayout

@property (nonatomic) NSInteger nbColumns;
@property (nonatomic) NSInteger nbLines;

@end