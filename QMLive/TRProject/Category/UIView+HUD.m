//
//  UIView+HUD.m
//  TRProject
//
//  Created by tarena on 2016/11/14.
//  Copyright © 2016年 Tedu. All rights reserved.
//

#import "UIView+HUD.h"

@implementation UIView (HUD)
- (void)showHUD{
    [self hideHUD];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    [hud hideAnimated:YES afterDelay:30];
}

- (void)hideHUD{
    [MBProgressHUD hideAllHUDsForView:self animated:YES];
    
    UIView *hudView1 = [self viewWithTag:19090];
    [hudView1 removeFromSuperview];
//    UIView *hudView2 = [self viewWithTag:19091];
//    [hudView2 removeFromSuperview];
}
- (void)showMsg:(NSString *)msg{
    [self hideHUD];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = msg;
    [hud hideAnimated:YES afterDelay:1.5];
}

-(void)showLoadPic
{
    [self hideHUD];
    
    UIView *hudView = [[UIView alloc]init];
    [self addSubview:hudView];
    [hudView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(0);
    }];
    hudView.tag = 19090;
    
    //读取gif图片的data
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ani_popover_loading_yz_small" ofType:@"gif"];
    NSData *gifData = [NSData dataWithContentsOfFile:path];
    UIImage *gifImage = [UIImage imageWithSmallGIFData:gifData scale:1];
    UIImageView *iconIV = [[UIImageView alloc] initWithImage:gifImage];
    [hudView addSubview:iconIV ];
    [iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(0);
        make.size.equalTo(100);
    }];
    
    UILabel *label = [[UILabel alloc]init];
    label.textColor = [UIColor grayColor];
    label.text = @"玩命加载中";
    label.font = [UIFont systemFontOfSize:13];
    [hudView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.bottom.equalTo(0);
        make.top.equalTo(iconIV.mas_bottom);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hudView removeFromSuperview];
    });
}

//-(void)showNetErrorPic:(void (^)())block
//{
//    UIView *hudView = [[UIView alloc]init];
//    [self addSubview:hudView];
//    [hudView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(0);
//    }];
//    hudView.tag = 19091;
//    
//    UIImageView *imageView = [[UIImageView alloc]init];
//    imageView.image = [UIImage imageNamed:@"disconnect_internet_190x190_"];
//    [hudView addSubview:imageView];
//    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.right.equalTo(0);
//        make.size.equalTo(100);
//    }];
//    
//    UILabel *label = [[UILabel alloc]init];
//    label.textColor = [UIColor grayColor];
//    label.text = @"咦？似乎没有检测到网络哦";
//    label.font = [UIFont systemFontOfSize:13];
//    [hudView addSubview:label];
//    [label mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(0);
//        make.top.equalTo(imageView.mas_bottom);
//    }];
//    
//    UIButton *button = [[UIButton alloc]init];
//    button.backgroundColor = [UIColor blueColor];
//    button.layer.cornerRadius = 10;
//    button.clipsToBounds = YES;
//    button.titleLabel.font = [UIFont systemFontOfSize:13];
//    button.titleLabel.textColor = [UIColor whiteColor];
//    [button setTitle:@"重新加载" forState:UIControlStateNormal];
//    [button bk_addEventHandler:^(id sender) {
//        !block ?: block();
//    } forControlEvents:UIControlEventTouchUpInside];
//    [hudView addSubview:button];
//    [button mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(0);
//        make.width.equalTo(label);
//        make.top.equalTo(label.mas_bottom).offset(30);
//        make.bottom.equalTo(0);
//    }];
//}




@end
