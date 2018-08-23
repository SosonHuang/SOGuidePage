//
//  SOGuidePageView.m
//  SOGuidePage
//
//  Created by soson on 2018/8/21.
//  Copyright © 2018年 soson. All rights reserved.
//

#import "SOGuidePageView.h"
#import "YLImageView.h"
#import "YLGIFImage.h"

#define kSOGuidePageViewVersion @"SoBundleShortVersion"
#define SOScreen_Frame  [UIScreen mainScreen].bounds
#define SOScreen_Width  [UIScreen mainScreen].bounds.size.width
#define SOScreen_Height [UIScreen mainScreen].bounds.size.height
#define SOUser_Defaults [NSUserDefaults standardUserDefaults]

static BOOL LasImageGoTo = false;

@interface SOGuidePageView ()<UIScrollViewDelegate>
@property(nonatomic, strong) NSMutableArray<UIImageView *> *imgsArr;  //图片集合
@property(nonatomic, strong) UIScrollView *scrollerView; //滚动View
@end


@implementation SOGuidePageView

+ (void)configAppWindow:(UIWindow *)window fromGuidePgaeViewController:(UIViewController *)guidePageViewController toMainViewController:(UIViewController *)mainViewController {
    
    //获取本地存储的版本
    NSString *localShortVersionStr = [[NSUserDefaults standardUserDefaults] objectForKey:kSOGuidePageViewVersion];
    
    //当前版本
    NSString *currentShortVersionStr = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    
    //比较
    if (!localShortVersionStr ||
        ([localShortVersionStr compare:currentShortVersionStr] == NSOrderedAscending)) {
        [[NSUserDefaults standardUserDefaults] setObject:currentShortVersionStr forKey:kSOGuidePageViewVersion];
        [[NSUserDefaults standardUserDefaults] synchronize];
        window.rootViewController = guidePageViewController;
    }else {
        window.rootViewController = mainViewController;
    }
}

- (instancetype)initWithImgsArray:(NSArray *)imgsArray guidePageCurrentIdx:(SOGuidePageViewCurrentIdx)guidePageCurrentIdx{
    self = [super initWithFrame:SOScreen_Frame];
    if (self) {
        UIScrollView *scrollerView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.scrollerView = scrollerView;
        scrollerView.tag = imgsArray.count-1;
        scrollerView.showsHorizontalScrollIndicator = NO;
        scrollerView.pagingEnabled = YES;
        scrollerView.delegate = self;
        scrollerView.backgroundColor = [UIColor whiteColor];
        [scrollerView setContentSize:CGSizeMake(SOScreen_Width*imgsArray.count, 0)];
        __weak __typeof(scrollerView)weakScrollerView = scrollerView;
        __weak __typeof(self)weakSelf = self;
        [imgsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            
            if ([obj isKindOfClass:[NSString class]]) {
                NSString * imagePre = obj;
                if ([imagePre containsString:@".gif"]) {
                    YLImageView* imageView = [[YLImageView alloc] initWithFrame:CGRectMake(idx*SOScreen_Width, 0, SOScreen_Width, SOScreen_Height)];
                    imageView.userInteractionEnabled = YES;
                    imageView.tag = idx;

                    imageView.image = [YLGIFImage imageNamed:obj];
                    [weakScrollerView addSubview:imageView];
                    [weakSelf.imgsArr addObject:imageView];
                    
                }else{
                    UIImageView *guidePgaeImgView = [[UIImageView alloc] initWithFrame:CGRectMake(idx*SOScreen_Width, 0, SOScreen_Width, SOScreen_Height)];
                    guidePgaeImgView.userInteractionEnabled = YES;
                    guidePgaeImgView.tag = idx;
                    UIImage *img = [UIImage imageNamed:obj];
                    if (img) {
                        guidePgaeImgView.image = img;
                    }else {
                        NSAssert(NO, @"没有图片");
                    }
                    [weakScrollerView addSubview:guidePgaeImgView];
                    [weakSelf.imgsArr addObject:guidePgaeImgView];
                }
            }else if ([obj isKindOfClass:[UIImage class]]) {
                UIImageView *guidePgaeImgView = [[UIImageView alloc] initWithFrame:CGRectMake(idx*SOScreen_Width, 0, SOScreen_Width, SOScreen_Height)];
                guidePgaeImgView.userInteractionEnabled = YES;
                guidePgaeImgView.tag = idx;
                guidePgaeImgView.image = obj;
                [weakScrollerView addSubview:guidePgaeImgView];
                [weakSelf.imgsArr addObject:guidePgaeImgView];
            }else {
                NSAssert(NO, @"没有图片");
            }
        }];
        [self addSubview:scrollerView];
        
        self.pageControl.numberOfPages = imgsArray.count;
        [self addSubview:self.pageControl];
        self.guidePageCurrentIdx = ^(NSInteger currentIdx) {
            if (guidePageCurrentIdx) {
                guidePageCurrentIdx(currentIdx);
            }
        };
        if (guidePageCurrentIdx) {//为了初始化完成后走一次回调，手动调起block
            guidePageCurrentIdx(0);
        }
    
    }
    return self;
}

- (SOPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[SOPageControl alloc] initWithFrame:CGRectMake(0, SOScreen_Height-22, SOScreen_Width, 22)];
    }
    return _pageControl;
}

- (void)setGuidePageBGColor:(UIColor *)guidePageBGColor {
    self.scrollerView.backgroundColor = guidePageBGColor;
}

- (void)setPageHidden:(BOOL)pageHidden {
    self.pageControl.hidden = pageHidden;
}


- (void)setPageCurrentImage:(UIImage *)pageCurrentImage {
    [self.pageControl setValue:pageCurrentImage forKey:@"pageImage"];
}

- (void)setPageNormalImage:(UIImage *)pageNormalImage {
    [self.pageControl setValue:pageNormalImage forKey:@"currentPageImage"];
}

- (void)setPageY:(CGFloat)pageY {
    self.pageControl.frame = CGRectMake(0, SOScreen_Height-(22+pageY), SOScreen_Width, 22);
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
//    CGFloat x = scrollView.contentOffset.x;
//    double page = x / SOScreen_Width;
//    if ((NSInteger)(page + 0.5) > scrollView.tag) {
//        return;
//    }
//    self.pageControl.currentPage = (NSInteger)(page + 0.5);
    
    
    CGFloat pageWidth = SOScreen_Width;
    int page = floor((scrollView.contentOffset.x - pageWidth /2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
    
    if (page == self.pageControl.currentPage && self.guidePageCurrentIdx) {
        self.guidePageCurrentIdx(self.pageControl.currentPage);
        if ([self.delegate respondsToSelector:@selector(guidePageWithCurrentIdx:)]) {
            [self.delegate guidePageWithCurrentIdx:self.pageControl.currentPage];
        }
    }
}

/** ScrollView 停止滚动 **/
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat pageWidth = SOScreen_Width;
    int page = floor((scrollView.contentOffset.x - pageWidth /2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
    
    
    if (page == self.imgsArr.count - 1 && LasImageGoTo == YES) {
        //如果设置了YES
        if (self.isScrollLastImageToMainVC) {
            //最后一张图片滚动的时候跳转到主页
            if ([self.delegate respondsToSelector:@selector(lastImageGoToMainVC)]) {
                [self.delegate lastImageGoToMainVC];
            }
        }
    }
    
    //如果大于本来图片就直接显示到主页相当于点击了按钮
    if (page == self.imgsArr.count - 1){
        if (LasImageGoTo == false) {
            LasImageGoTo = YES;
        }
    }else{
        //如果图片的不等于最后一张，设置为false
        LasImageGoTo = false;
    }
    
}

- (NSMutableArray<UIImageView *> *)imgsArr {
    if (!_imgsArr) {
        _imgsArr = [NSMutableArray array];
    }
    return _imgsArr;
}

/**  图片的集合 用于外面开启按钮添加到最后一张图片上 **/
- (NSArray<UIImageView *> *)imgs {
    return self.imgsArr;
}

@end
