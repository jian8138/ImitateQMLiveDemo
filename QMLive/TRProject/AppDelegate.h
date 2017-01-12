//
//  AppDelegate.h
//  TRProject
//
//  Created by yingxin on 16/7/10.
//  Copyright © 2016年 yingxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
//表示当前可以旋转 bool值默认为NO
@property (nonatomic) BOOL isRotating;
//获取当前应用程序单例


@end

