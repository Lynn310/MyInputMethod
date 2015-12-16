//
// Created by luowei on 15/12/11.
// Copyright (c) 2015 luowei. All rights reserved.
//

#import "LWSkinSettingView.h"
#import "LWSkinGridView.h"
#import "LWColorGridView.h"
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
    if (_colorSelecterView) {
        _colorSelecterView.frame = self.bounds;
    }

}

//显示皮肤选择面板
- (void)showSkinPickerView {
    if (_colorSelecterView) {
        [_colorSelecterView removeFromSuperview];
        _colorSelecterView = nil;
    }
    if (!_skinSelecterView) {
        UICollectionViewFlowLayout *layout = [self setupGridViewLayout];
        _skinSelecterView = [[LWSkinGridView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    }
}

//设置皮肤宫格的布局
- (UICollectionViewFlowLayout *)setupGridViewLayout {
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(2, 12, 2, 12);
    layout.minimumLineSpacing = 16;
    layout.minimumInteritemSpacing = 16;
    layout.itemSize = CGSizeMake(100, 100);
    //设置cell的大小
    layout.itemSize = CGSizeMake(Grid_Cell_W, Grid_Cell_H);
    return layout;
}


//显示颜色选择面板
- (void)showColorPickerView {
    if (_skinSelecterView) {
        [_skinSelecterView removeFromSuperview];
        _skinSelecterView = nil;
    }
    if (!_colorSelecterView) {
        _colorSelecterView = [[LWColorGridView alloc] initWithFrame:self.bounds];
        [self addSubview:_colorSelecterView];
    }
}

@end





