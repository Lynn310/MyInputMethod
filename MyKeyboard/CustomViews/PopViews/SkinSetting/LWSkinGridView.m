//
// Created by luowei on 15/12/15.
// Copyright (c) 2015 luowei. All rights reserved.
//

#import "LWSkinGridView.h"
#import "LWDefines.h"
#import "UIButton+Ext.h"
#import "UIImage+Color.h"
#import "UIResponder+Ext.h"


//皮肤选择面板
@implementation LWSkinGridView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {

        self.backgroundColor = UIColorValueFromThemeKey(@"popView.backgroundColor");

        self.contentInset = UIEdgeInsetsMake(GridView_Padding, GridView_Padding, GridView_Padding, GridView_Padding);
        self.delegate = self;
        self.dataSource = self;
        self.scrollEnabled = YES;
        self.alwaysBounceHorizontal = YES;
//        self.alwaysBounceVertical = YES;
        self.showsVerticalScrollIndicator = NO;

        [self registerClass:[LWSkinGridViewCell class] forCellWithReuseIdentifier:SkinCell];
    }
    
    return self;
}


//加载皮肤源数据
- (void)reloadData {
    [super reloadData];
    NSArray *skinArr = [[NSUserDefaults standardUserDefaults] arrayForKey:Key_User_Skins];
    if (skinArr == nil) {
        _skins = Default_Skins.mutableCopy;
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:skinArr forKey:Key_User_Skins];
        [userDefaults synchronize];
    } else {
        _skins = skinArr.mutableCopy;
    }
}

#pragma mark UICollectionDataSource Implementation

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _skins.count + 1;
}

- (LWSkinGridViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    LWSkinGridViewCell *cell = (LWSkinGridViewCell *) [collectionView dequeueReusableCellWithReuseIdentifier:SkinCell forIndexPath:indexPath];

    //添加皮肤
    if (indexPath.item == _skins.count) {
        cell.iconImageView.image = [UIImage imageNamed:@"add_icon"];
        cell.titleLbl.text = NSLocalizedString(@"Add Skin", nil);
    } else {
        NSString *skinImgName = _skins[(NSUInteger) indexPath.item];
        CGFloat scale = [UIScreen mainScreen].scale;
        CGSize cellImgSize = CGSizeMake(Grid_Cell_W * scale, Grid_Cell_W * scale);

        if ([@"default" isEqualToString:skinImgName]) {
            UIImage *colorImage = [UIImage imageFromColor:[UIColor grayColor] withRect:CGRectMake(0, 0, cellImgSize.width, cellImgSize.height)];
            //把logo图片放大
            UIImage *logo = [[UIImage imageNamed:@"logo"] imageToscaledSize:CGSizeMake(cellImgSize.width - 10, cellImgSize.height - 10)];

            //合并图片
            CGRect logoFrame = CGRectMake((colorImage.size.width - logo.size.width) / 2, (colorImage.size.height - logo.size.height) / 2, logo.size.width, logo.size.height);
            UIImage *combinedImg = [UIImage addImageToImage:colorImage withImage2:logo andRect:logoFrame withImageSize:cellImgSize];
            cell.iconImageView.image = combinedImg;

        } else {
            UIImage *skinImg = [UIImage imageNamed:skinImgName];
            //todo:如果皮肤图片是用户自己加的

//            //从大的皮肤图片中,取出一张小的预览图
//            CGRect smallImgRect = CGRectMake(skinImg.size.width / 2 - cellImgSize.width / 2, skinImg.size.height / 2 - cellImgSize.height / 2,
//                    cellImgSize.width, cellImgSize.height);
//            UIImage *smallImage = [skinImg cutImageWithRect:smallImgRect];

            //直接缩放大图
            UIImage *smallImage = [skinImg imageToscaledSize:cellImgSize];

            cell.iconImageView.image = smallImage;
        }


        cell.titleLbl.text = NSLocalizedString(skinImgName, nil);

        //重设titleLbl大小
        [cell.titleLbl sizeToFit];

        CGSize cellSize = cell.bounds.size;
        CGFloat titleLblWidth = cell.titleLbl.frame.size.width;
        titleLblWidth = titleLblWidth > cell.maxCellTitleSize.width ? cell.maxCellTitleSize.width : titleLblWidth;

        cell.titleLbl.center = CGPointMake((CGFloat) (cellSize.width * 0.5), (CGFloat) (cellSize.height - cell.maxCellTitleSize.height * 0.5));
        cell.titleLbl.bounds = CGRectMake(0, 0, titleLblWidth, cell.maxCellTitleSize.height);
    }

    cell.delegate = self;

//    //栅格化,让图层离屏渲染,缓存绘图结果
//    cell.layer.shouldRasterize = YES;
//    cell.layer.rasterizationScale = [UIScreen mainScreen].scale;

    return cell;
}


#pragma mark - UICollectionDelegate Implementation

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return !self.editing;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    LWSkinGridViewCell *cell = (LWSkinGridViewCell *) [collectionView cellForItemAtIndexPath:indexPath];

    //添加皮肤
    if (_skins.count == indexPath.item) {
        [self openURLWithUrl:[NSURL URLWithString:@"MyInputMethod://"]];
    } else {
        //todo:选择皮肤

    }

}


#pragma mark - LWSkinGridCellDelegate Implementation

//删除一个皮肤宫格
- (void)deleteButtonClickedInGridViewCell:(LWSkinGridViewCell *)cell {

}


@end


@implementation LWSkinGridViewCell {
    UIButton *_deleteButton;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

        //图片
        CGSize cellSize = self.frame.size;
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cellSize.width, cellSize.height - 20)];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
        _iconImageView.layer.masksToBounds = YES;
        _iconImageView.layer.cornerRadius = FloatValueFromThemeKey(@"btn.cornerRadius");
        [self.contentView addSubview:_iconImageView];

        //删除小叉叉
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setImage:[UIImage imageNamed:@"deleteIcon"] forState:UIControlStateNormal];
        [self.contentView addSubview:_deleteButton];
        _deleteButton.hidden = YES;
        _deleteButton.frame = CGRectMake(-Cell_DeleteBtn_W / 2, -Cell_DeleteBtn_H / 2, Cell_DeleteBtn_W, Cell_DeleteBtn_H);
        [_deleteButton setHitTestEdgeInsets:UIEdgeInsetsMake(-10, -10, -10, -10)];

        //文字标题
        _titleLbl = [[UILabel alloc] initWithFrame:CGRectIntegral(CGRectMake(-3.5, cellSize.height - self.maxCellTitleSize.height, cellSize.width + 7, self.maxCellTitleSize.height))];
        _titleLbl.text = @"title";
        _titleLbl.font = [UIFont systemFontOfSize:12];
        _titleLbl.textColor = UIColorValueFromThemeKey(@"btn.content.color");
        _titleLbl.textAlignment = NSTextAlignmentCenter;
        _titleLbl.lineBreakMode = NSLineBreakByTruncatingTail;
        [self.contentView addSubview:_titleLbl];

        //给删除按钮添加响应事件
        [_deleteButton addTarget:self action:@selector(deleteButtonClicked:) forControlEvents:UIControlEventTouchDown];
        self.iconImageView.userInteractionEnabled = YES;

    }

    return self;
}

//cell titleLabel的最大大小
- (CGSize)maxCellTitleSize {
    return CGSizeMake(self.frame.size.width + 7, 14);
}

//执行删除Cell的操作
- (void)deleteButtonClicked:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(deleteButtonClickedInGridViewCell:)]) {
        [self.delegate deleteButtonClickedInGridViewCell:self];
    }

}

@end