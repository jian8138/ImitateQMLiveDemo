//
//  UIScrollView+Refresh.m
//  TRProject
//
//  Created by Jian on 2016/11/21.
//  Copyright © 2016年 Tedu. All rights reserved.
//

#import "UIScrollView+Refresh.h"
#import "TRRefreshGifHeader.h"

@implementation UIScrollView (Refresh)


-(NSArray*)createImagesWithName:(NSString*)name AndCount:(NSInteger)count
{
    NSMutableArray *images = [NSMutableArray array];
    for (NSInteger i  = 1 ; i <= count; i++)
    {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%ld",name,i]];
        [images addObject:image];
    }
    return images.copy;
}

-(void)addHeaderRefresh:(void(^)())block
{
    TRRefreshGifHeader *header = [TRRefreshGifHeader headerWithRefreshingBlock:^{
        !block ?: block();
    }];
    self.mj_header = header;
    [self configHeaderRefresh];
}

-(void)configHeaderRefresh
{
    TRRefreshGifHeader *header = (TRRefreshGifHeader*)self.mj_header;
    
    static NSArray *refreshImages1;
    static NSArray *refreshImages2;
    static NSArray *refreshImages3;
    static NSArray *refreshImages4;
    
    if (!refreshImages1)
    {
        refreshImages1 = [self createImagesWithName:@"img_top_refresh_gy" AndCount:6];
    }
    if (!refreshImages2)
    {
        refreshImages2 = [self createImagesWithName:@"img_top_refresh_swz" AndCount:8];
    }
    if (!refreshImages3)
    {
        refreshImages3 = [self createImagesWithName:@"img_top_refresh_swzd" AndCount:14];
    }
    if (!refreshImages4)
    {
        refreshImages4 = [self createImagesWithName:@"img_top_refresh_sx" AndCount:11];
    }
    
    NSArray<NSArray*>* refreshImages = @[refreshImages1,refreshImages2,refreshImages3,refreshImages4];
    
    NSInteger index = arc4random()%4;
    header.titleLb.text = @[@"来嘛..",@"浪哩个浪~",@"嘿嘿嘿嘿嘿~",@"刷一刷，再扭一扭"][index];
    [header setImages:refreshImages[index] forState:MJRefreshStateIdle];
    [header setImages:refreshImages[index] forState:MJRefreshStatePulling];
    [header setImages:refreshImages[index] forState:MJRefreshStateRefreshing];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
}

-(void)endHeaderRefresh
{
    [self.mj_header endRefreshing];
}
-(void)beginHeaderRefresh
{
    [self.mj_header beginRefreshing];
}
-(void)addFooterRefresh:(void(^)())block
{
    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:block];
}
-(void)endFootRefresh
{
    [self.mj_footer endRefreshing];
}
-(void)endFooterRefreshWithNoMoreData
{
    [self.mj_footer endRefreshingWithNoMoreData];
}

@end
