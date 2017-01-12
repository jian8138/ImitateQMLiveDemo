//
//  TRNoNetView.h
//  TRProject
//
//  Created by Jian on 2016/11/22.
//  Copyright © 2016年 Tedu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TRNoNetView : UIView

-(instancetype)initWithRefreshBlock:(void(^)())block;
@property (nonatomic) void(^RefreshBlock)();

@end
