//
//  CategoryModel.h
//  TRProject
//
//  Created by Jian on 2016/11/21.
//  Copyright © 2016年 Tedu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryModel : NSObject

@property (nonatomic) NSString* first_letter;
@property (nonatomic) NSString* ID;//ID = id
@property (nonatomic) NSString* image;
@property (nonatomic) NSString* name;
@property (nonatomic) NSInteger priority;
@property (nonatomic) NSInteger prompt;
@property (nonatomic) NSInteger screen;
@property (nonatomic) NSString* slug;
@property (nonatomic) NSInteger status;
@property (nonatomic) NSString* thumb;

@end
