//
//  ViewController.m
//  SOGuidePage
//
//  Created by soson on 2018/8/21.
//  Copyright © 2018年 soson. All rights reserved.
//

#import "ViewController.h"
#import "YLImageView.h"
#import "YLGIFImage.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor yellowColor];
    //Gif图片
    YLImageView* imageView = [[YLImageView alloc] initWithFrame:CGRectMake(0, 0, 375,667 )];
    [self.view addSubview:imageView];
    imageView.image = [YLGIFImage imageNamed:@"1.gif"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
