//
//  ViewController.m
//  PageViewDemo
//
//  Created by XiaoYiPeng on 16/4/23.
//  Copyright © 2016年 XiaoYiPeng. All rights reserved.
//

#import "ViewController.h"
#import "PageView.h"

@interface ViewController ()<PageViewDelegate>
{
    PageView *_pageView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect rect = self.view.frame;
    rect.origin.y += 20;
    rect.size.height -= 80;
    _pageView = [[PageView alloc] initWithFrame:rect];
    _pageView.delegate = self;
    _pageView.menuButtonHeight = 35.0f;
    _pageView.pageTitles = [NSArray arrayWithObjects: @"新", @"全球好货", @"精选", @"买家秀", @"穿搭", nil];
    //设置颜色时黑色和白色不要用[UIColor blackColor]和[UIColor whiteColor],原因是
    /*
        [UIColor whiteColor] and [UIColor blackColor] use [UIColor colorWithWhite:alpha:] to create the UIColor.
        Which means this CGColorRef has only 2 color components,
        not 4 like colors created with [UIColor colorWithRed:green:blue:alpha:]
     */
    _pageView.menuButtonNomalColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    _pageView.menuButtonSelectedColor = [UIColor redColor];
    _pageView.underLineWidth = 0.0f;
    [self.view addSubview:_pageView];
    
    UIView *view1 = [[UIView alloc] init];
    view1.backgroundColor = [UIColor brownColor];
    UIView *view2 = [[UIView alloc] init];
    view2.backgroundColor = [UIColor blueColor];
    UIView *view3 = [[UIView alloc] init];
    view3.backgroundColor = [UIColor yellowColor];
    UIView *view4 = [[UIView alloc] init];
    view4.backgroundColor = [UIColor greenColor];
    UIView *view5 = [[UIView alloc] init];
    view5.backgroundColor = [UIColor cyanColor];
    
    _pageView.pageViews = [NSArray arrayWithObjects:view1, view2, view3, view4, view5, nil];
}

#pragma mark - PageViewDelegate
- (void)pageViewPagedTo:(NSInteger)page
{
    NSLog(@"翻到第%ld页", (long)page);
}
@end
