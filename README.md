# SOGuidePage
版本第一次安装引导图，支持gif，普通图片！

使用方式

pod 'SOGuidePage'


新建一个引导ViewController，把代码加入即可

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

    //加入开启按钮
    UIButton *test = [[UIButton alloc] initWithFrame:CGRectMake(100, 500, 150, 50)];
    test.backgroundColor = [UIColor yellowColor];
    [test addTarget:self action:@selector(enterClick) forControlEvents:UIControlEventTouchUpInside];
    [guidePage.imgs.lastObject addSubview:test];
    [self.view addSubview:guidePage];
