//
// Created by luowei on 15/12/15.
// Copyright (c) 2015 luowei. All rights reserved.
//

#import "LWStyleGridView.h"
#import "UIResponder+Ext.h"
#import "LWDefines.h"
#import "UIImage+Color.h"
#import "LWColorPickerView.h"
#import "LWDataConfig.h"

//样式设置
@implementation LWStyleGridView {

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

        [self registerClass:[LWGridViewCell class] forCellWithReuseIdentifier:StyleCell];
        [self registerClass:[LWGridHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
    }

    return self;
}


//加载皮肤源数据
- (void)reloadData {
    [super reloadData];

    //按键颜色
    _btnNormalColor = UIColorValueFromThemeKey(@"btn.content.color");
    _btnHighColor = UIColorValueFromThemeKey(@"btn.content.highlightColor");

    //按键圆角
    _btnCornerRadiuseDic = Default_Btn_CornerRadiusDic;

    //按键边框宽度
    _btnBorderWidthDic = Default_Btn_BorderWidthDic;
    //按键边框颜色
    _btnBorderColor = UIColorValueFromThemeKey(@"btn.borderColor");

    //按键透明度
    _btnAlphaDic = Default_Btn_AlphaDic;

    //按键阴影宽度
    _btnShadowWidthDic = Default_Btn_ShadowWidthDic;
    //按键阴影颜色
    _btnShadowColor = UIColorValueFromThemeKey(@"btn.shadow.color");

    //字体颜色
    _fontColor = UIColorValueFromThemeKey(@"font.color");
    _fontHighColor = UIColorValueFromThemeKey(@"font.highlightColor");

    //字体名称
    _fontNames = Default_FontNameDic;

}

#pragma mark UICollectionDataSource Implementation

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    //section,一个选择颜色
    return 9;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    switch (section) {
        //按键颜色
        case 0: {
            return 2;
            break;
        }
            //按键圆角
        case 1: {
            return _btnCornerRadiuseDic.count;
            break;
        }
            //按键边框宽度
        case 2: {
            return _btnBorderWidthDic.count;
            break;
        }
            //按键边框颜色
        case 3: {
            return 1;
            break;
        }
            //按键透明度
        case 4: {
            return _btnAlphaDic.count;
            break;
        }
            //按键阴影宽度
        case 5: {
            return _btnShadowWidthDic.count;
            break;
        }
            //按键阴影颜色
        case 6: {
            return 1;
            break;
        }
            //字体颜色
        case 7: {
            return 2;
            break;
        }
            //字体名称
        case 8: {
            return _fontNames.count;
            break;
        }
        default:
            break;
    }

    return 2;
}

- (LWGridViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    LWGridViewCell *cell = (LWGridViewCell *) [collectionView dequeueReusableCellWithReuseIdentifier:StyleCell forIndexPath:indexPath];

    switch (indexPath.section) {
        //按键颜色
        case 0: {
            UIColor *color = _btnNormalColor;
            cell.titleLbl.text = NSLocalizedString(@"Normal Color", nil);
            if (indexPath.item == 1) {
                color = _btnHighColor;
                cell.titleLbl.text = NSLocalizedString(@"High Color", nil);
            }
            [self setupCellIconImg:cell WithIndexPath:indexPath withColor:color];
            cell.selImgView.hidden = YES;
            break;
        }
            //按键圆角
        case 1: {
            NSString *imgName = [NSString stringWithFormat:@"CornerRadiuse%d", (int) indexPath.item];
            cell.iconImageView.image = [UIImage imageNamed:imgName];
            cell.titleLbl.text = nil;

            //赋初始选择状态
            CGFloat settedCornerRadius = FloatValueFromThemeKey(@"btn.cornerRadius");
            CGFloat cornerRadius = ((NSNumber *) _btnCornerRadiuseDic[imgName]).floatValue;
            cell.selImgView.hidden = settedCornerRadius != cornerRadius;
            break;
        }
            //按键边框宽度
        case 2: {
            NSString *imgName = [NSString stringWithFormat:@"BorderWidth%d", (int) indexPath.item];
            cell.iconImageView.image = [UIImage imageNamed:imgName];
            cell.titleLbl.text = nil;

            //赋初始选择状态
            CGFloat settedBorderWidth = FloatValueFromThemeKey(@"btn.borderWidth");
            CGFloat borderWidth = ((NSNumber *) _btnBorderWidthDic[imgName]).floatValue;
            cell.selImgView.hidden = settedBorderWidth != borderWidth;
            break;
        }
            //按键边框颜色
        case 3: {
            [self setupCellIconImg:cell WithIndexPath:indexPath withColor:_btnBorderColor];
            cell.selImgView.hidden = YES;
            cell.titleLbl.text = nil;
            break;
        }
            //按键透明度
        case 4: {
            NSString *imgName = [NSString stringWithFormat:@"Alpha%d", (int) indexPath.item];
            cell.iconImageView.image = [UIImage imageNamed:imgName];
            cell.titleLbl.text = nil;

            //赋初始选择状态
            CGFloat settedAlpha = FloatValueFromThemeKey(@"btn.opacity");
            CGFloat alpha = ((NSNumber *) _btnAlphaDic[imgName]).floatValue;
            cell.selImgView.hidden = settedAlpha != alpha;
            break;
        }
            //按阴影框宽度
        case 5: {
            NSString *imgName = [NSString stringWithFormat:@"ShadowWidth%d", (int) indexPath.item];
            cell.iconImageView.image = [UIImage imageNamed:imgName];
            cell.titleLbl.text = nil;

            //赋初始选择状态
            CGFloat settedShadowWidth = FloatValueFromThemeKey(@"btn.shadow.height");
            CGFloat shadowWidth = ((NSNumber *) _btnShadowWidthDic[imgName]).floatValue;
            cell.selImgView.hidden = settedShadowWidth != shadowWidth;
            break;
        }
            //按键阴影颜色
        case 6: {
            [self setupCellIconImg:cell WithIndexPath:indexPath withColor:_btnShadowColor];
            cell.selImgView.hidden = YES;
            cell.titleLbl.text = nil;
            break;
        }
            //字体颜色
        case 7: {
            UIColor *color = _fontColor;
            cell.titleLbl.text = NSLocalizedString(@"Normal Color", nil);
            if (indexPath.item == 1) {
                color = _fontHighColor;
                cell.titleLbl.text = NSLocalizedString(@"High Color", nil);
            }
            [self setupCellIconImg:cell WithIndexPath:indexPath withColor:color];
            cell.selImgView.hidden = YES;
            break;
        }
            //字体名称
        case 8: {
            UIColor *bgcolor = [UIColor whiteColor];
            CGFloat scale = [UIScreen mainScreen].scale;
            CGSize cellImgSize = CGSizeMake(Grid_Cell_W * scale, Grid_Cell_W * scale);
            NSString *fontName = _fontNames[(NSUInteger) indexPath.item];

            //根据fontText,font以及cellImgSize,确定合适的fontSize,得到合适的文本矩形区attrTextRect
            NSString *fontText = @"Abc";
            CGFloat fontSize = 64;
            NSDictionary *attributes = nil;
            NSAttributedString *attrText = nil;
            CGRect attrTextRect = CGRectMake(0, 0, cellImgSize.width, cellImgSize.height);
            do {
                fontSize -= 4;
                attributes = @{NSFontAttributeName : [UIFont fontWithName:fontName size:fontSize],
                        NSForegroundColorAttributeName : [UIColor blackColor],
                        NSBackgroundColorAttributeName : [UIColor clearColor]};
                attrText = [[NSAttributedString alloc] initWithString:fontText attributes:attributes];
                attrTextRect = [attrText boundingRectWithSize:CGSizeMake(attrText.size.width, CGFLOAT_MAX)
                                                      options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
            } while (fontSize > 36 && (attrTextRect.size.width > cellImgSize.width || attrTextRect.size.height > cellImgSize.height));


            UIImage *textImg = [UIImage imageFromString:fontText attributes:attributes size:attrTextRect.size];
            UIImage *colorImage = [UIImage imageFromColor:bgcolor withRect:CGRectMake(0, 0, cellImgSize.width, cellImgSize.height)];

            //合并图片
            CGRect logoFrame = CGRectMake((colorImage.size.width - textImg.size.width) / 2, (colorImage.size.height - textImg.size.height) / 2, textImg.size.width, textImg.size.height);
            UIImage *combinedImg = [UIImage addImageToImage:colorImage withImage2:textImg andRect:logoFrame withImageSize:cellImgSize];

            cell.iconImageView.image = combinedImg;
            cell.titleLbl.text = fontName;

            //赋初始选择状态
            NSString *settedFontName = StringValueFromThemeKey(@"font.name");
            cell.selImgView.hidden = ![fontName isEqualToString:settedFontName];
            break;
        }
        default:
            break;
    }

    cell.delegate = self;
    [cell updateLabelTextSize];
    return cell;
}

//设置CollectionView的header,footer
- (LWGridHeader *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        LWGridHeader *header = (LWGridHeader *) [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"Header" forIndexPath:indexPath];

        switch (indexPath.section) {
            //按键颜色
            case 0: {
                header.titleLbl.text = NSLocalizedString(@"Button Color", nil);
                break;
            }
                //按键圆角
            case 1: {
                header.titleLbl.text = NSLocalizedString(@"Button CornerRadius", nil);
                break;
            }
                //按键边框宽度
            case 2: {
                header.titleLbl.text = NSLocalizedString(@"Border Width", nil);
                break;
            }
                //按键边框颜色
            case 3: {
                header.titleLbl.text = NSLocalizedString(@"Border Color", nil);
                break;
            }
                //按键透明度
            case 4: {
                header.titleLbl.text = NSLocalizedString(@"Button Alpha", nil);
                break;
            }
                //按键阴影宽度
            case 5: {
                header.titleLbl.text = NSLocalizedString(@"Shadow Width", nil);
                break;
            }
                //按键阴影颜色
            case 6: {
                header.titleLbl.text = NSLocalizedString(@"Shadow Color", nil);
                break;
            }
                //字体颜色
            case 7: {
                header.titleLbl.text = NSLocalizedString(@"Font Color", nil);
                break;
            }
                //字体名称
            case 8: {
                header.titleLbl.text = NSLocalizedString(@"Font Name", nil);
                break;
            }
            default:
                break;
        }

        return header;
    }
    return nil;
}


//给指定indexPath位置的cell设置样式
- (void)setupCellIconImg:(LWGridViewCell *)cell WithIndexPath:(NSIndexPath *)indexPath withColor:(UIColor *)color {
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize cellImgSize = CGSizeMake(Grid_Cell_W * scale, Grid_Cell_W * scale);

    UIImage *colorImage = [UIImage imageFromColor:color withRect:CGRectMake(0, 0, cellImgSize.width, cellImgSize.height)];
    cell.iconImageView.image = colorImage;
}

#pragma mark - UICollectionDelegate Implementation

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return !self.editing;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //LWGridViewCell *cell = (LWGridViewCell *) [collectionView cellForItemAtIndexPath:indexPath];


    switch (indexPath.section) {
        //按键颜色
        case 0: {
            [self btnColorWithIndexPath:indexPath];
            break;
        }
            //按键圆角
        case 1: {
            [self btnCornerRadiusesWithIndexPath:indexPath];
            break;
        }
            //按键边框宽度
        case 2: {
            [self btnBorderWidthWithIndexPath:indexPath];
            break;
        }
            //按键边框颜色
        case 3: {
            [self btnBorderColorWithIndexPath:indexPath];
            break;
        }
            //按键透明度
        case 4: {
            [self btnAlphaWithIndexPath:indexPath];
            break;
        }
            //按键阴影宽度
        case 5: {
            [self btnShadowWidthWithIndexPath:indexPath];
            break;
        }
            //按键阴影颜色
        case 6: {
            [self btnShadowColorWithIndexPath:indexPath];
            break;
        }
            //字体颜色
        case 7: {
            [self fontColorWithIndexPath:indexPath];

            break;
        }
            //字体名称
        case 8: {
            [self fontNameWithIndexPath:indexPath];
            break;
        }
        default:
            break;
    }

}

//设置按键颜色
- (void)btnColorWithIndexPath:(NSIndexPath *)indexPath {
    //显示ColorPickerView
    [self showColorPickerView];
    __weak typeof(self) weakSelf = self;
    //正常色
    if (indexPath.item == 0) {
        _colorPickerView.updateColorBlock = ^(UIColor *color) {
            weakSelf.btnNormalColor = color;
            UIColorValueToThemeFileByKey(color, @"btn.content.color");

//                    //刷新section
//                    [weakSelf performBatchUpdates:^{
//                        [weakSelf reloadSections:[NSIndexSet indexSetWithIndex:0]];
//                    }                  completion:nil];
            //todo:刷新UI
            [weakSelf reloadData];

            //删除colorPickerView
            [weakSelf.colorPickerView removeFromSuperview];
            weakSelf.colorPickerView = nil;
        };

        //高亮色
    } else if (indexPath.item == 1) {
        _colorPickerView.updateColorBlock = ^(UIColor *color) {
            weakSelf.btnHighColor = color;
            UIColorValueToThemeFileByKey(color, @"btn.content.highlightColor");

            //todo:刷新UI
            [weakSelf reloadData];

            //删除colorPickerView
            [weakSelf.colorPickerView removeFromSuperview];
            weakSelf.colorPickerView = nil;
        };
    }
}

//设置按键圆角
- (void)btnCornerRadiusesWithIndexPath:(NSIndexPath *)indexPath {
    LWGridViewCell *cell = (LWGridViewCell *) [self cellForItemAtIndexPath:indexPath];
    NSString *imgName = [NSString stringWithFormat:@"CornerRadiuse%d", (int) indexPath.item];

    //赋初始选择状态
    CGFloat settedCornerRadius = FloatValueFromThemeKey(@"btn.cornerRadius");
    CGFloat cornerRadius = ((NSNumber *) _btnCornerRadiuseDic[imgName]).floatValue;

    //把已选择的设置为未选择
    if(settedCornerRadius != cornerRadius){
        NSString *key = [_btnCornerRadiuseDic allKeysForObject:@(settedCornerRadius)].firstObject;
        NSUInteger item = (NSUInteger) [key substringFromIndex:key.length-2].intValue;
        LWGridViewCell *hiddenCell = (LWGridViewCell *) [self cellForItemAtIndexPath:[NSIndexPath indexPathForItem:item inSection:indexPath.section]];
        hiddenCell.selImgView.hidden = YES;
    }
    //重新设置cell状态
    cell.selImgView.hidden = NO;
    FloatValueToThemeFileByKey(@(cornerRadius), @"btn.cornerRadius");
    [self reloadData];
}

//设置按键透明度
- (void)btnAlphaWithIndexPath:(NSIndexPath *)indexPath {
    LWGridViewCell *cell = (LWGridViewCell *) [self cellForItemAtIndexPath:indexPath];
    NSString *imgName = [NSString stringWithFormat:@"Alpha%d", (int) indexPath.item];

    //赋初始选择状态
    CGFloat settedAlpha = FloatValueFromThemeKey(@"btn.opacity");
    CGFloat alpha = ((NSNumber *) _btnAlphaDic[imgName]).floatValue;

    //把已选择的设置为未选择
    if(settedAlpha != alpha){
        NSString *key = [_btnAlphaDic allKeysForObject:@(settedAlpha)].firstObject;
        NSUInteger item = (NSUInteger) [key substringFromIndex:key.length-2].intValue;
        LWGridViewCell *hiddenCell = (LWGridViewCell *) [self cellForItemAtIndexPath:[NSIndexPath indexPathForItem:item inSection:indexPath.section]];
        hiddenCell.selImgView.hidden = YES;
    }
    //重新设置cell状态
    cell.selImgView.hidden = NO;
    FloatValueToThemeFileByKey(@(alpha), @"btn.opacity");
    [self reloadData];
}


//设置按键边框宽度
- (void)btnBorderWidthWithIndexPath:(NSIndexPath *)indexPath {
    LWGridViewCell *cell = (LWGridViewCell *) [self cellForItemAtIndexPath:indexPath];
    NSString *imgName = [NSString stringWithFormat:@"BorderWidth%d", (int) indexPath.item];

    //赋初始选择状态
    CGFloat settedBorderWidth = FloatValueFromThemeKey(@"btn.borderWidth");
    CGFloat borderWidth = ((NSNumber *) _btnBorderWidthDic[imgName]).floatValue;

    //把已选择的设置为未选择
    if(settedBorderWidth != borderWidth){
        NSString *key = [_btnBorderWidthDic allKeysForObject:@(settedBorderWidth)].firstObject;
        NSUInteger item = (NSUInteger) [key substringFromIndex:key.length-1].intValue;
        NSUInteger section = (NSUInteger) indexPath.section;
        LWGridViewCell *hiddenCell = (LWGridViewCell *) [self cellForItemAtIndexPath:[NSIndexPath indexPathForItem:item inSection:section]];
        hiddenCell.selImgView.hidden = YES;
    }
    //重新设置cell状态
    cell.selImgView.hidden = NO;
    FloatValueToThemeFileByKey(@(borderWidth), @"btn.borderWidth");
    [self reloadData];
}

//按键边框颜色
- (void)btnBorderColorWithIndexPath:(NSIndexPath *)indexPath {
    //显示ColorPickerView
    [self showColorPickerView];
    __weak typeof(self) weakSelf = self;
    //正常色
    _colorPickerView.updateColorBlock = ^(UIColor *color) {
        weakSelf.btnBorderColor = color;
        UIColorValueToThemeFileByKey(color, @"btn.borderColor");
        //todo:刷新UI
        [weakSelf reloadData];

        //删除colorPickerView
        [weakSelf.colorPickerView removeFromSuperview];
        weakSelf.colorPickerView = nil;
    };
}

//按键阴影宽度
- (void)btnShadowWidthWithIndexPath:(NSIndexPath *)indexPath {
    LWGridViewCell *cell = (LWGridViewCell *) [self cellForItemAtIndexPath:indexPath];
    NSString *imgName = [NSString stringWithFormat:@"ShadowWidth%d", (int) indexPath.item];

    //赋初始选择状态
    CGFloat settedShadowWidth = FloatValueFromThemeKey(@"btn.shadow.height");
    CGFloat shadowWidth = ((NSNumber *) _btnShadowWidthDic[imgName]).floatValue;

    //把已选择的设置为未选择
    if(settedShadowWidth != shadowWidth){
        NSString *key = [_btnShadowWidthDic allKeysForObject:@(settedShadowWidth)].firstObject;
        NSUInteger item = (NSUInteger) [key substringFromIndex:key.length-1].intValue;
        LWGridViewCell *hiddenCell = (LWGridViewCell *) [self cellForItemAtIndexPath:[NSIndexPath indexPathForItem:item inSection:indexPath.section]];
        hiddenCell.selImgView.hidden = YES;
    }
    //重新设置cell状态
    cell.selImgView.hidden = NO;
    FloatValueToThemeFileByKey(@(shadowWidth), @"btn.shadow.height");
    [self reloadData];
}

//按键阴影颜色
- (void)btnShadowColorWithIndexPath:(NSIndexPath *)indexPath {
    //显示ColorPickerView
    [self showColorPickerView];
    __weak typeof(self) weakSelf = self;
    //正常色
    _colorPickerView.updateColorBlock = ^(UIColor *color) {
        weakSelf.btnShadowColor = color;
        UIColorValueToThemeFileByKey(color, @"btn.shadow.color");
        //todo:刷新UI
        [weakSelf reloadData];

        //删除colorPickerView
        [weakSelf.colorPickerView removeFromSuperview];
        weakSelf.colorPickerView = nil;
    };

}

//设置字体颜色
- (void)fontColorWithIndexPath:(NSIndexPath *)indexPath {
//显示ColorPickerView
    [self showColorPickerView];
    __weak typeof(self) weakSelf = self;
    if (indexPath.item == 0) {
        _colorPickerView.updateColorBlock = ^(UIColor *color) {
            weakSelf.fontColor = color;
            UIColorValueToThemeFileByKey(color, @"font.color");

            //todo:刷新UI
            [weakSelf reloadData];

            //删除colorPickerView
            [weakSelf.colorPickerView removeFromSuperview];
            weakSelf.colorPickerView = nil;
        };

        //高亮颜色
    } else if (indexPath.item == 1) {
        _colorPickerView.updateColorBlock = ^(UIColor *color) {
            weakSelf.fontHighColor = color;
            UIColorValueToThemeFileByKey(color, @"font.highlightColor");

            //todo:刷新UI
            [weakSelf reloadData];

            //删除colorPickerView
            [weakSelf.colorPickerView removeFromSuperview];
            weakSelf.colorPickerView = nil;
        };
    }
}

//设置字体名称
- (void)fontNameWithIndexPath:(NSIndexPath *)indexPath {
    LWGridViewCell *cell = (LWGridViewCell *) [self cellForItemAtIndexPath:indexPath];

    //赋初始选择状态
    NSString *settedFontName = StringValueFromThemeKey(@"font.name");
    NSString *fontName = _fontNames[(NSUInteger) indexPath.item];

    //把已选择的设置为未选择
    if([settedFontName isEqualToString:fontName]){
        NSUInteger item = [_fontNames indexOfObject:settedFontName];
        LWGridViewCell *hiddenCell = (LWGridViewCell *) [self cellForItemAtIndexPath:[NSIndexPath indexPathForItem:item inSection:indexPath.section]];
        hiddenCell.selImgView.hidden = YES;
    }
    //重新设置cell状态
    cell.selImgView.hidden = NO;
    StringValueToThemeFileByKey(fontName, @"font.name");
    [self reloadData];

}

//显示颜色选择视图
- (void)showColorPickerView {
    if (_colorPickerView) {
        [_colorPickerView removeFromSuperview];
        _colorPickerView = nil;
    }
    _colorPickerView = (LWColorPickerView *) [[NSBundle mainBundle] loadNibNamed:@"LWColorPickerView" owner:self options:nil][0];
    [self.superview addSubview:_colorPickerView];
    _colorPickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _colorPickerView.frame = self.frame;
    [self.superview bringSubviewToFront:_colorPickerView];
}


#pragma mark - LWSkinGridCellDelegate Implementation

//删除一个样式宫格
- (void)deleteButtonClickedInGridViewCell:(LWGridViewCell *)cell {

}


@end