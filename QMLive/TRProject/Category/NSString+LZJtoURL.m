//
//  NSString+LZJtoURL.m
//  TRProject
//
//  Created by Jian on 2016/11/14.
//  Copyright © 2016年 Tedu. All rights reserved.
//

#import "NSString+LZJtoURL.h"

@implementation NSString (LZJtoURL)

-(NSURL*)lzj_toURL
{
    return [NSURL URLWithString:self];
}

@end
