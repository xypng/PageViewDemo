//
//  UIView+Frame.h
//  PrivateSecretary
//
//  Created by 田沙 on 15/8/5.
//  Copyright (c) 2015年 田沙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

/**
 *  获取view所在X轴位置
 *
 *  @return <#return value description#>
 */
-(float)getViewX;

/**
 *  获取view所在Y轴位置
 *
 *  @return <#return value description#>
 */
-(float)getViewY;

/**
 *  获取view的高与宽
 *
 *  @return <#return value description#>
 */
-(float)getViewWidth;
-(float)getViewHeight;

- (void)setViewX:(CGFloat)x;
- (void)setViewY:(CGFloat)y;
- (void)setViewWidth:(CGFloat)width;
- (void)setViewHeight:(CGFloat)height;

@end
