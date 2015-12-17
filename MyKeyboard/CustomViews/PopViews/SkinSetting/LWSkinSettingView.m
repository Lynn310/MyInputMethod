//
// Created by luowei on 15/12/11.
// Copyright (c) 2015 luowei. All rights reserved.
//

#import "LWSkinSettingView.h"
#import "LWSkinGridView.h"
#import "LWStyleGridView.h"
#import "LWDefines.h"


@implementation LWSkinSettingView {

}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];

    UICollectionViewLayout *layout = [self setupGridViewLayout];
    _skinSelecterView = [[LWSkinGridView alloc] initWithFrame:self.bounds collectionViewLayout:layout];

    [self addSubview:_skinSelecterView];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    if (_skinSelecterView) {
        _skinSelecterView.frame = self.bounds;
    }
    if (_styleSelecterView) {
        _styleSelecterView.frame = self.bounds;
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
    if (_styleSelecterView) {
        [_styleSelecterView removeFromSuperview];
        _styleSelecterView = nil;
    }
    if (!_skinSelecterView) {
        UICollectionViewFlowLayout *layout = [self setupGridViewLayout];
        _skinSelecterView = [[LWSkinGridView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    }
}

//显示颜色选择面板
- (void)showColorPickerView:(UIButton *)btn {
    if (_skinSelecterView) {
        [_skinSelecterView removeFromSuperview];
        _skinSelecterView = nil;
    }
    if (!_styleSelecterView) {
        _styleSelecterView = [[LWStyleGridView alloc] initWithFrame:self.bounds];
        [self addSubview:_styleSelecterView];
    }
}

@end





