//
//  SearchModel.m
//  TRProject
//
//  Created by Jian on 2016/12/2.
//  Copyright © 2016年 Tedu. All rights reserved.
//

#import "SearchModel.h"

@implementation SearchModel

@end
@implementation SearchDataModel

+(NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{@"items":[DataItemsModel class]};
}

@end

@implementation DataItemsModel

@end


