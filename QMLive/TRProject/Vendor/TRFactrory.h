//
//  TRFactrory.h
//  TRProject
//
//  Created by Jian on 2016/12/2.
//  Copyright © 2016年 Tedu. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 工厂类用于存储多个类工厂方法，每个方法相当于一条流水线。拥有自己独特的功能
 */

@interface TRFactrory : NSObject

+(void)addBackItemToVC:(UIViewController *)vc;

+(void)addSearchItemToVC:(UIViewController*)vc WithAction:(void(^)())actionBlock;

@end
