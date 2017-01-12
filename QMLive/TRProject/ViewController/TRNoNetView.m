//
//  TRNoNetView.m
//  TRProject
//
//  Created by Jian on 2016/11/22.
//  Copyright © 2016年 Tedu. All rights reserved.
//

#import "TRNoNetView.h"

@implementation TRNoNetView

-(instancetype)initWithRefreshBlock:(void (^)())block
{
    if (self = [super init])
    {
        self.RefreshBlock = block;
        
        UIView *hudView = [[UIView alloc]init];
        [self addSubview:hudView];
        [hudView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(0);
        }];
        
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:@"disconnect_internet_190x190_"];
        [hudView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(0);
            make.size.equalTo(100);
        }];
        
        UILabel *label = [[UILabel alloc]init];
        label.textColor = [UIColor grayColor];
        label.text = @"咦？似乎没有检测到网络哦";
        label.font = [UIFont systemFontOfSize:13];
        [hudView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.top.equalTo(imageView.mas_bottom);
        }];
        
        UIButton *button = [[UIButton alloc]init];
        button.backgroundColor = [UIColor blueColor];
        button.layer.cornerRadius = 10;
        button.clipsToBounds = YES;
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button setTitle:@"重新加载" forState:UIControlStateNormal];
        [button bk_addEventHandler:^(id sender) {
            !block ?: block();
        } forControlEvents:UIControlEventTouchUpInside];
        [hudView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.width.equalTo(label);
            make.top.equalTo(label.mas_bottom).offset(30);
            make.bottom.equalTo(0);
        }];

//        UIButton *refreshBtn = [UIButton buttonWithType:UIButtonTypeSystem];
//        refreshBtn.backgroundColor = [UIColor blueColor];
//        [self addSubview:refreshBtn];
//        [refreshBtn bk_addEventHandler:^(id sender) {
//            //按钮点击时，调用传入的block方法，通知调用方
//            !self.RefreshBlock ?: self.RefreshBlock();
//        } forControlEvents:UIControlEventTouchUpInside];
//        [refreshBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(0);
//            make.centerY.equalTo(30);
//            make.size.equalTo(100);
//        }];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
