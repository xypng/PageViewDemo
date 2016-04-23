//
//  UIView+Frame.m
//  PrivateSecretary
//
//  Created by 田沙 on 15/8/5.
//  Copyright (c) 2015年 田沙. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

-(float)getViewX
{
    return self.frame.origin.x;
}

-(float)getViewY
{
    return self.frame.origin.y;
}

-(float)getViewWidth
{
    return self.frame.size.width;
}

-(float)getViewHeight
{
    return self.frame.size.height;
}

- (void)setViewX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setViewY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (void)setViewWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setViewHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}


@end
