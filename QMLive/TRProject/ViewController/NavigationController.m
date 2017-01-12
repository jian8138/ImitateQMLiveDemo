//
//  NavigationController.m
//  TRProject
//
//  Created by Jian on 2016/11/25.
//  Copyright © 2016年 Tedu. All rights reserved.
//

#import "NavigationController.h"
#import "RoomVC.h"

@interface NavigationController ()

@end

@implementation NavigationController

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    //导航控制器 当前是否横屏 由导航控制器当前 栈顶/ 显示给用户的那个控制器来负责
    if ([self.topViewController isKindOfClass:[RoomVC class]])
    {
        //如果当前呈现给用户的控制器是某某控制器(即房间详情控制器)，则支持的方向是 除了home键在上方的其他所有方向
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }
    return UIInterfaceOrientationMaskPortrait;//竖向
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
