//
//  MineVC.m
//  TRProject
//
//  Created by Jian on 2016/11/18.
//  Copyright © 2016年 Tedu. All rights reserved.
//

#import "MineVC.h"
#import "MineTVC.h"
#import "LoginVC.h"

@interface MineVC ()
@property (nonatomic) UIImageView* headerView;
@end

@implementation MineVC

#pragma mark - Lazy
-(UIImageView *)headerView
{
    if (!_headerView)
    {
        _headerView = [[UIImageView alloc]init];
        _headerView.userInteractionEnabled = YES;
        _headerView.image = [UIImage imageNamed:@"min_header_BG_image_20x20_"];
        [self.view addSubview:_headerView];
        [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(0);
            make.height.equalTo(200);
        }];
        
        UIView *bigCircle = [[UIView alloc]init];
        bigCircle.backgroundColor = [UIColor colorWithRed:250/255.0 green:65/255.0 blue:74/255.0 alpha:1];
        bigCircle.layer.cornerRadius = 160/2.0;
        bigCircle.clipsToBounds = YES;
        [_headerView addSubview:bigCircle];
        [bigCircle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(0);
            make.size.equalTo(160);
        }];
        
        UIView *middleCircle = [[UIView alloc]init];
        middleCircle.backgroundColor = [UIColor colorWithRed:248/255.0 green:70/255.0 blue:80/255.0 alpha:1];
        middleCircle.layer.cornerRadius = 120/2.0;
        middleCircle.clipsToBounds = YES;
        [_headerView addSubview:middleCircle];
        [middleCircle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(0);
            make.size.equalTo(120);
        }];
        
        UIView *minCircle = [[UIView alloc]init];
        minCircle.backgroundColor = [UIColor colorWithRed:251/255.0 green:82/255.0 blue:88/255.0 alpha:1];
        minCircle.layer.cornerRadius = 75/2.0;
        minCircle.clipsToBounds = YES;
        [_headerView addSubview:minCircle];
        [minCircle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(0);
            make.size.equalTo(75);
        }];
        
        UIImageView *centerPic = [[UIImageView alloc]init];
        centerPic.image = [UIImage imageNamed:@"default_avatar_75x75_"];
        centerPic.layer.cornerRadius = 75/2.0;
        centerPic.clipsToBounds = YES;
        [_headerView addSubview:centerPic];
        [centerPic mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(0);
            make.size.equalTo(75);
        }];
        centerPic.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
            UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:[[LoginVC alloc]init]];
            [self presentViewController:navi animated:YES completion:nil];
        }];
        [centerPic addGestureRecognizer:tap];
        
        UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        loginBtn.backgroundColor = [UIColor clearColor];
        [loginBtn setTitle:@"点我登录" forState:UIControlStateNormal];
        [loginBtn setTitleColor:[UIColor colorWithRed:250/255.0 green:145/255.0 blue:148/255.0 alpha:1] forState:UIControlStateNormal];
        [_headerView addSubview:loginBtn];
        [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.top.equalTo(centerPic.mas_bottom);
        }];
        [loginBtn bk_addEventHandler:^(id sender) {
            UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:[[LoginVC alloc]init]];
            [self presentViewController:navi animated:YES completion:nil];
        } forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *settingBtn = [[UIButton alloc]init];
        [settingBtn setImage:[UIImage imageNamed:@"mine_setting_icon_25x25_"] forState:UIControlStateNormal];
        [_headerView addSubview:settingBtn];
        [settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(25);
            make.top.equalTo(25);
            make.right.equalTo(-20);
        }];
        [settingBtn bk_addEventHandler:^(id sender) {
            NSLog(@"setting click");
        } forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *messageBtn = [[UIButton alloc]init];
        [messageBtn setImage:[UIImage imageNamed:@"mine_message_icon_25x25_"] forState:UIControlStateNormal];
        [_headerView addSubview:messageBtn];
        [messageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(25);
            make.top.equalTo(25);
            make.left.equalTo(20);
        }];
        [messageBtn bk_addEventHandler:^(id sender) {
            NSLog(@"message click");
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _headerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = YES;
    [self headerView];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MineTVC *mTVC = [sb instantiateViewControllerWithIdentifier:@"MineTVC"];
    [self addChildViewController:mTVC];
    [self.view addSubview:mTVC.tableView];
    [mTVC.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(0);
        make.top.equalTo(_headerView.mas_bottom);
    }];
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
