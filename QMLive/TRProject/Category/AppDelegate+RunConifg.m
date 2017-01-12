//
//  AppDelegate+RunConifg.m
//  TRProject
//
//  Created by Jian on 2016/12/2.
//  Copyright © 2016年 Tedu. All rights reserved.
//

#import "AppDelegate+RunConifg.h"
#import "EMSDKFull.h"
#import <SMS_SDK/SMSSDK.h>

@implementation AppDelegate (RunConifg)

-(void)configSystem
{
    
    EMOptions *options = [EMOptions optionsWithAppkey:kAppkey];
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    
    [SMSSDK registerApp:@"1977e4fd50875"
             withSecret:@"9cd39338ffbe800049047422cca97d0d"];
    
    //    固定的检测网络状态的代码
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        /*因为网络状态监测是由延时的，所以启动后的页面会认为没有网，所以我们可以考虑刚启动时设置一个控制器，控制器里面放一个启动图。当进入此方法，即表示网络状态确定以后，再切换window的根视图控制器 为正常即可.
         注意！这个方法当网络发生变化时 都会触发。所以需要一个BOOL属性来保存是否是首次进入这个方法
         if (首次 == YES)
         {
         切换控制器
         首次 = NO
         }
         */
        NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

+(AppDelegate *)sharedAppDelegate
{
    return (AppDelegate*)[UIApplication sharedApplication].delegate;
}

@end
