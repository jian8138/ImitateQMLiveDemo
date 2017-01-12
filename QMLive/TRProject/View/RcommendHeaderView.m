//
//  RcommendHeaderView.m
//  TRProject
//
//  Created by Jian on 2016/11/28.
//  Copyright © 2016年 Tedu. All rights reserved.
//

#import "RcommendHeaderView.h"

@implementation RcommendHeaderView

- (UILabel *)nameLB {
    if(_nameLB == nil) {
        self.backgroundColor = [UIColor whiteColor];
        _nameLB = [[UILabel alloc] init];
        [self addSubview:_nameLB];
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = [UIColor redColor];
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(20);
            make.width.equalTo(2);
            make.centerY.equalTo(0);
        }];
        
        [_nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lineView.mas_right).offset(10);
            make.centerY.equalTo(0);
        }];
    }
    return _nameLB;
}

- (UIButton *)contentBtn {
    if(_contentBtn == nil) {
        _contentBtn = [[UIButton alloc] init];
        [_contentBtn setImage:[UIImage imageNamed:@"btn_home_content_rignt_cc_normal_20x20_"] forState:UIControlStateNormal];
        [_contentBtn setImage:[UIImage imageNamed:@"btn_home_content_rignt_cc_selected_20x20_"] forState:UIControlStateHighlighted];
        [_contentBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_contentBtn];
        [_contentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(-10);
            make.size.equalTo(20);
            make.centerY.equalTo(0);
        }];
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor lightGrayColor];
        label.font = [UIFont systemFontOfSize:14];
        label.text = @"瞅瞅";
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_contentBtn.mas_left).offset(-10);
            make.centerY.equalTo(0);
        }];
    }
    return _contentBtn;
}

-(void)clickBtn:(UIButton*)sender
{
    !_ClickBlock ?: _ClickBlock(self);
}



@end
