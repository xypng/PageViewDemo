//
//  UIColor+Calculate.h
//  ShengShiHuiHai
//
//  Created by XiaoYiPeng on 16/4/20.
//  Copyright © 2016年 tiansha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Calculate)

///计算到另一个颜色的过渡颜色，progress在0~1之间
- (UIColor *)colorTo:(UIColor *)color withProgress:(float)progress;

@end
