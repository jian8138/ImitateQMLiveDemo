//
//  AppDelegate.m
//  TRProject
//
//  Created by yingxin on 16/7/10.
//  Copyright © 2016年 yingxin. All rights reserved.
//

#import "AppDelegate.h"
#import "TabBarController.h"
#import "RoomVC.h"

#import "WelcomeVC.h"
#import "AppDelegate+RunConifg.h"

@interface AppDelegate ()
@property (nonatomic) UIWindow* welcomeWindow;
@end

@implementation AppDelegate

//当前应用程序支持的window朝向
-(UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    if (_isRotating)
    {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //设置各种启动配置
    [self configSystem];
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[TabBarController alloc]init];
    [self.window makeKeyAndVisible];
    
     NSLog(@"NSHomeDirectory %@",NSHomeDirectory());
    
    NSDictionary *infoDic = [NSBundle mainBundle].infoDictionary;
    NSString *version = infoDic[@"CFBundleShortVersionString"];
    if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"kRunVersion"] isEqualToString:version])
    {
        _welcomeWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _welcomeWindow.backgroundColor = [UIColor whiteColor];
        _welcomeWindow.rootViewController = [[WelcomeVC alloc] init];
        _welcomeWindow.hidden = NO;
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
