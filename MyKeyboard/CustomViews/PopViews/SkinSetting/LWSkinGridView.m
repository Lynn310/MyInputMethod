//
// Created by luowei on 15/12/15.
// Copyright (c) 2015 luowei. All rights reserved.
//

#import "LWSkinGridView.h"
#import "LWDefines.h"
#import "UIButton+Ext.h"
#import "UIImage+Color.h"
#import "UIResponder+Ext.h"
#import "LWColorPickerView.h"
#import "LWDataConfig.h"


//皮肤选择面板
@implementation LWSkinGridView {
    UILongPressGestureRecognizer *_longPressGestureRecognizer;
    NSIndexPath *_selectedIndexPath;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {

        self.backgroundColor = [LWDataConfig getPopViewBackGroundColor];

        self.contentInset = UIEdgeInsetsMake(GridView_Padding, GridView_Padding, GridView_Padding, GridView_Padding);
        self.delegate = self;
        self.dataSource = self;
        self.scrollEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.alwaysBounceHorizontal = YES;
//        self.alwaysBounceVertical = YES;
        self.showsVerticalScrollIndicator = NO;

        [self registerClass:[LWGridViewCell class] forCellWithReuseIdentifier:SkinCell];
        [self registerClass:[LWGridHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
    }

    //给CollectionView添加长按手势
    [self addLongPressGestureRecognizers];

    //读取_selectedIndexPath
    NSArray *indexPathArr = [StringValueFromThemeKey(@"skinSetting.selectedIndexPath") componentsSeparatedByString:@","];
    NSUInteger section = (NSUInteger) ((NSString *) indexPathArr[0]).intValue;
    NSUInteger item = (NSUInteger) ((NSString *) indexPathArr[1]).intValue;
    _selectedIndexPath = [NSIndexPath indexPathForItem:item inSection:section];

    return self;
}

- (void)dealloc {
    [self removeLongPressGestureRecognizers];
}

//加载皮肤源数据
- (void)reloadData {
    [super reloadData];

    //读取图片皮肤数据
    _skins = [LWDataConfig getArrByKey:Key_User_Skins withDefaultArr:Default_Skins];
    //读取颜色皮肤数据
    _colors = [LWDataConfig getArrByKey:Key_User_Colors withDefaultArr:Default_Colors];

}

#pragma mark UICollectionDataSource Implementation

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    //两个section,一个选择颜色,一个选择图片
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    switch (section) {
        //选择图片
        case 0: {
            return _skins.count + 1;
            break;
        }
            //选择颜色
        case 1: {
            return _colors.count + 1;
            break;
        }
        default:
            break;
    }

    return _skins.count + 1;
}

- (LWGridViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    LWGridViewCell *cell = (LWGridViewCell *) [collectionView dequeueReusableCellWithReuseIdentifier:SkinCell forIndexPath:indexPath];

    switch (indexPath.section) {
        //图片皮肤
        case 0: {
            [self setupImageSkinCell:cell WithIndexPath:indexPath];
            if (indexPath.item == _skins.count || cell.undeleteable) {
                cell.editing = NO;
            } else {
                cell.editing = self.editing;
            }
            break;
        }
            //颜色皮肤
        case 1: {
            [self setupColorSkinCell:cell WithIndexPath:indexPath];
            if (indexPath.item == _colors.count || cell.undeleteable) {
                cell.editing = NO;
            } else {
                cell.editing = self.editing;
            }
            break;
        }
        default:
            break;
    }

    [cell updateLabelTextSize];
    cell.delegate = self;

    return cell;
}

//设置CollectionView的header,footer
- (LWGridHeader *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        LWGridHeader *header = (LWGridHeader *) [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"Header" forIndexPath:indexPath];
        switch (indexPath.section) {
            case 0: {
                header.titleLbl.text = NSLocalizedString(@"Keyboard Imamge Skin", nil);
                break;
            }
            case 1: {
                header.titleLbl.text = NSLocalizedString(@"Keyboard Color Skin", nil);
                break;
            }
            default:
                break;
        }

        return header;
    }
    return nil;
}


//给指定indexPath位置的cell设置图片皮肤
- (void)setupImageSkinCell:(LWGridViewCell *)cell WithIndexPath:(NSIndexPath *)indexPath {
    //添加皮肤
    if (indexPath.item == _skins.count) {
        cell.iconImageView.image = [UIImage imageNamed:@"add_icon"];
        cell.titleLbl.text = NSLocalizedString(@"Add Image", nil);
        cell.selImgView.hidden = YES;
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
            UIImage *skinImg = [LWDataConfig getKBImgFromDoc:skinImgName];

//            //从大的皮肤图片中,取出一张小的预览图
//            CGRect smallImgRect = CGRectMake(skinImg.size.width / 2 - cellImgSize.width / 2, skinImg.size.height / 2 - cellImgSize.height / 2,
//                    cellImgSize.width, cellImgSize.height);
//            UIImage *smallImage = [skinImg cutImageWithRect:smallImgRect];

            //直接缩放大图
            UIImage *smallImage = [skinImg imageToscaledSize:cellImgSize];

            cell.iconImageView.image = smallImage;
        }
        cell.titleLbl.text = NSLocalizedString(skinImgName, nil);

        //设置selImgView的状态
        cell.selImgView.hidden = ![indexPath isEqual:_selectedIndexPath];
    }
}


//给指定indexPath位置的cell设置颜色皮肤
- (void)setupColorSkinCell:(LWGridViewCell *)cell WithIndexPath:(NSIndexPath *)indexPath {
    //添加皮肤
    if (indexPath.item == _colors.count) {
        cell.iconImageView.image = [UIImage imageNamed:@"add_icon"];
        cell.titleLbl.text = NSLocalizedString(@"Add Color", nil);
    } else {
        UIColor *color = _colors[(NSUInteger) indexPath.item];
        CGFloat scale = [UIScreen mainScreen].scale;
        CGSize cellImgSize = CGSizeMake(Grid_Cell_W * scale, Grid_Cell_W * scale);

        UIImage *colorImage = [UIImage imageFromColor:color withRect:CGRectMake(0, 0, cellImgSize.width, cellImgSize.height)];
        cell.iconImageView.image = colorImage;
        cell.titleLbl.text = nil;

        //设置selImgView的状态
        cell.selImgView.hidden = ![indexPath isEqual:_selectedIndexPath];
    }
}

#pragma mark - UICollectionDelegate Implementation

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return !self.editing;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    LWGridViewCell *cell = (LWGridViewCell *) [collectionView cellForItemAtIndexPath:indexPath];

    switch (indexPath.section) {
        //图片皮肤
        case 0: {
            //添加皮肤
            if (_skins.count == indexPath.item) {
                [self openURLWithUrl:[NSURL URLWithString:Url_AddKBImageSkin]];
            } else {
                //设置selImgView的状态,清掉颜色选择设置
                NSString *skinImgName = _skins[(NSUInteger) indexPath.item];
                StringValueToThemeFileByKey(skinImgName, @"inputView.backgroundImage");
                UIColorValueToThemeFileByKey([UIColor clearColor], @"inputView.backgroundColor");

                //把已选择的cell设置为未选择
                if (![indexPath isEqual:_selectedIndexPath]) {
                    LWGridViewCell *oldCell = (LWGridViewCell *) [collectionView cellForItemAtIndexPath:_selectedIndexPath];
                    oldCell.selImgView.hidden = YES;
                }
                //重新设置新选择的状态
                cell.selImgView.hidden = NO;
                _selectedIndexPath = indexPath;
                StringValueToThemeFileByKey(([NSString stringWithFormat:@"%d,%d", indexPath.section, indexPath.item]), @"skinSetting.selectedIndexPath");
                [self reloadData];
            }
            break;
        }
            //颜色皮肤
        case 1: {
            //添加颜色
            if (_colors.count == indexPath.item) {
                if (_colorPickerView) {
                    [_colorPickerView removeFromSuperview];
                    _colorPickerView = nil;
                }
                _colorPickerView = (LWColorPickerView *) [[NSBundle mainBundle] loadNibNamed:@"LWColorPickerView" owner:self options:nil][0];
                [self.superview addSubview:_colorPickerView];
                _colorPickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
                _colorPickerView.frame = self.frame;
                [self.superview bringSubviewToFront:_colorPickerView];

                __weak typeof(self) weakSelf = self;
                _colorPickerView.addColorBlock = ^(UIColor *color) {
                    [weakSelf.colors addObject:color];
                    [weakSelf performBatchUpdates:^{
                        [weakSelf reloadSections:[NSIndexSet indexSetWithIndex:1]];
                    }                  completion:nil];
                    [LWDataConfig setArr:weakSelf.colors WithKey:Key_User_Colors];

                    //删除colorPickerView
                    [weakSelf.colorPickerView removeFromSuperview];
                    weakSelf.colorPickerView = nil;
                };

            } else {
                //设置新选的颜色,清掉皮肤选择设置
                UIColor *color = _colors[(NSUInteger) indexPath.item];
                UIColorValueToThemeFileByKey(color, @"inputView.backgroundColor");
                StringValueToThemeFileByKey(@"", @"inputView.backgroundImage");

                //把已选择的cell设置成未选择
                if (![indexPath isEqual:_selectedIndexPath]) {
                    LWGridViewCell *oldCell = (LWGridViewCell *) [collectionView cellForItemAtIndexPath:_selectedIndexPath];
                    oldCell.selImgView.hidden = YES;
                }
                //重新设置新选择的状态
                cell.selImgView.hidden = NO;
                _selectedIndexPath = indexPath;
                StringValueToThemeFileByKey(([NSString stringWithFormat:@"%d,%d", indexPath.section, indexPath.item]), @"skinSetting.selectedIndexPath");
                [self reloadData];
            }
            break;
        }
        default:
            break;
    }

}


#pragma mark - LWSkinGridCellDelegate Implementation

//删除一个宫格
- (void)deleteButtonClickedInGridViewCell:(LWGridViewCell *)cell {
    NSIndexPath *indexPath = [self indexPathForCell:cell];
    __weak typeof(self) weakSelf = self;
    switch (indexPath.section) {
        case 0: {
            [_skins removeObjectAtIndex:(NSUInteger) indexPath.item];
            [LWDataConfig setArr:_skins WithKey:Key_User_Skins];

            //把删除更新到gridView
            [self performBatchUpdates:^{
                [weakSelf deleteItemsAtIndexPaths:@[indexPath]];
            }              completion:nil];
            break;
        }
        case 1: {
            [_colors removeObjectAtIndex:(NSUInteger) indexPath.item];
            [LWDataConfig setArr:_colors WithKey:Key_User_Colors];

            //把删除更新到gridView
            [self performBatchUpdates:^{
                [weakSelf deleteItemsAtIndexPaths:@[indexPath]];
            }              completion:nil];
            break;
        }
        default:
            break;
    }

}


#pragma mark - 长按手势处理

//添加longPress手势
- (void)addLongPressGestureRecognizers {
    self.userInteractionEnabled = YES;
    
    _longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureRecognizerTriggerd:)];
    _longPressGestureRecognizer.cancelsTouchesInView = NO;
    _longPressGestureRecognizer.minimumPressDuration = 0.8;
    //_longPressGestureRecognizer.delegate = self;
    
    for (UIGestureRecognizer *gestureRecognizer in self.gestureRecognizers) {
        if ([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]]) {
            [gestureRecognizer requireGestureRecognizerToFail:_longPressGestureRecognizer];
        }
    }
    
    [self addGestureRecognizer:_longPressGestureRecognizer];
}

//移除longPress手势
- (void)removeLongPressGestureRecognizers {
    if (_longPressGestureRecognizer) {
        if (_longPressGestureRecognizer.view) {
            [_longPressGestureRecognizer.view removeGestureRecognizer:_longPressGestureRecognizer];
        }
        _longPressGestureRecognizer = nil;
    }
}

//长按手势响应处理
- (void)longPressGestureRecognizerTriggerd:(UILongPressGestureRecognizer *)longPress {
    
    //LWSkinGridView *gridView = (LWSkinGridView *) longPress.view;
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan: {
            //如果不是处于编辑状态，设置成编辑状态
            if (!self.editing) {
                self.editing = YES;
            }
            
            //[self.collectionViewLayout invalidateLayout];
            [self reloadData];
        }
            break;
        default:
            break;
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UICollectionViewCell *cell = [self cellForItemAtIndexPath:[self indexPathForItemAtPoint:point]];
    if (self.editing && !cell) {
        self.editing = NO;
        [self reloadData];
    }
    return [super hitTest:point withEvent:event];
}


//设置编辑状态
- (void)setEditing:(BOOL)editing {
    _editing = editing;
    for (UICollectionViewCell *cel in self.visibleCells) {
        LWGridViewCell *cell = (LWGridViewCell *) cel;
        
        //给cell设置editing状态
        NSIndexPath *indexPath = [self indexPathForCell:cell];
        switch (indexPath.section) {
            case 0: {
                if (indexPath.item == 1 || cell.undeleteable) {
                    cell.editing = NO;
                } else {
                    cell.editing = editing;
                }
                break;
            }
            case 1: {
                if (indexPath.item == 1 || cell.undeleteable) {
                    cell.editing = NO;
                } else {
                    cell.editing = editing;
                }
                break;
            }
            default:
                break;
        }
    }
}

@end


@implementation LWGridViewCell {
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
        _titleLbl.text = @"";
        _titleLbl.font = [UIFont systemFontOfSize:12];
        _titleLbl.textColor = UIColorValueFromThemeKey(@"font.color");
        _titleLbl.textAlignment = NSTextAlignmentCenter;
        _titleLbl.lineBreakMode = NSLineBreakByTruncatingTail;
        [self.contentView addSubview:_titleLbl];

        //给删除按钮添加响应事件
        [_deleteButton addTarget:self action:@selector(deleteButtonClicked:) forControlEvents:UIControlEventTouchDown];
        self.iconImageView.userInteractionEnabled = YES;

        _selImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"selectedIcon"]];
        _selImgView.bounds = CGRectMake(0, 0, Cell_DeleteBtn_W, Cell_DeleteBtn_H);
        _selImgView.center = CGPointMake(_iconImageView.frame.size.width / 2, _iconImageView.frame.size.height / 2);
        _selImgView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_selImgView];
        _selImgView.hidden = YES;

        //把_selImgView移到最前端
        [self bringSubviewToFront:_selImgView];
    }

    return self;
}

- (void)setEditing:(BOOL)editing {
    _deleteButton.hidden = !editing;
    _editing = editing;
}

//刷新Cell的TttleLabel的Text大小
- (void)updateLabelTextSize {
    if (!self.titleLbl.text || [self.titleLbl.text isEqualToString:@""]) {
        return;
    }
    //重设titleLbl大小
    [self.titleLbl sizeToFit];

    CGSize cellSize = self.bounds.size;
    CGFloat titleLblWidth = self.titleLbl.frame.size.width;
    titleLblWidth = titleLblWidth > self.maxCellTitleSize.width ? self.maxCellTitleSize.width : titleLblWidth;

    self.titleLbl.center = CGPointMake((CGFloat) (cellSize.width * 0.5), (CGFloat) (cellSize.height - self.maxCellTitleSize.height * 0.5));
    self.titleLbl.bounds = CGRectMake(0, 0, titleLblWidth, self.maxCellTitleSize.height);

//    //栅格化,让图层离屏渲染,缓存绘图结果
//    cell.layer.shouldRasterize = YES;
//    cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
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


//宫格Header
@implementation LWGridHeader {
    CALayer *_rightLine;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //文字标题
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.text = @"title";
        _titleLbl.font = [UIFont systemFontOfSize:12];
        _titleLbl.textColor = UIColorValueFromThemeKey(@"font.color");
        _titleLbl.textAlignment = NSTextAlignmentCenter;
        _titleLbl.lineBreakMode = NSLineBreakByTruncatingTail;
        [self addSubview:_titleLbl];

//        CGRect frame = CGRectMake(0,0,200,Grid_Cell_H/2);
//        _titleLbl.bounds = CGRectMake(0,0,frame.size.height,frame.size.width);
//        _titleLbl.center = CGPointMake(frame.size.width/2,frame.size.height/2);
//        _titleLbl.transform = CGAffineTransformMakeRotation(-M_PI_2);


//        _rightLine = [CALayer layer];
//        _rightLine.backgroundColor = CGColorValueFromThemeKey(@"btn.borderColor");
//        _rightLine.frame = CGRectMake(self.frame.size.width - NarrowLine_W,0,NarrowLine_W,self.frame.size.height);
//        [self.layer addSublayer:_rightLine];
    }

    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

//    CGRect frame = CGRectMake(0,0,200,Grid_Cell_H/2);
    CGRect frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _titleLbl.bounds = CGRectMake(0, 0, frame.size.height, frame.size.width);
    _titleLbl.center = CGPointMake(frame.size.width / 2, frame.size.height / 2);
    _titleLbl.transform = CGAffineTransformMakeRotation(-M_PI_2);

//    _rightLine.frame = CGRectMake(self.frame.size.width - NarrowLine_W,0,NarrowLine_W,self.frame.size.height);
}

//刷新Headder的TttleLabel的Text大小
- (void)updateLabelTextSize {
    //重设titleLbl大小
    [self.titleLbl sizeToFit];

    CGSize cellSize = self.bounds.size;
    CGFloat titleLblWidth = self.titleLbl.frame.size.width;
    titleLblWidth = titleLblWidth > self.frame.size.width ? self.frame.size.width : titleLblWidth;

    self.titleLbl.center = CGPointMake((CGFloat) (cellSize.width * 0.5), (CGFloat) (cellSize.height - self.frame.size.height * 0.5));
    self.titleLbl.bounds = CGRectMake(0, 0, titleLblWidth, self.frame.size.height);

}

@end