//
//  UIView+HUD.h
//  TRProject
//
//  Created by tarena on 2016/11/14.
//  Copyright © 2016年 Tedu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HUD)
- (void)showHUD;

- (void)hideHUD;
- (void)showMsg:(NSString *)msg;

-(void)showLoadPic;
-(void)showNetErrorPic:(void(^)())block;
@end
