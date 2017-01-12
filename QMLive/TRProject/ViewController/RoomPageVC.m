//
//  RoomPageVC.m
//  TRProject
//
//  Created by Jian on 2016/11/24.
//  Copyright © 2016年 Tedu. All rights reserved.
//

#import "RoomPageVC.h"
#import "LiaoTianVC.h"
#import "PaiHangTVC.h"

@interface RoomPageVC ()

@property (nonatomic) RoomModel* model;

@end

@implementation RoomPageVC

#pragma mark - Life
-(instancetype)initWithModel:(RoomModel *)model
{
    self = [super init];
    if (self)
    {
        self.model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - WMPageControllerDelegate

-(NSArray<NSString *> *)titles
{
    return @[@"聊天",@"排行"];//@[@"聊天",@"排行",@"守护"];
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
            return [[LiaoTianVC alloc] init];
            break;
        case 1:
            return [[PaiHangTVC alloc] initWithModel:self.model];
        default:
            return [[UIViewController alloc] init];
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
