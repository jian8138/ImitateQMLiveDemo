//
//  RecommendModel.m
//  TRProject
//
//  Created by Jian on 2016/11/28.
//  Copyright © 2016年 Tedu. All rights reserved.
//

#import "RecommendModel.h"

@implementation RecommendModel

+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{@"room":[RecoRoomModel class]};
}

@end

@implementation RecoRoomModel
+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{@"ID":@"id"};
}
+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{@"list":[RecoRoomListModel class]};
}

@end


@implementation RecoRoomListModel

@end


