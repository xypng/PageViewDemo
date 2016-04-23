//
//  PageView.m
//  ShengShiHuiHai
//
//  Created by XiaoYiPeng on 16/4/11.
//  Copyright © 2016年 tiansha. All rights reserved.
//

#import "PageView.h"
#import "UIColor+Calculate.h"
#import "UIView+Frame.h"

#define RGBA(r,g,b,a)   [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define MenuButtonColorSelectedDefault RGBA(21, 189, 166, 1)   //按钮选中时的颜色
#define MenuButtonColorNormalDefault RGBA(112, 112, 112, 1)    //按钮正常时的颜色
#define MenuButtonHeightDefault 45                              //按钮的高
#define UnderLineHeight 2                               //下划线的高

@interface PageView()<UIScrollViewDelegate>
{
    UIView          *_underLineView;
    UIView          *_underLineContainView;
    UIView          *_menuButtonView;
    CGFloat         _menuButtonWidth;
    UIScrollView    *_pageScrollView;
    NSMutableArray<NSNumber *>         *_underLineWidths;
    NSNumber        *_underLineWidth;
}

@end

@implementation PageView
{
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置默认的按钮颜色和高
        _menuButtonNomalColor = MenuButtonColorNormalDefault;
        _menuButtonSelectedColor = MenuButtonColorSelectedDefault;
        _menuButtonHeight = MenuButtonHeightDefault;
        
        _underLineWidths = [[NSMutableArray<NSNumber *> alloc] init];
        
        [self addMenuView];
        [self addScrollPage];
    }
    return self;
}

///添加菜单按钮和下划线的superView
- (void)addMenuView
{
    _menuButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [self getViewWidth], UnderLineHeight)];
    _menuButtonView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_menuButtonView];
}

///添加页面
- (void)addScrollPage
{
    _pageScrollView = [[UIScrollView alloc] init];
    _pageScrollView.pagingEnabled = YES;
    _pageScrollView.bounces = NO;
    _pageScrollView.showsHorizontalScrollIndicator = NO;
    _pageScrollView.showsVerticalScrollIndicator = NO;
    _pageScrollView.directionalLockEnabled = YES;
    _pageScrollView.delegate = self;
    [self addSubview:_pageScrollView];
}

#pragma mark -
#pragma mark - setMethod
- (void) setPageTitles:(NSArray *)pageTitles
{
    _pageTitles = pageTitles;
    _menuButtonWidth = [self getViewWidth]/_pageTitles.count;
    
    //添加按钮
    for (int i=0; i<_pageTitles.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(_menuButtonWidth*i, 0, _menuButtonWidth, _menuButtonHeight);
        btn.backgroundColor = [UIColor clearColor];
        [btn setTitleColor:_menuButtonNomalColor forState:UIControlStateNormal];
        [btn setTitleColor:_menuButtonSelectedColor forState:UIControlStateSelected];
        
        [btn setTitle:_pageTitles[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.tag = i+1;
        [btn addTarget:self action:@selector(menuButtonPress:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            btn.selected = YES;
        }
        [_menuButtonView addSubview:btn];
        
        //下划线和按钮一样宽
        if (_underLineWidth == nil) {
            [_underLineWidths addObject:[NSNumber numberWithFloat:_menuButtonWidth]];
        }
        //下划线和字体一样宽
        else if ([_underLineWidth floatValue] == 0.0) {
            CGSize size = [pageTitles[i] sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:btn.titleLabel.font,NSFontAttributeName, nil]];
            CGFloat width = size.width;
            [_underLineWidths addObject:[NSNumber numberWithFloat:width]];
        }
        //使用自定义宽
        else {
            [_underLineWidths addObject:_underLineWidth];
        }
    }

    //添加按钮下的下划线
    _underLineView = [[UIView alloc] initWithFrame:CGRectMake(0, _menuButtonHeight-UnderLineHeight, _menuButtonWidth, UnderLineHeight)];
    _underLineView.backgroundColor = _menuButtonView.backgroundColor;
    
    CGFloat underLineWidth = [_underLineWidths[0] floatValue];
    _underLineContainView = [[UIView alloc] initWithFrame:CGRectMake((_menuButtonWidth-underLineWidth)/2, 0, underLineWidth, UnderLineHeight)];
    _underLineContainView.backgroundColor =  _menuButtonSelectedColor;
    
    [_underLineView addSubview:_underLineContainView];
    [_menuButtonView addSubview:_underLineView];
    
    _pageScrollView.contentSize = CGSizeMake([self getViewWidth]*_pageTitles.count, [self getViewHeight]-_menuButtonHeight);
}

- (void) setPageViews:(NSArray<UIView *> *)pageViews
{
    _pageViews = pageViews;
    //添加各个子view
    for (int i = 0; i < _pageViews.count; i++) {
        UIView *view = _pageViews[i];
        view.frame = CGRectMake([self getViewWidth]*i, 0, [self getViewWidth], [_pageScrollView getViewHeight]);
        [_pageScrollView addSubview:view];
    }
}

///设置按钮的高度
- (void) setMenuButtonHeight:(CGFloat)menuButtonHeight
{
    _menuButtonHeight = menuButtonHeight;
    [_menuButtonView setViewHeight:_menuButtonHeight];
    
    for (id view in _menuButtonView.subviews)
    {
        if ([view isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton *) view;
            [btn setViewHeight:_menuButtonHeight];
        }
    }
    
    [_pageScrollView setViewY:_menuButtonHeight];
    [_pageScrollView setViewHeight:[self getViewHeight]-_menuButtonHeight];
    CGSize size = _pageScrollView.contentSize;
    size.height = [self getViewHeight]-_menuButtonHeight;
    _pageScrollView.contentSize = size;
    for (UIView *view in _pageScrollView.subviews) {
        [view setViewHeight:[self getViewHeight]-_menuButtonHeight];
    }
    
    [_underLineView setViewY:_menuButtonHeight-UnderLineHeight];
}

- (void)setMenuButtonNomalColor:(UIColor *)menuButtonNomalColor
{
    _menuButtonNomalColor = menuButtonNomalColor;
    if (_pageTitles == nil) {
        return;
    }
    for (int i=1; i<_pageTitles.count; i++) {
        UIButton *btn = (UIButton *)[_menuButtonView viewWithTag:i+1];
        [btn setTitleColor:_menuButtonNomalColor forState:UIControlStateNormal];
    }
}

- (void)setMenuButtonSelectedColor:(UIColor *)menuButtonSelectedColor
{
    _menuButtonSelectedColor = menuButtonSelectedColor;
    if (_pageTitles==nil) {
        return;
    }
    for (int i=0; i<_pageTitles.count; i++) {
        UIButton *btn = (UIButton *)[_menuButtonView viewWithTag:i+1];
        [btn setTitleColor:_menuButtonSelectedColor forState:UIControlStateSelected];
    }
    UIButton *firstButton = (UIButton *)[_menuButtonView viewWithTag:1];
    firstButton.selected = YES;
    _underLineContainView.backgroundColor = _menuButtonSelectedColor;
}

- (void)setUnderLineWidth:(CGFloat)underLineWidth
{
    _underLineWidth = [NSNumber numberWithFloat:underLineWidth];
    //如果还没设置标题，就等设置标题的时候确定下划线宽
    if (_pageTitles == nil) {
        return;
    }
    [_underLineWidths removeAllObjects];
    //下划线和字体一样宽
    if (underLineWidth == 0.0) {
        for (int i=0; i<_pageTitles.count; i++) {
            UIButton *btn = (UIButton *)[_menuButtonView viewWithTag:i+1];
            CGSize size = [_pageTitles[i] sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:btn.titleLabel.font, NSFontAttributeName, nil]];
            CGFloat width = size.width;
            [_underLineWidths addObject:[NSNumber numberWithFloat:width]];
        }
    }
    //下划线宽度由用户设置
    else {
        [_underLineWidths addObject:[NSNumber numberWithFloat:underLineWidth]];
    }
    
    CGFloat undeLineFloat = [_underLineWidths[0] floatValue];
    _underLineContainView.frame = CGRectMake((_menuButtonWidth-undeLineFloat)/2, 0, undeLineFloat, UnderLineHeight);
}

- (void)addView:(UIView *)view atPage:(NSInteger)index
{
    view.frame = CGRectMake([self getViewWidth]*index, 0, [self getViewWidth], [_pageScrollView getViewHeight]);
    [_pageScrollView addSubview:view];
}

#pragma mark -
#pragma mark - IBAction
- (void)menuButtonPress:(UIButton *)btn
{
    [_pageScrollView setContentOffset:CGPointMake([self getViewWidth]*(btn.tag-1), 0) animated:YES];
    if ([self.delegate respondsToSelector:@selector(pageViewPagedTo:)]) {
        [self.delegate pageViewPagedTo:btn.tag];
    }
}

#pragma mark -
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == _pageScrollView) {
        int currentPage = scrollView.contentOffset.x/[self getViewWidth]+1;
        if ([self.delegate respondsToSelector:@selector(pageViewPagedTo:)]) {
            [self.delegate pageViewPagedTo:currentPage];
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _pageScrollView) {
        if (scrollView.contentOffset.x>0 && scrollView.contentOffset.x< (scrollView.contentSize.width - [scrollView getViewWidth])) {
            //让下划线跟着一块动
            CGFloat menuButtonBackgroundFrameX = ([scrollView getViewWidth] * (scrollView.contentOffset.x/scrollView.contentSize.width));
            [_underLineView setViewX:menuButtonBackgroundFrameX];
            
            //计算移动的比例
            int pageIndex = (int)(scrollView.contentOffset.x/[scrollView getViewWidth]) + 1;
            float offSet = scrollView.contentOffset.x - [scrollView getViewWidth]*(pageIndex-1);
            float prorate = offSet/[scrollView getViewWidth];
            
            //下划线现在的宽和它将要过渡到的宽度
            CGFloat nowWidth = [_underLineWidths[pageIndex-1] floatValue];
            CGFloat willWidth = [_underLineWidths[pageIndex] floatValue];
            //根据比例得到它应该的宽
            CGFloat width = (willWidth-nowWidth)*prorate + nowWidth;
            _underLineContainView.frame = CGRectMake((_menuButtonWidth-width)/2, 0, width, UnderLineHeight);
            
            //找到前一个按钮和后一个按钮
            UIButton *btn1 = (UIButton *)[_menuButtonView viewWithTag:pageIndex];
            UIButton *btn2 = (UIButton *)[_menuButtonView viewWithTag:pageIndex+1];
            //修改它们的颜色
            btn1.titleLabel.textColor = [_menuButtonSelectedColor colorTo:_menuButtonNomalColor withProgress:prorate];
            btn2.titleLabel.textColor = [_menuButtonNomalColor colorTo:_menuButtonSelectedColor withProgress:prorate];

        }
    }
}

#pragma mark - lifecycle
- (void)layoutSubviews
{
    _pageScrollView.frame = CGRectMake(0, _menuButtonHeight, [self getViewWidth], [self getViewHeight]-_menuButtonHeight);
    CGSize size = _pageScrollView.contentSize;
    size.height = [self getViewHeight]-_menuButtonHeight;
    _pageScrollView.contentSize = size;
    
    for (UIView *view in _pageScrollView.subviews) {
        [view setViewHeight:[self getViewHeight]-_menuButtonHeight];
    }
}

@end
