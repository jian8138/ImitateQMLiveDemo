//
//  RecommendADModel.m
//  TRProject
//
//  Created by Jian on 2016/11/29.
//  Copyright © 2016年 Tedu. All rights reserved.
//

#import "RecommendADModel.h"

@implementation RecommendADModel
+(NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{@"app_focus":@"app-focus"};
}
+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{@"app_focus":[AppFocusModel class]};
}

@end

@implementation AppFocusModel

@end
