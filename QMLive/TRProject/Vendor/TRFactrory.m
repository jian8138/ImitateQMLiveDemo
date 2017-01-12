//
//  TRFactrory.m
//  TRProject
//
//  Created by Jian on 2016/12/2.
//  Copyright © 2016年 Tedu. All rights reserved.
//

#import "TRFactrory.h"

@implementation TRFactrory

+(void)addBackItemToVC:(UIViewController *)vc
{
    //如果barButtonItem上方有两个图，高亮+普通，那就只能自定义一个按钮，把按钮放到barButtonItem上
    //不加weak可能会导致内存泄漏
    __weak UIViewController *weakVC = vc;
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc]bk_initWithImage:[UIImage imageNamed:@"btn_nav_hp_player_back_normal_30x30_"] style:UIBarButtonItemStylePlain handler:^(id sender) {
        [weakVC.navigationController popViewControllerAnimated:YES];
    }];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -15;
    
    vc.navigationItem.leftBarButtonItems = @[spaceItem,barItem];
}
//搜索按钮，点击后执行的方法 由参数决定
+(void)addSearchItemToVC:(UIViewController*)vc WithAction:(void(^)())actionBlock
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"btn_nav_search_normal_25x25_"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"btn_nav_search_selected_25x25_"] forState:UIControlStateHighlighted];
    btn.frame = CGRectMake(0, 0, 25, 25);
    
    [btn bk_addEventHandler:^(id sender) {
        !actionBlock ?: actionBlock();
    } forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    vc.navigationItem.rightBarButtonItem = barItem;
}






@end
