//
//  OnLineModel.m
//  TRProject
//
//  Created by Jian on 2016/11/18.
//  Copyright © 2016年 Tedu. All rights reserved.
//

#import "OnLineModel.h"

@implementation OnLineModel

+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{@"data":[OnLineDataModel class]};
}

@end

@implementation OnLineDataModel



@end
