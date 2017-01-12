//
//  RoomModel.m
//  TRProject
//
//  Created by Jian on 2016/11/24.
//  Copyright © 2016年 Tedu. All rights reserved.
//

#import "RoomModel.h"

@implementation RoomModel

+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{@"rank_curr":[rankCurrModel class],@"rank_week":[rankWeekModel class]};
}

@end

@implementation LiveModel

@end

@implementation WsModel

@end

@implementation HlsModel

+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{@"zero":@"0",@"one":@"1",@"two":@"2",@"three":@"3",@"four":@"4",@"five":@"5",@"six":@"6"};
}

@end

@implementation liveURLModel

@end

@implementation rankCurrModel

@end

@implementation rankWeekModel

@end
