//
//  GuidePageVC.m
//  SOGuidePage
//
//  Created by soson on 2018/8/21.
//  Copyright © 2018年 soson. All rights reserved.
//

#import "GuidePageVC.h"
#import "SOGuidePageView.h"
#import "ViewController.h"
#import "YLImageView.h"
#import "YLGIFImage.h"


/**  引导界面封装  **/
/** 支持普通图片
    支持gif图片
    支持普通图片和gif混合
 **/
@interface GuidePageVC ()<SOGuidePageViewDelegate>

@end

@implementation GuidePageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
 
    /**  支持Gif和普通图片混合 **/
    SOGuidePageView *guidePage = [[SOGuidePageView alloc] initWithImgsArray:@[@"1.gif", [UIImage imageNamed:@"img2"], @"img3", [UIImage imageNamed:@"img4"]] guidePageCurrentIdx:nil];
    //设置滚动到最后一张图片，继续滚动可以跳转到主页，实现代理方法lastImageGoToMainVC
    guidePage.isScrollLastImageToMainVC = YES;
    //设置背景颜色
    guidePage.guidePageBGColor = [UIColor blackColor];
    //设置pageControl的Y位置
    guidePage.pageY = 22;
    //设置page未选中图片
    guidePage.pageNormalImage = [UIImage imageNamed:@"dot_normal"];
    //设置page选中时的图片
    guidePage.pageCurrentImage = [UIImage imageNamed:@"dot_select"];
    guidePage.delegate = self;

    UIButton *test = [[UIButton alloc] initWithFrame:CGRectMake(100, 500, 150, 50)];
    test.backgroundColor = [UIColor yellowColor];
    [test addTarget:self action:@selector(enterClick) forControlEvents:UIControlEventTouchUpInside];
    [guidePage.imgs.lastObject addSubview:test];
    [self.view addSubview:guidePage];
    
    
    /**  支持全普通图片混合，可采用NSString名称或者UIIMage方式 **/
//    SOGuidePageView *guidePage = [[SOGuidePageView alloc] initWithImgsArray:@[@"img1", @"img2", @"img3",@"img4"] guidePageCurrentIdx:nil];
    //或者
//     SOGuidePageView *guidePage = [[SOGuidePageView alloc] initWithImgsArray:@[[UIImage imageNamed:@"img1"], [UIImage imageNamed:@"img2"], [UIImage imageNamed:@"img3"], [UIImage imageNamed:@"img4"]] guidePageCurrentIdx:nil];
    
//    //设置滚动到最后一张图片，继续滚动可以跳转到主页，实现代理方法lastImageGoToMainVC
//    guidePage.isScrollLastImageToMainVC = YES;
//    //设置背景颜色
//    guidePage.guidePageBGColor = [UIColor blackColor];
//    //设置pageControl的Y位置
//    guidePage.pageY = 22;
//    //设置page未选中图片
//    guidePage.pageNormalImage = [UIImage imageNamed:@"dot_normal"];
//    //设置page选中时的图片
//    guidePage.pageCurrentImage = [UIImage imageNamed:@"dot_select"];
//    guidePage.delegate = self;
//
//    UIButton *test = [[UIButton alloc] initWithFrame:CGRectMake(100, 500, 150, 50)];
//    test.backgroundColor = [UIColor yellowColor];
//    [test addTarget:self action:@selector(enterClick) forControlEvents:UIControlEventTouchUpInside];
//    [guidePage.imgs.lastObject addSubview:test];
//    [self.view addSubview:guidePage];
    
    /** 支持全Gif **/
//    SOGuidePageView *guidePage = [[SOGuidePageView alloc] initWithImgsArray:@[@"1.gif", @"2.gif", @"3.gif", @"4.gif"] guidePageCurrentIdx:nil];
//    //设置滚动到最后一张图片，继续滚动可以跳转到主页，实现代理方法lastImageGoToMainVC
//    guidePage.isScrollLastImageToMainVC = YES;
//    //设置背景颜色
//    guidePage.guidePageBGColor = [UIColor blackColor];
//    //设置pageControl的Y位置
//    guidePage.pageY = 22;
//    //设置page未选中图片
//    guidePage.pageNormalImage = [UIImage imageNamed:@"dot_normal"];
//    //设置page选中时的图片
//    guidePage.pageCurrentImage = [UIImage imageNamed:@"dot_select"];
//    guidePage.delegate = self;
//
//    UIButton *test = [[UIButton alloc] initWithFrame:CGRectMake(100, 500, 150, 50)];
//    test.backgroundColor = [UIColor yellowColor];
//    [test addTarget:self action:@selector(enterClick) forControlEvents:UIControlEventTouchUpInside];
//    [guidePage.imgs.lastObject addSubview:test];
//    [self.view addSubview:guidePage];
    
    
}

- (void)enterClick {
    ViewController *vc = [ViewController new];
    typedef void (^Animation)(void);
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    Animation animation = ^{
        BOOL oldState = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
        [UIApplication sharedApplication].keyWindow.rootViewController = vc;
        [UIView setAnimationsEnabled:oldState];
    };
    [UIView transitionWithView:window
                      duration:0.5f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:animation
                    completion:nil];
    [self removeFromParentViewController];
}


/**   SOGuidePageViewDelegate  **/
- (void)guidePageWithCurrentIdx:(NSInteger)currentIdx {
    NSLog(@"currentIdx::%li",currentIdx);
}

//滚动到最后一张图片，继续滚动就直接来到主界面，但是这个方法必须要guidePage.isScrollLastImageToMainVC = Yes
-(void)lastImageGoToMainVC{
    ViewController *vc = [ViewController new];
    typedef void (^Animation)(void);
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    Animation animation = ^{
        BOOL oldState = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
        [UIApplication sharedApplication].keyWindow.rootViewController = vc;
        [UIView setAnimationsEnabled:oldState];
    };
    [UIView transitionWithView:window
                      duration:0.5f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:animation
                    completion:nil];
    [self removeFromParentViewController];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
