//
//  UIScrollView+Refresh.h
//  TRProject
//
//  Created by Jian on 2016/11/21.
//  Copyright © 2016年 Tedu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (Refresh)

-(void)addHeaderRefresh:(void(^)())block;
-(void)endHeaderRefresh;
-(void)beginHeaderRefresh;

-(void)configHeaderRefresh;

-(void)addFooterRefresh:(void(^)())block;
-(void)endFootRefresh;
-(void)endFooterRefreshWithNoMoreData;

@end
