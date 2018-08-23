//
//  SOGuidePageView.h
//  SOGuidePage
//
//  Created by soson on 2018/8/21.
//  Copyright © 2018年 soson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SOPageControl.h"

@protocol SOGuidePageViewDelegate<NSObject>
@optional
/** 当前滚动到的界面索引 */
- (void)guidePageWithCurrentIdx:(NSInteger)currentIdx;

- (void)lastImageGoToMainVC;



@end
@interface SOGuidePageView : UIView

/** 背景颜色/默认白色 */
@property(strong, nonatomic) UIColor   *guidePageBGColor;

/** pageContro/更多自定义page可是此属性 */
@property (strong, nonatomic) SOPageControl *pageControl;

/** 是否显示pageControl/默认NO(不隐藏) */
@property(assign, nonatomic) BOOL        pageHidden;

/** pageControl未选中时图片 */
@property(strong, nonatomic) UIImage    *pageNormalImage;

/** pageControl选中时的图片 */
@property(strong, nonatomic) UIImage    *pageCurrentImage;

/** pageControl的Y值 */
@property(assign, nonatomic) CGFloat     pageY;

/** 是否滚动到最后一张图片的时候跳转到主界面 */
@property(assign, nonatomic) BOOL     isScrollLastImageToMainVC;

/** 图片内容/可用于添加内容 */
@property(nonatomic, strong, readonly) NSArray<UIImageView *> *imgs;


/** 代理 **/
@property(nonatomic, weak) id <SOGuidePageViewDelegate>delegate;

/** block **/
typedef void (^SOGuidePageViewCurrentIdx)(NSInteger currentIdx);
@property(nonatomic, copy) SOGuidePageViewCurrentIdx guidePageCurrentIdx;



/**
 AppDelegate中调用
 
 @param window 主window
 @param guidePageViewController 引导页控制器
 @param mainViewController 首页控制器
 */
+ (void)configAppWindow:(UIWindow *)window fromGuidePgaeViewController:(UIViewController *)guidePageViewController toMainViewController:(UIViewController *)mainViewController;


/**
 初始化
 
 @param imgsArray 数据源（支持NSString/UIImage）
 @param guidePageCurrentIdx block回调
 @return DWGuidePage
 */
- (instancetype)initWithImgsArray:(NSArray *)imgsArray guidePageCurrentIdx:(SOGuidePageViewCurrentIdx)guidePageCurrentIdx;

@end
