//
//  SOPageControl.m
//  SOGuidePage
//
//  Created by soson on 2018/8/21.
//  Copyright © 2018年 soson. All rights reserved.
//

#import "SOPageControl.h"

@implementation SOPageControl

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


/** 重写方法设置圆点的大小   **/
- (void)setCurrentPage:(NSInteger)currentPage{
    [super setCurrentPage:currentPage];
    for (NSUInteger subviewIndex = 0; subviewIndex < [self.subviews count]; subviewIndex++) {
        UIImageView* subview = [self.subviews objectAtIndex:subviewIndex];
        CGSize size;
        size.height = 10;
        size.width = 10;
        [subview setFrame:CGRectMake(subview.frame.origin.x,subview.frame.origin.y,size.width,size.height)];
        
//        如果只改变当前选中的点的大小，用判断即可
//        if (subviewIndex == page){
//            UIImageView* subview = [self.subviews objectAtIndex:subviewIndex];
//            CGSize size;
//            size.height = 10;
//            size.width = 10;
//            [subview setFrame:CGRectMake(subview.frame.origin.x,subview.frame.origin.y,size.width,size.height)];
//        }
    }
    
    
}


@end
