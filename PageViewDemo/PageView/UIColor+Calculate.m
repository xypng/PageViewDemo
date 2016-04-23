//
//  UIColor+Calculate.m
//  ShengShiHuiHai
//
//  Created by XiaoYiPeng on 16/4/20.
//  Copyright © 2016年 tiansha. All rights reserved.
//

#import "UIColor+Calculate.h"

@implementation UIColor (Calculate)

///计算到另一个颜色的过渡颜色，progress在0~1之间
- (UIColor *)colorTo:(UIColor *)toColor withProgress:(float)progress
{
    CGFloat red = CGColorGetComponents(self.CGColor)[0] +
    (CGColorGetComponents(toColor.CGColor)[0] -  CGColorGetComponents(self.CGColor)[0])*progress;
    
    CGFloat green = CGColorGetComponents(self.CGColor)[1] +
    (CGColorGetComponents(toColor.CGColor)[1] -  CGColorGetComponents(self.CGColor)[1])*progress;
    
    CGFloat blue = CGColorGetComponents(self.CGColor)[2] +
    (CGColorGetComponents(toColor.CGColor)[2] -  CGColorGetComponents(self.CGColor)[2])*progress;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1];

}

@end
