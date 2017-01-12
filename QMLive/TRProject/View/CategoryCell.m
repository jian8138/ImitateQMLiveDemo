//
//  CategoryCell.m
//  TRProject
//
//  Created by Jian on 2016/11/21.
//  Copyright © 2016年 Tedu. All rights reserved.
//

#import "CategoryCell.h"

@implementation CategoryCell

-(UIImageView *)imageIV
{
    if (!_imageIV)
    {
        _imageIV = [[UIImageView alloc]init];
        [self.contentView addSubview:_imageIV];
        [_imageIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
    }
    return _imageIV;
}

-(UILabel *)nameLB
{
    if (!_nameLB)
    {
        _nameLB = [[UILabel alloc]init];
        _nameLB.textColor = [UIColor lightGrayColor];
        _nameLB.font = [UIFont systemFontOfSize:13];
        _nameLB.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_nameLB];
        [_nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(0);
            make.bottom.equalTo(-5);
        }];
    }
    return _nameLB;
}



@end
