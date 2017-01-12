//
//  UIView+CartoonBottom.m
//  TRProject
//
//  Created by Jian on 2016/11/22.
//  Copyright © 2016年 Tedu. All rights reserved.
//

#import "UIView+CartoonBottom.h"

@implementation UIView (CartoonBottom)

-(void)addCartoonBottomWithScrollView:(UIScrollView *)scrollView
{
    static NSMutableArray *imageNames;
    if (!imageNames)
    {
        imageNames = [NSMutableArray array];
        for (NSInteger i = 0; i < 19; i ++)
        {
            NSString *image = [NSString stringWithFormat:@"bubble_%ld_57x63_",i];
            [imageNames addObject:image];
        }
    }
    
    UIImageView *iconIV = [self viewWithTag:123];
    
    if (!iconIV)
    {
        iconIV= [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bubble_0_57x63_"]];
        iconIV.tag = 123;
        [self addSubview:iconIV];
        [iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(63);
            make.centerX.equalTo(0);
        }];
//        iconIV.frame = CGRectMake(self.frame.size.width/2 - 57/2, self.frame.size.height, 57, 63);
//        NSLog(@"height %g",self.frame.size.height);

    }
    
    [self scrollViewScrollWithIconIV:iconIV andScroll:scrollView andImageNames:imageNames];
    
}

-(void)scrollViewScrollWithIconIV:(UIImageView*)iconIV andScroll:(UIScrollView *)scrollView andImageNames:(NSMutableArray*)imageNames
{
    //内容高度 = 偏移量y + 视图的高
    //最大偏移量 = 内容高 - 视图高
    CGFloat maxOffsetY = scrollView.contentSize.height - scrollView.bounds.size.height;
    //多余偏移量
    CGFloat deltaY = scrollView.contentOffset.y - maxOffsetY;
//    NSLog(@"deltaY %f",deltaY);
    if (deltaY >= 0 && deltaY <= 63 )
    {
        iconIV.image = [UIImage imageNamed:@"bubble_0_57x63_"];
        [iconIV mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(64 - deltaY);
        }];
//        iconIV.frame = CGRectMake(self.frame.size.width/2 - 57/2, self.frame.size.height - deltaY, 57, 63);
//        NSLog(@"height %g",self.frame.size.height);
    }
    //当偏移量>63 要切换泡泡
    if (deltaY >= 64  && deltaY <= 64 + 18)
    {
        int y = (int)deltaY - 64;
        iconIV.image = [UIImage imageNamed:imageNames[y]];
    }
}



@end
