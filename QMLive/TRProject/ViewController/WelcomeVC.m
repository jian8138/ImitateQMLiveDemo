//
//  WelcomeVC.m
//  TRProject
//
//  Created by Jian on 2016/11/30.
//  Copyright © 2016年 Tedu. All rights reserved.
//

#import "WelcomeVC.h"
@import AVFoundation;

@interface WelcomeVC ()
@property (nonatomic) AVPlayer* player;
@property (nonatomic) AVPlayerLayer* playerLayer;
@end

@implementation WelcomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *mp4URL = [[NSBundle mainBundle] URLForResource:@"dyla_movie" withExtension:@"mp4"];
    self.player = [AVPlayer playerWithURL:mp4URL];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    [_player play];
    [self.view.layer addSublayer:_playerLayer];
    _playerLayer.frame = self.view.bounds;
    _playerLayer.videoGravity = @"AVLayerVideoGravityResizeAspectFill";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playToEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"-----------------welcomeVC dealloc-----------------");
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

-(void)playToEnd:(NSNotification*)noti
{
    [UIView animateWithDuration:1 animations:^{
        self.view.transform = CGAffineTransformMakeScale(1.5, 1.5);
    } completion:^(BOOL finished) {
        self.view.window.hidden = YES;
        self.view.window.rootViewController = nil;
    }];
    
    NSDictionary *infoDic = [NSBundle mainBundle].infoDictionary;
    NSString *version = infoDic[@"CFBundleShortVersionString"];
    [[NSUserDefaults standardUserDefaults] setObject:version forKey:@"kRunVersion"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
