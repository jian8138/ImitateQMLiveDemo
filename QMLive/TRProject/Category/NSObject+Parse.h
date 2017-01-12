//
//  NSObject+Parse.h
//  TRProject
//
//  Created by tarena on 2016/11/14.
//  Copyright © 2016年 Tedu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Parse)<YYModel>

+ (id)parse:(id)JSON;

@end
