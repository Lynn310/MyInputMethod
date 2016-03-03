//
// Created by luowei on 15/8/4.
// Copyright (c) 2015 luowei. All rights reserved.
//

#import "LWLeftTabView.h"
#import "LWDefines.h"
#import "Categories.h"
#import "MyKeyboardViewController.h"

@implementation LWLeftTabView {
    CALayer *_shadowlayer;      //阴影
    CALayer *_innerGlow;        //内边框
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.contentView.separatorColor = UIColorValueFromThemeKey(@"btn.borderColor");
}


/**
* layout 子视图
*/
- (void)layoutSubviews {

    //重设阴影大小
    CGFloat shadowHeight = FloatValueFromThemeKey(@"btn.shadow.height");
    _shadowlayer.frame = CGRectOffset(_contentView.frame, 0, shadowHeight/2);
    _shadowlayer.frame = CGRectMake(_contentView.frame.origin.x, (CGFloat) (_contentView.frame.origin.y + _contentView.frame.size.height - shadowHeight/2),_contentView.frame.size.width, shadowHeight);

    [super layoutSubviews];
}

/**
* 设置dataList数据源
*/
- (void)setupDataList:(NSArray *)dataList {
    self.dataList = dataList;
    [self.contentView reloadData];
}

/**
* 给contentView添加内边框
*/
- (void)setupInnerGlow {
    if (!_innerGlow) {
        _innerGlow = [CALayer layer];
        _innerGlow.cornerRadius = FloatValueFromThemeKey(@"btn.innerBorder.cornerRadius");
        _innerGlow.borderWidth = FloatValueFromThemeKey(@"btn.innerBorder.borderWidth");
        _innerGlow.borderColor = CGColorValueFromThemeKey(@"btn.innerBorder.borderColor");
        _innerGlow.opacity = 0.5;

        [_contentView.layer insertSublayer:_innerGlow atIndex:2];
    }
}

/**
* 给contentView添加外边框
*/
- (void)setupBorder {
    CALayer *layer = _contentView.layer;
    layer.cornerRadius = FloatValueFromThemeKey(@"btn.cornerRadius");
    layer.borderWidth = FloatValueFromThemeKey(@"btn.borderWidth");
    layer.borderColor = CGColorValueFromThemeKey(@"btn.borderColor");
}

/**
* 给contentView添加阴影
*/
- (void)setupShadowLayer {

    if (_shadowlayer) {
        [_shadowlayer removeFromSuperlayer];
        _shadowlayer = nil;
    }
    // 给按钮添加阴影层
    _shadowlayer = [CALayer layer];
    _shadowlayer.contentsScale = self.layer.contentsScale;
    _shadowlayer.contentsScale = self.layer.contentsScale;
    _shadowlayer.backgroundColor = CGColorValueFromThemeKey(@"btn.shadow.color");

    CGFloat shadowHeight = FloatValueFromThemeKey(@"btn.shadow.height");
    _shadowlayer.cornerRadius = (CGFloat)(FloatValueFromThemeKey(@"btn.cornerRadius")+shadowHeight/2);

    _shadowlayer.frame = CGRectMake(_contentView.frame.origin.x, (CGFloat) (_contentView.frame.origin.y + _contentView.frame.size.height - shadowHeight/2),_contentView.frame.size.width, shadowHeight);
    [self.layer insertSublayer:_shadowlayer below:_contentView.layer];
}

#pragma mark ----- UITableViewDatasource Implementation -----

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];

    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellId];
    }
    UILabel *textLabel = (UILabel *) [cell.contentView viewWithTag:10];
    if (!textLabel) {
        textLabel = [[UILabel alloc] init];
        textLabel.tag = 10;
        [cell.contentView addSubview:textLabel];
    }

    textLabel.font = [UIFont fontWithName:StringValueFromThemeKey(@"font.name") size:FloatValueFromThemeKey(@"btn.mainLabel.fontSize")];
    textLabel.textColor = UIColorValueFromThemeKey(@"font.color");
    textLabel.text = self.dataList[(NSUInteger) indexPath.row];

    [textLabel sizeToFit];
    textLabel.center = cell.contentView.center;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return Cell_Height;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [UIColor clearColor];
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:Cell_SeparatorInset];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *text = nil;
    UILabel *textLabel = (UILabel *) [cell.contentView viewWithTag:10];
    if (textLabel) {
        text = textLabel.text;
    }

    [self.responderKBViewController insertText:text];

    [tableView deselectRowAtIndexPath:indexPath animated:NO];

}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UILabel *textLabel = (UILabel *)[cell viewWithTag:10];
    if (textLabel) {
        textLabel.textColor = UIColorValueFromThemeKey(@"font.highlightColor");
    }
    cell.contentView.backgroundColor = [UIColor clearColor];
}


- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UILabel *textLabel = (UILabel *)[cell viewWithTag:10];
    if (textLabel) {
        textLabel.textColor = UIColorValueFromThemeKey(@"font.color");
    }
    cell.contentView.backgroundColor = [UIColor clearColor];
}


@end
