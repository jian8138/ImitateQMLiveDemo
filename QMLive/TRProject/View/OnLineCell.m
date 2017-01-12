//
//  OnLineCell.m
//  TRProject
//
//  Created by Jian on 2016/11/18.
//  Copyright © 2016年 Tedu. All rights reserved.
//

#import "OnLineCell.h"

@implementation OnLineCell

-(UIImageView *)thumbIV
{
    if (!_thumbIV)
    {
        _thumbIV = [[UIImageView alloc]init];
        _thumbIV.layer.cornerRadius = 3;
        _thumbIV.layer.masksToBounds = YES;
        [self.contentView addSubview:_thumbIV];
        [_thumbIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(0);
        }];
    }
    return _thumbIV;
}

-(UILabel *)viewLB
{
    if (!_viewLB)
    {
        _viewLB = [[UILabel alloc]init];
        _viewLB.textColor = [UIColor whiteColor];
        _viewLB.backgroundColor = [UIColor colorWithRGB:0 alpha:0.5];
        _viewLB.font = [UIFont systemFontOfSize:9];
        _viewLB.textAlignment = NSTextAlignmentCenter;
        _viewLB.layer.cornerRadius = 2;
        _viewLB.clipsToBounds = YES;
        [self.thumbIV addSubview:_viewLB];
        [_viewLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(CGSizeMake(45, 12));
            make.left.equalTo(5);
            make.bottom.equalTo(-5);
        }];
    }
    return _viewLB;
}


-(UIImageView *)avatarIV
{
    if (!_avatarIV)
    {
        _avatarIV = [[UIImageView alloc]init];
        _avatarIV.layer.cornerRadius = 15;
        _avatarIV.layer.masksToBounds = YES;
        [self.contentView addSubview:_avatarIV];
        [_avatarIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.thumbIV.mas_bottom).offset(5);
            make.bottom.left.equalTo(0);
            make.width.height.equalTo(30);
        }];
    }
    return _avatarIV;
}

-(UILabel *)nickLB
{
    if (!_nickLB)
    {
        _nickLB = [[UILabel alloc]init];
        _nickLB.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_nickLB];
        [_nickLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.avatarIV.mas_right).offset(5);
            make.top.equalTo(self.avatarIV).offset(2);
            make.right.equalTo(0);
        }];
    }
    return _nickLB;
}

-(UILabel *)titleLB
{
    if (!_titleLB)
    {
        _titleLB = [[UILabel alloc]init];
        _titleLB.textColor = [UIColor grayColor];
        _titleLB.font = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:_titleLB];
        [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.avatarIV.mas_right).offset(5);
            make.bottom.equalTo(self.avatarIV);
            make.right.equalTo(0);
        }];
    }
    return _titleLB;
}


@end
