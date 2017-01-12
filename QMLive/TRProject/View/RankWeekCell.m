//
//  RankWeekCell.m
//  TRProject
//
//  Created by Jian on 2016/11/26.
//  Copyright © 2016年 Tedu. All rights reserved.
//

#import "RankWeekCell.h"

@implementation RankWeekCell

-(UIView *)bgView
{
    if (!_bgView)
    {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_bgView];
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.right.equalTo(-10);
            make.top.equalTo(5);
            make.bottom.equalTo(-5);
        }];
    }
    return _bgView;
}

-(UIImageView *)rankNumIV
{
    if (!_rankNumIV)
    {
        _rankNumIV = [[UIImageView alloc] init];
        [self.bgView addSubview:_rankNumIV];
        [_rankNumIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(10);
            make.size.equalTo(25);
            make.centerY.equalTo(0);
        }];
    }
    return _rankNumIV;
}

-(UIImageView *)iconIV
{
    if (!_iconIV)
    {
        _iconIV = [[UIImageView alloc] init];
        _iconIV.contentMode = UIViewContentModeScaleAspectFit;
        [self.bgView addSubview:_iconIV];
        [_iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.rankNumIV.mas_right).offset(10);
            make.centerY.equalTo(0);
            make.size.equalTo(CGSizeMake(170/2.0, 25));
        }];
    }
    return _iconIV;
}

-(UILabel *)sendNickLB
{
    if(!_sendNickLB)
    {
        _sendNickLB = [[UILabel alloc] init];
        _sendNickLB.font = [UIFont systemFontOfSize:13];
        [self.bgView addSubview:_sendNickLB];
        [_sendNickLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconIV.mas_right).offset(10);
            make.centerY.equalTo(0);
        }];
    }
    return _sendNickLB;
}

-(UIImageView *)likeIV
{
    if (!_likeIV)
    {
        _likeIV = [[UIImageView alloc] init];
        [self.bgView addSubview:_likeIV];
        [_likeIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-10);
            make.centerY.equalTo(0);
            make.size.equalTo(20);
        }];
    }
    return _likeIV;
}

-(UILabel *)scoreLB
{
    if (!_scoreLB)
    {
        _scoreLB = [[UILabel alloc] init];
        _scoreLB.font = [UIFont systemFontOfSize:14];
        _scoreLB.textColor = [UIColor lightGrayColor];
        [self.bgView addSubview:_scoreLB];
        [_scoreLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.likeIV.mas_left).offset(-8);
            make.centerY.equalTo(0);
        }];
    }
    return _scoreLB;
}







- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
