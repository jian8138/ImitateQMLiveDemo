//
//  TRRefreshGifHeader.m
//  TRProject
//
//  Created by Jian on 2016/11/22.
//  Copyright © 2016年 Tedu. All rights reserved.
//

#import "TRRefreshGifHeader.h"

@implementation TRRefreshGifHeader

-(UILabel *)titleLb
{
    if (!_titleLb)
    {
        _titleLb = [[UILabel alloc]init];
        [self addSubview:_titleLb];
        _titleLb.font = [UIFont systemFontOfSize:13];
        _titleLb.textColor = [UIColor lightGrayColor];
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.bottom.equalTo(0);
        }];
    }
    return _titleLb;
}

//MJ用于布局的方法
-(void)placeSubviews
{
    [super placeSubviews];
    if (self.stateLabel.hidden && self.lastUpdatedTimeLabel.hidden)
    {
        self.gifView.contentMode = UIViewContentModeTop;
        [self titleLb];
        self.mj_h = 80;//头部视图的高度
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
