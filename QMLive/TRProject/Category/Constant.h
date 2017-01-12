//
//  Constant.h
//  TRProject
//
//  Created by Jian on 2016/11/18.
//  Copyright © 2016年 Tedu. All rights reserved.
//

#ifndef Constant_h
#define Constant_h

#define kBasePath @"http://www.quanmin.tv"
//判断当前网路状态,这个宏应该写在全局文件,Constants.h中
#define kIsOnline ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == 1 || [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == 2 )
//获取系统App单例的delegate
#define kAppDelegate ((AppDelegate*)[UIApplication sharedApplication].delegate)
//屏幕宽高
#define kScreenW ([UIScreen mainScreen].bounds.size.width)
#define kScreenH ([UIScreen mainScreen].bounds.size.height)
//设置RGBA颜色
#define kRGBA(r, g, b, A) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:A];

#define kAppkey @"1120161129178007#dadaonlinetv"

#endif /* Constant_h */
