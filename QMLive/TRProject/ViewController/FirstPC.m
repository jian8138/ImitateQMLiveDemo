//
//  FirstPC.m
//  TRProject
//
//  Created by Jian on 2016/11/30.
//  Copyright © 2016年 Tedu. All rights reserved.
//

#import "FirstPC.h"
#import "RecommendCVC.h"
#import "OnLineCVC.h"

@interface FirstPC ()

@end

@implementation FirstPC

#pragma mark - Life

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"img_nav_logo_77x20_"] style:UIBarButtonItemStyleDone target:self action:nil];
    self.navigationItem.leftBarButtonItem.enabled = NO;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"btn_nav_open_ani_sc_normal" ofType:@"gif"];
    NSData *gifData = [NSData dataWithContentsOfFile:path];
    UIImage *gifImage = [UIImage imageWithSmallGIFData:gifData scale:3];
    UIButton *btn_1 = [UIButton buttonWithType:0];
    [btn_1 setImage:gifImage forState:UIControlStateNormal];
    btn_1.frame = CGRectMake(0, 0, 25, 25);
    UIBarButtonItem *btn1 = [[UIBarButtonItem alloc]initWithCustomView:btn_1];
    UIButton *btn_2 = [UIButton buttonWithType:0];
    btn_2.frame = CGRectMake(0, 0, 25, 25);
    [btn_2 setImage:[UIImage imageNamed:@"btn_nav_gz_normal_25x25_"] forState:UIControlStateNormal];
    [btn_2 setImage:[UIImage imageNamed:@"btn_nav_gz_selected_25x25_"] forState:UIControlStateHighlighted];
    UIBarButtonItem *btn2 = [[UIBarButtonItem alloc]initWithCustomView:btn_2];
    UIButton *btn_3 = [UIButton buttonWithType:0];
    btn_3.frame = CGRectMake(0, 0, 25, 25);
    [btn_3 setImage:[UIImage imageNamed:@"btn_nav_search_normal_25x25_"] forState:UIControlStateNormal];
    [btn_3 setImage:[UIImage imageNamed:@"btn_nav_search_selected_25x25_"] forState:UIControlStateHighlighted];
    [btn_3 bk_addEventHandler:^(id sender) {
        [self.navigationController pushViewController:[[SearchCVC alloc]init] animated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *btn3 = [[UIBarButtonItem alloc]initWithCustomView:btn_3];
    UIBarButtonItem *fix = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fix.width = 15;
    self.navigationItem.rightBarButtonItems = @[btn3, fix, btn2, fix, btn1];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - WMPageControllerDelegate

-(NSArray<NSString *> *)titles
{
    return  @[@"推荐",@"全部"];
}

-(NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController
{
    return self.titles.count;
}

-(NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index
{
    return self.titles[index];
}

-(UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index
{
    switch (index)
    {
        case 0:
            return [[RecommendCVC alloc] init];
        default:
            return [[OnLineCVC alloc] init];
    }
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
