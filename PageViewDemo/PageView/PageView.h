//
//  PageView.h
//  ShengShiHuiHai
//
//  Created by XiaoYiPeng on 16/4/11.
//  Copyright © 2016年 tiansha. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PageViewDelegate <NSObject>

@optional
///翻一第page页时调用，page是从 1 开始
- (void)pageViewPagedTo:(NSInteger)page;

@end

@interface PageView : UIView

///各个页面的标题
@property (nonatomic, strong) NSArray<NSString *>   *pageTitles;
///菜单按钮的高,默认是45
@property (nonatomic, assign) CGFloat               menuButtonHeight;
///每个页面的UIView
@property (nonatomic, strong) NSArray<UIView *>     *pageViews;
///按钮正常状态下的颜色，默认是RGBA(112, 112, 112, 1)
@property (nonatomic, strong) UIColor               *menuButtonNomalColor;
///按钮选中状态下的颜色，默认是RGBA(21, 189, 166, 1)
@property (nonatomic, strong) UIColor               *menuButtonSelectedColor;
///设置下划线宽度，默认和按钮等宽，设成0则和文字等宽。
- (void)setUnderLineWidth:(CGFloat)underLineWidth;

///添加view到第index页
- (void)addView:(UIView *)view atPage:(NSInteger)index;
///代理
@property (nonatomic, strong) id<PageViewDelegate> delegate;

@end
