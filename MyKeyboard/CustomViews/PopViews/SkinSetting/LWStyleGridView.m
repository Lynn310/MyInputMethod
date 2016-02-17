//
// Created by luowei on 15/12/15.
// Copyright (c) 2015 luowei. All rights reserved.
//

#import "LWStyleGridView.h"
#import "UIResponder+Ext.h"
#import "LWDefines.h"
#import "UIImage+Color.h"

//样式设置
@implementation LWStyleGridView {

}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {

        self.backgroundColor = UIColorValueFromThemeKey(@"popView.backgroundColor");

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
//    _btnNormalColor = [LWThemeManager getColorWithKey:Key_Btn_NormalColor];
//    _btnHighColor = [LWThemeManager getColorWithKey:Key_Btn_HighColor];
    _btnNormalColor = UIColorValueFromThemeKey(@"btn.content.color");
    _btnHighColor = UIColorValueFromThemeKey(@"btn.content.highlightColor");
    
    //按键透明度
//    _btnAlpha = FloatValueFromThemeKey(@"btn.content.Opacity");
    _btnAlphas = Default_Btn_Alphas;
    
    //按键圆角
    _btnCornerRadiuses = Default_Btn_CornerRadiuses;
    
    //按键边框及阴影
    _btnBorderShadow = Default_Btn_BorderShadow;

    //字体颜色
    _fontColor = UIColorValueFromThemeKey(@"font.color");
    
    //字体名称
    _fontNames = Default_FontNames;
    
}

#pragma mark UICollectionDataSource Implementation

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    //section,一个选择颜色
    return 6;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    switch (section) {
        //按键颜色
        case 0: {
            return 2;
            break;
        }
            //按键透明度
        case 1: {
            return _btnAlphas.count;
            break;
        }
            //按键透明度
        case 2: {
            return _btnCornerRadiuses.count;
            break;
        }
            //按键边框及阴影
        case 3: {
            return _btnBorderShadow.count;
            break;
        }
            //字体颜色
        case 4: {
            return 1;
            break;
        }
            //字体名称
        case 5: {
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
            //文字颜色
            UIColor *color = _btnNormalColor;
            cell.titleLbl.text = NSLocalizedString(@"Normal Color", nil);
            if (indexPath.item == 1) {
                color = _btnHighColor;
                cell.titleLbl.text = NSLocalizedString(@"High Color", nil);
            }
            [self setupCellIconImg:cell WithIndexPath:indexPath withColor:color];
            break;
        }
            //按键透明度
        case 1: {
            cell.iconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"Alpha%d", (int) indexPath.item]];
            cell.titleLbl.text = nil;
            break;
        }
            //按键圆角
        case 2: {
            cell.iconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"CornerRadiuse%d", (int) indexPath.item]];
            cell.titleLbl.text = nil;
            break;
        }
            //按键边框及阴影
        case 3: {
            cell.iconImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"BorderShadow%d", (int) indexPath.item]];
            cell.titleLbl.text = nil;
            break;
        }
            //字体颜色
        case 4: {
            [self setupCellIconImg:cell WithIndexPath:indexPath withColor:_fontColor];
            cell.titleLbl.text = nil;
            break;
        }
            //字体名称
        case 5: {
            UIColor *bgcolor = [UIColor whiteColor];
            CGFloat scale = [UIScreen mainScreen].scale;
            CGSize cellImgSize = CGSizeMake(Grid_Cell_W * scale, Grid_Cell_W * scale);
            NSString *fontName = _fontNames[(NSUInteger) indexPath.item];

            //根据fontText,font以及cellImgSize,确定合适的fontSize,得到合适的文本矩形区attrTextRect
            NSString *fontText = @"Abc";
            CGFloat fontSize = 64;
            NSDictionary *attributes = nil;
            NSAttributedString *attrText = nil;
            CGRect attrTextRect = CGRectMake(0,0,cellImgSize.width,cellImgSize.height);
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
                //按键透明度
            case 1: {
                header.titleLbl.text = NSLocalizedString(@"Button Alpha", nil);
                break;
            }
                //按键圆角
            case 2: {
                header.titleLbl.text = NSLocalizedString(@"Button CornerRadius", nil);
                break;
            }
                //按键边框及阴影
            case 3: {
                header.titleLbl.text = NSLocalizedString(@"Button Border", nil);
                break;
            }
                //字体颜色
            case 4: {
                header.titleLbl.text = NSLocalizedString(@"Font Color", nil);
                break;
            }
                //字体名称
            case 5: {
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
    LWGridViewCell *cell = (LWGridViewCell *) [collectionView cellForItemAtIndexPath:indexPath];

    //todo:选择颜色

}


#pragma mark - LWSkinGridCellDelegate Implementation

//删除一个样式宫格
- (void)deleteButtonClickedInGridViewCell:(LWGridViewCell *)cell {

}


@end