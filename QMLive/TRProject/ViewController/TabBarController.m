//
//  TabBarController.m
//  TRProject
//
//  Created by Jian on 2016/11/18.
//  Copyright © 2016年 Tedu. All rights reserved.
//

#import "TabBarController.h"
#import "FirstPC.h"
#import "RecommendCVC.h"
#import "CategoryCVC.h"
#import "OnLineCVC.h"
#import "MineVC.h"
#import "NavigationController.h"
#import <MLTransition.h>

@interface TabBarController ()
@property (nonatomic) FirstPC* firstPC;
@property (nonatomic) RecommendCVC* recommendCVC;
@property (nonatomic) CategoryCVC* categoryCVC;
@property (nonatomic) OnLineCVC* onLineCVC;
@property (nonatomic) MineVC* mineVC;
@end

@implementation TabBarController

//规定当前控制器是否可以自动横竖屏
-(BOOL)shouldAutorotate
{
    return YES;
}

//重写下方方法，可以规定当前控制器支持那种屏幕方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    //return UIInterfaceOrientationMaskPortrait;
    //横竖屏 由 tabbar控制器当前选中的子控制器来控制
    return self.selectedViewController.supportedInterfaceOrientations;
}

#pragma mark - Lazy

-(FirstPC *)firstPC
{
    if (!_firstPC)
    {
        _firstPC = [[FirstPC alloc]init];
        _firstPC.tabBarItem.title = @"首页";
        //图片默认接收tintColor渲染
        //我们去assets中 设置图片的渲染属性 render as 为 original
        _firstPC.showOnNavigationBar = NO;
        _firstPC.menuViewStyle = WMMenuViewStyleFlood;
//        _firstPC.menuViewLayoutMode = WMMenuViewLayoutModeLeft;
        _firstPC.titleSizeNormal = 15;
        _firstPC.titleSizeSelected = 15;
        _firstPC.progressWidth = 60;
//        _firstPC.automaticallyCalculatesItemWidths = YES;
        _firstPC.titleColorNormal = [UIColor lightGrayColor];
        _firstPC.titleColorSelected = [UIColor redColor];
        _firstPC.progressColor = [UIColor colorWithRGB:0 alpha:0.1];
        _firstPC.menuBGColor = [UIColor whiteColor];
        
        _firstPC.tabBarItem.image = [UIImage imageNamed:@"btn_tabbar_home_normal_25x25_"];
        _firstPC.tabBarItem.selectedImage = [UIImage imageNamed:@"btn_tabbar_home_selected_25x25_"];
    }
    return _firstPC;
}
-(CategoryCVC *)categoryCVC
{
    if (!_categoryCVC)
    {
        _categoryCVC = [[CategoryCVC alloc]init];
        _categoryCVC.title = @"栏目";
        _categoryCVC.tabBarItem.image = [UIImage imageNamed:@"btn_tabbar_lanmu_normal_25x25_"];
        _categoryCVC.tabBarItem.selectedImage = [UIImage imageNamed:@"btn_tabbar_lanmu_selected_25x25_"];
    }
    return _categoryCVC;
}
-(OnLineCVC *)onLineCVC
{
    if (!_onLineCVC)
    {
        _onLineCVC = [[OnLineCVC alloc]init];
        _onLineCVC.title = @"直播";
        _onLineCVC.tabBarItem.image = [UIImage imageNamed:@"btn_tabbar_zhibo_normal_25x25_"];
        _onLineCVC.tabBarItem.selectedImage = [UIImage imageNamed:@"btn_tabbar_zhibo_selected_25x25_"];
    }
    return _onLineCVC;
}
-(MineVC *)mineVC
{
    if (!_mineVC)
    {
        _mineVC = [[MineVC alloc]init];
        _mineVC.title = @"我的";
        _mineVC.tabBarItem.image = [UIImage imageNamed:@"btn_tabbar_wode_normal_25x25_"];
        _mineVC.tabBarItem.selectedImage = [UIImage imageNamed:@"btn_tabbar_wode_selected_25x25_"];
    }
    return _mineVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [MLTransition validatePanBackWithMLTransitionGestureRecognizerType:MLTransitionGestureRecognizerTypeScreenEdgePan];
    //修改所有TabBarItem的选中状态时的默认文字颜色
    [[UITabBarItem appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:254/255.0 green:159/255.0 blue:163/255.0 alpha:1.0]} forState:UIControlStateNormal];
    [[UITabBarItem appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:251/255.0 green:57/255.0 blue:67/255.0 alpha:1.0]} forState:UIControlStateSelected];
    [UIImageView appearance].contentMode = UIViewContentModeScaleAspectFill;
    [UIImageView appearance].clipsToBounds = YES;
    
    //上下两个bar 都是不透明的
    [UITabBar appearance].translucent = NO;
    [UINavigationBar appearance].translucent = NO;
    
    NavigationController *navi0 = [[NavigationController alloc]initWithRootViewController:self.firstPC];
    NavigationController *navi1 = [[NavigationController alloc]initWithRootViewController:self.categoryCVC];
    NavigationController *navi2 = [[NavigationController alloc]initWithRootViewController:self.onLineCVC];
    NavigationController *navi3 = [[NavigationController alloc]initWithRootViewController:self.mineVC];
    self.viewControllers = @[navi0,navi1,navi2,navi3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
