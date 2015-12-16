//
// Created by luowei on 15/12/15.
// Copyright (c) 2015 luowei. All rights reserved.
//

#import "LWSkinSelecterView.h"
#import "LWDefines.h"
#import "UIButton+Ext.h"
#import "UIImage+Color.h"
#import "UIResponder+Ext.h"


#define SkinCell @"SkinCell"

#define GridView_TopInset 20.0


#define Grid_Cell_W 60.0
#define Grid_Cell_H 80.0

//小x按钮的宽度与高度
#define Cell_DeleteBtn_W 30.0
#define Cell_DeleteBtn_H 30.0


//皮肤选择面板
@implementation LWSkinSelecterView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
    
        self.contentInset = UIEdgeInsetsMake(GridView_TopInset, 0, 0, 0);
        self.delegate = self;
        self.dataSource = self;
        self.scrollEnabled = YES;
        self.alwaysBounceVertical = YES;
        self.showsVerticalScrollIndicator = NO;
    
        [self registerClass:[LWSkinGridViewCell class] forCellWithReuseIdentifier:SkinCell];
    }
    
    return self;
}


//加载皮肤源数据
- (void)reloadData {
    [super reloadData];
    NSArray *skinArr = [[NSUserDefaults standardUserDefaults] arrayForKey:Key_User_Skins];
    if(skinArr==nil){
        _skins = Default_Skins.mutableCopy;
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:skinArr forKey:Key_User_Skins];
        [userDefaults synchronize];
    }else{
        _skins = skinArr.mutableCopy;
    }
}

#pragma mark UICollectionDataSource Implementation

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _skins.count+1;
}

- (LWSkinGridViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    LWSkinGridViewCell *cell = (LWSkinGridViewCell *) [collectionView dequeueReusableCellWithReuseIdentifier:SkinCell forIndexPath:indexPath];

    //添加皮肤
    if(indexPath.item == _skins.count){
        cell.iconImageView.image = [UIImage imageNamed:@"add_icon"];
        cell.titleLbl.text = NSLocalizedString(@"Add Skin", nil);
    }else{
        NSString *skinImgName = _skins[(NSUInteger) indexPath.item ];

        if([@"default" isEqualToString:skinImgName]){


        }else{
            UIImage *skinImg = [UIImage imageNamed:skinImgName];
            //todo:如果皮肤图片是用户自己加的

            CGFloat scale = [UIScreen mainScreen].scale;
            CGSize cutImgSize = CGSizeMake(60*scale,60*scale);
            CGRect cutImgRect = CGRectMake(skinImg.size.width/2-cutImgSize.width/2,skinImg.size.height/2-cutImgSize.height/2,
                    cutImgSize.width,cutImgSize.height);

            //从大的皮肤图片中,取出一张小的预览图
            UIImage *cutImage = [skinImg cutImageWithRect:cutImgRect];

            cell.iconImageView.image = cutImage;
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
    if(_skins.count == indexPath.item){
        [self openURLWithUrl:[NSURL URLWithString:@"MyInputMethod://"]];
    }else{
        //todo:选择皮肤

    }

}


#pragma mark - LWSkinGridCellDelegate Implementation

//删除一个皮肤宫格
- (void)deleteButtonClickedInGridViewCell:(LWSkinGridViewCell *)cell{

}


@end



@implementation LWSkinGridViewCell{
    UIButton *_deleteButton;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

        //图片
        CGSize cellSize = self.frame.size;
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cellSize.width,cellSize.height -20)];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
        _iconImageView.layer.masksToBounds = YES;
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
        _titleLbl.textColor = [UIColor blackColor];
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