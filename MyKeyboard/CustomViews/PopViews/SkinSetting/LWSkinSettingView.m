//
// Created by luowei on 15/12/11.
// Copyright (c) 2015 luowei. All rights reserved.
//

#import "LWSkinSettingView.h"


@implementation LWSkinSettingView {

}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];

    UICollectionViewLayout *layout = [UICollectionViewFlowLayout new];
    _skinSelecterView = [[LWSkinSelecterView alloc] initWithFrame:self.bounds collectionViewLayout:layout];

    [self addSubview:_skinSelecterView];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    if (_skinSelecterView){
        _skinSelecterView.frame = self.bounds;
    }
    if(_colorSelecterView){
        _colorSelecterView.frame = self.bounds;
    }

}

//显示皮肤选择面板
- (void)showSkinPickerView{
    if(_colorSelecterView){
        [_colorSelecterView removeFromSuperview];
        _colorSelecterView = nil;
    }
    if(!_skinSelecterView){
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.sectionInset = UIEdgeInsetsMake(2,2,2,2);
        layout.minimumLineSpacing = 16;
        layout.minimumInteritemSpacing = 16;
        layout.itemSize = CGSizeMake(100,100);
        _skinSelecterView = [[LWSkinSelecterView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    }
}


//显示颜色选择面板
- (void)showColorPickerView{
    if(_skinSelecterView){
        [_skinSelecterView removeFromSuperview];
        _skinSelecterView = nil;
    }
    if(!_colorSelecterView){
        _colorSelecterView = [[LWColorSelecterView alloc] initWithFrame:self.bounds];
        [self addSubview:_colorSelecterView];
    }
}

@end



//皮肤选择面板
@implementation LWSkinSelecterView

#pragma mark UICollectionDataSource Implementation
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}


#pragma mark UICollectionDelegate Implementation
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

}



@end

//颜色选择器面板
@implementation LWColorSelecterView

@end