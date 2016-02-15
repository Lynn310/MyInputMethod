//
// Created by luowei on 15/12/11.
// Copyright (c) 2015 luowei. All rights reserved.
//

#import "LWRightSettingView.h"
#import "LWSkinGridView.h"
#import "LWStyleGridView.h"
#import "LWDefines.h"


@implementation LWRightSettingView {

}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];

    UICollectionViewLayout *layout = [self setupGridViewLayout];
    _skinGridView = [[LWSkinGridView alloc] initWithFrame:self.bounds collectionViewLayout:layout];

    [self addSubview:_skinGridView];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    if (_skinGridView) {
        _skinGridView.frame = self.bounds;
    }
    if (_styleGridView) {
        _styleGridView.frame = self.bounds;
    }

}

//设置皮肤宫格的布局
- (UICollectionViewFlowLayout *)setupGridViewLayout {
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);

    layout.headerReferenceSize = CGSizeMake(Grid_Cell_H/2,self.frame.size.height);

    layout.minimumLineSpacing = GridView_Padding;
    layout.minimumInteritemSpacing = GridView_Padding;
    //设置cell的大小
    layout.itemSize = CGSizeMake(Grid_Cell_W, Grid_Cell_H);
    return layout;
}


#pragma mark - LWTabSelViewDelegate 实现

//显示皮肤选择面板
- (void)showSkinPickerView:(UIButton *)btn {
    if (_styleGridView) {
        [_styleGridView removeFromSuperview];
        _styleGridView = nil;
    }
    if (!_skinGridView) {
        UICollectionViewFlowLayout *layout = [self setupGridViewLayout];
        _skinGridView = [[LWSkinGridView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        [self addSubview:_skinGridView];
    }
}

//显示颜色选择面板
- (void)showColorPickerView:(UIButton *)btn {
    if (_skinGridView) {
        [_skinGridView removeFromSuperview];
        _skinGridView = nil;
    }
    if (!_styleGridView) {
        UICollectionViewFlowLayout *layout = [self setupGridViewLayout];
        _styleGridView = [[LWStyleGridView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        [self addSubview:_styleGridView];
    }
}

@end





