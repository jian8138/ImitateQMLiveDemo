//
//  RoomVC.m
//  TRProject
//
//  Created by Jian on 2016/11/24.
//  Copyright © 2016年 Tedu. All rights reserved.
//

#import "RoomVC.h"
#import "RoomPageVC.h"
#import <IJKMediaFramework/IJKMediaFramework.h>

#define kLivePath @"http://hls.quanmin.tv/live/%@/playlist.m3u8"
#define touM .8;

@interface RoomVC ()<UITextFieldDelegate>
@property (nonatomic) NSString* uid;
@property (nonatomic) RoomModel* model;

@property (nonatomic) IJKFFMoviePlayerController* ijkPlayer;

@property (nonatomic) UIView* middleView;
@property (nonatomic) UIImageView* avatarIV;
@property (nonatomic) UILabel* nickLB;
@property (nonatomic) UILabel* titleLB;

@property (nonatomic) UIView* settingView;
@property (nonatomic) BOOL hide;
@property (nonatomic) UILabel* viewLB;

@property (nonatomic) RoomPageVC *pvc;

@property (nonatomic) UIView* orientationView;
@property (nonatomic) UIView* bottomTFView;//横屏时 文本输入框的view

@property (nonatomic) UIView* statusBarView;//顶部任务栏黑色view

@property (nonatomic) NSTimer* setBtnDisappTimer;//控制设置视图自动隐藏的定时器
@end

@implementation RoomVC

#pragma mark - statusBarViewLazy
-(UIView *)statusBarView
{
    if (!_statusBarView)
    {
        //任务栏上的黑view
        _statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20)];
        _statusBarView.backgroundColor = [UIColor blackColor];
        _statusBarView.alpha = .8;
        [self.view addSubview:_statusBarView];
    }
    return _statusBarView;
}

#pragma mark - middleViewLazy
-(UIView *)middleView
{
    if (!_middleView)
    {
        _middleView = [[UIView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.width * 707/1240 + 20, [UIScreen mainScreen].bounds.size.width, 60)];
        [self.view addSubview:_middleView];
        UISwitch *remindSW = [[UISwitch alloc] init];
        [_middleView addSubview:remindSW];
        [remindSW mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(5);
            make.right.equalTo(-10);
        }];
        UILabel *label = [[UILabel alloc]init];
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = [UIColor lightGrayColor];
        label.text = @"开播提醒";
        [_middleView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(remindSW);
            make.bottom.equalTo(-5);
        }];
        UIButton *btn = [[UIButton alloc] init];
        [btn setImage:[UIImage imageNamed:@"live_followButton_icon_36x36_"] forState:UIControlStateNormal];
        [_middleView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(remindSW);
            make.right.equalTo(remindSW.mas_left).offset(-10);
            make.size.equalTo(36);
        }];
        UILabel *label2 = [[UILabel alloc]init];
        label2.font = [UIFont systemFontOfSize:12];
        label2.textColor = [UIColor lightGrayColor];
        label2.text = @"关注";
        [_middleView addSubview:label2];
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(btn);
            make.bottom.equalTo(-5);
        }];
    }
    return _middleView;
}

-(UIImageView *)avatarIV
{
    if(!_avatarIV)
    {
        _avatarIV = [[UIImageView alloc] init];
        _avatarIV.layer.cornerRadius = 50/2.0;
        _avatarIV.clipsToBounds = YES;
        [self.middleView addSubview:_avatarIV];
        [_avatarIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(50);
            make.top.left.equalTo(5);
        }];
    }
    return _avatarIV;
}

-(UILabel *)nickLB
{
    if(!_nickLB)
    {
        _nickLB = [[UILabel alloc]init];
        [self.middleView addSubview:_nickLB];
        [_nickLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.avatarIV);
            make.left.equalTo(self.avatarIV.mas_right).offset(10);
        }];
    }
    return _nickLB;
}

-(UILabel *)titleLB
{
    if(!_titleLB)
    {
        _titleLB = [[UILabel alloc]init];
        _titleLB.textColor = [UIColor lightGrayColor];
        _titleLB.font = [UIFont systemFontOfSize:16];
        [self.middleView addSubview:_titleLB];
        [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nickLB.mas_bottom).offset(5);
            make.left.equalTo(self.avatarIV.mas_right).offset(10);
            make.width.equalTo(200);
        }];
    }
    return _titleLB;
}

#pragma mark - settingViewLazy
-(UIView *)settingView
{
    if(!_settingView)
    {
        //设置view
        _settingView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width * 707/1240)];
        [self.view addSubview:_settingView];
        
        //关闭按钮
        UIButton *closeBtn = [[UIButton alloc]init];
        [closeBtn setImage:[UIImage imageNamed:@"btn_nav_player_back_normal_30x30_"] forState:UIControlStateNormal];
        closeBtn.alpha = touM;
        //block内泄漏,解决方法:使用系统自带的 addTarget方法 替换 bk_addEventHandler
        [closeBtn addTarget:self action:@selector(popVCBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_settingView addSubview:closeBtn];
        [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(30);
            make.left.top.equalTo(10);
        }];
        //设置按钮,无泄漏
        UIButton *settingBtn = [[UIButton alloc]init];
        [settingBtn setImage:[UIImage imageNamed:@"btn_sp_player_more_mormal_30x30_"] forState:UIControlStateNormal];
        settingBtn.alpha = touM;
        [settingBtn bk_addEventHandler:^(id sender) {
            
        } forControlEvents:UIControlEventTouchUpInside];
        [_settingView addSubview:settingBtn];
        [settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(30);
            make.top.equalTo(10);
            make.right.equalTo(-10);
        }];
        //隐藏礼物按钮，无泄漏
        UIButton *hiddenGiftBtn = [[UIButton alloc]init];
        [hiddenGiftBtn setImage:[UIImage imageNamed:@"live_hiddenGift_icon_30x30_"] forState:UIControlStateNormal];
        [hiddenGiftBtn setImage:[UIImage imageNamed:@"live_hiddenGift_selected_icon_30x30_"] forState:UIControlStateSelected];
        hiddenGiftBtn.alpha = touM;
        [hiddenGiftBtn bk_addEventHandler:^(id sender) {
            hiddenGiftBtn.selected = !hiddenGiftBtn.selected;
        } forControlEvents:UIControlEventTouchUpInside];
        CGFloat top = (_settingView.frame.size.height - 140)/3.0;
        [_settingView addSubview:hiddenGiftBtn];
        [hiddenGiftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(30);
            make.top.equalTo(settingBtn.mas_bottom).offset(top);
            make.right.equalTo(-10);
        }];
        //播放暂停按钮
        UIButton *avPlayBtn = [[UIButton alloc]init];
        [avPlayBtn setImage:[UIImage imageNamed:@"btn_sp_player_zanting_30x30_"] forState:UIControlStateNormal];
        [avPlayBtn setImage:[UIImage imageNamed:@"btn_sp_player_bofang_30x30_"] forState:UIControlStateSelected];
        avPlayBtn.alpha = touM;
        //block内泄漏,解决方法:使用系统自带的 addTarget方法 替换 bk_addEventHandler
        [avPlayBtn addTarget:self action:@selector(pauseAndplayBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_settingView addSubview:avPlayBtn];
        [avPlayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(30);
            make.top.equalTo(hiddenGiftBtn.mas_bottom).offset(top);
            make.right.equalTo(-10);
        }];
        //全屏按钮
        UIButton *fullScreenBtn = [[UIButton alloc]init];
        [fullScreenBtn setImage:[UIImage imageNamed:@"btn_nav_player_quanping_normal_30x30_"] forState:UIControlStateNormal];
        fullScreenBtn.alpha = touM;
        //block内泄漏,解决方法:使用系统自带的 addTarget方法 替换 bk_addEventHandler
        [fullScreenBtn addTarget:self action:@selector(changeDeviceOrientation) forControlEvents:UIControlEventTouchUpInside];
        [_settingView addSubview:fullScreenBtn];
        [fullScreenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(30);
            make.bottom.equalTo(-10);
            make.right.equalTo(-10);
        }];
        [self viewLB];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [tap addTarget:self action:@selector(tapSettingView:)];
        [_settingView addGestureRecognizer:tap];
        [self configsetBtnDisappTimerWithView:_settingView];
    }
    return _settingView;
}
#pragma mark - 配置视图上的按钮点击事件

//左上角 关闭按钮方法
-(void)popVCBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
//播放暂停按钮
-(void)pauseAndplayBtn:(UIButton*)sender
{
    sender.selected = !sender.selected;
    if (sender.selected)
    {
        [_ijkPlayer pause];
    }
    else
    {
        [_ijkPlayer play];
    }
}
//强制切换横竖屏
-(void)changeDeviceOrientation
{
    NSLog(@"touchOrientation");
    //ios 规定 不允许强制用代码切换横竖屏
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = UIInterfaceOrientationPortrait;
        if (UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation)) {
            val = UIInterfaceOrientationLandscapeRight;
        }
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}
//点击隐藏配置视图
-(void)tapSettingView:(id)sender
{
    [UIView animateWithDuration:1 animations:^{
        for (UIView *view in _settingView.subviews)
        {
            if (view.alpha)
            {
                view.alpha = 0;
            }
            else
            {
                view.alpha = touM;
                [self configsetBtnDisappTimerWithView:_settingView];
            }
        }
    }];
}
//配置控制设置视图自动隐藏的定时器
-(void)configsetBtnDisappTimerWithView:(UIView*)superView
{
    [_setBtnDisappTimer invalidate];
    _setBtnDisappTimer = nil;
    _setBtnDisappTimer = [NSTimer bk_scheduledTimerWithTimeInterval:10 block:^(NSTimer *timer) {
        [UIView animateWithDuration:1 animations:^{
            for (UIView *view in superView.subviews)
            {
                view.alpha = 0;
            }
        }];
    } repeats:NO];
}

-(UILabel *)viewLB
{
    if (!_viewLB)
    {
        _viewLB = [[UILabel alloc] init];
        _viewLB.layer.cornerRadius = 20/2.0;
        _viewLB.clipsToBounds = YES;
        _viewLB.textColor = [UIColor whiteColor];
        _viewLB.font = [UIFont systemFontOfSize:12];
        _viewLB.backgroundColor = [UIColor blackColor];
        _viewLB.alpha = .5;
        [self.settingView addSubview:_viewLB];
        [_viewLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(20);
            make.left.equalTo(10);
            make.bottom.equalTo(-10);
        }];
    }
    return _viewLB;
}

#pragma mark - orientationViewLazy

-(UIView *)orientationView
{
    if (!_orientationView)
    {
        _orientationView = [[UIView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:_orientationView];
  
        //横屏顶部view
        UIView *topView = [[UIView alloc] init];
        topView.backgroundColor = [UIColor blackColor];
        topView.alpha = .8;
        [_orientationView addSubview:topView];
        [topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(40);
            make.top.left.right.equalTo(0);
        }];
        //关闭横屏按钮
        UIButton *closeBtn = [[UIButton alloc]init];
        [closeBtn setImage:[UIImage imageNamed:@"btn_nav_player_back_normal_30x30_"] forState:UIControlStateNormal];
        closeBtn.alpha = touM;
        [closeBtn addTarget:self action:@selector(changeDeviceOrientation) forControlEvents:UIControlEventTouchUpInside];
        [topView addSubview:closeBtn];
        [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(30);
            make.left.equalTo(20);
            make.centerY.equalTo(0);
        }];
        //标题文本
        UILabel *oTittleLB  = [[UILabel alloc]init];
        oTittleLB.textColor = [UIColor lightGrayColor];
        oTittleLB.font = [UIFont systemFontOfSize:16];
        oTittleLB.text = _titleLB.text;
        [topView addSubview:oTittleLB];
        [oTittleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.left.equalTo(closeBtn.mas_right).offset(15);
        }];
        //分享按钮
        UIButton *shareBtn = [[UIButton alloc] init];
        [shareBtn setImage:[UIImage imageNamed:@"btn_nav_hp_player_share_normal_30x30_"] forState:UIControlStateNormal];
        [shareBtn setImage:[UIImage imageNamed:@"btn_nav_hp_player_share_selected_30x30_"] forState:UIControlStateHighlighted];
        [topView addSubview:shareBtn];
        [shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(30);
            make.right.equalTo(-20);
            make.centerY.equalTo(0);
        }];
        //弹幕按钮
        UIButton *likeBtn = [[UIButton alloc] init];
        [likeBtn setImage:[UIImage imageNamed:@"btn_nav_hp_player_gz_30x30_"] forState:UIControlStateNormal];
        [topView addSubview:likeBtn];
        [likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(30);
            make.right.equalTo(shareBtn.mas_left).offset(-20);
            make.centerY.equalTo(0);
        }];
        
        //横屏底部view
        _bottomTFView = [[UIView alloc] init];
        _bottomTFView.backgroundColor = [UIColor blackColor];
        _bottomTFView.alpha = .8;
        [_orientationView addSubview:_bottomTFView];
        [_bottomTFView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(45);
            make.bottom.left.right.equalTo(0);
        }];
        //播放暂停按钮
        UIButton *avPlayBtn = [[UIButton alloc]init];
        [avPlayBtn setImage:[UIImage imageNamed:@"btn_sp_player_zanting_30x30_"] forState:UIControlStateNormal];
        [avPlayBtn setImage:[UIImage imageNamed:@"btn_sp_player_bofang_30x30_"] forState:UIControlStateSelected];
        avPlayBtn.alpha = touM;
        [avPlayBtn addTarget:self action:@selector(pauseAndplayBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomTFView addSubview:avPlayBtn];
        [avPlayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(30);
            make.centerY.equalTo(0);
            make.left.equalTo(20);
        }];
        //刷新按钮
        UIButton *refreshBtn = [[UIButton alloc]init];
        [refreshBtn setImage:[UIImage imageNamed:@"btn_hp_player_toolbar_refresh_normal_30x30_"] forState:UIControlStateNormal];
        [_bottomTFView addSubview:refreshBtn];
        [refreshBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(30);
            make.centerY.equalTo(0);
            make.left.equalTo(avPlayBtn.mas_right).offset(20);
        }];
        //礼物按钮
        UIButton *gifttBtn = [[UIButton alloc] init];
        [gifttBtn setImage:[UIImage imageNamed:@"btn_bofang_toolbar_gift_25x25_"] forState:UIControlStateNormal];
        [_bottomTFView addSubview:gifttBtn];
        [gifttBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(25);
            make.right.equalTo(-20);
            make.centerY.equalTo(0);
        }];
        //弹幕按钮
        UIButton *tanMuBtn = [[UIButton alloc] init];
        [tanMuBtn setImage:[UIImage imageNamed:@"btn_hp_player_toolbar_dan_on_30x30_"] forState:UIControlStateNormal];
        [tanMuBtn setImage:[UIImage imageNamed:@"btn_hp_player_toolbar_dan_on_click_30x30_"] forState:UIControlStateHighlighted];
        [_bottomTFView addSubview:tanMuBtn];
        [tanMuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(30);
            make.right.equalTo(gifttBtn.mas_left).offset(-20);
            make.centerY.equalTo(0);
        }];
        //底下文本输入view
        UIView *textView = [[UIView alloc] init];
        textView.backgroundColor = [UIColor colorWithRed:32/255.0 green:32/255.0 blue:32/255.0 alpha:1];
        textView.layer.cornerRadius = 15;
        textView.clipsToBounds = YES;
        [_bottomTFView addSubview:textView];
        [textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.left.equalTo(refreshBtn.mas_right).equalTo(25);
            make.right.equalTo(tanMuBtn.mas_left).equalTo(-25);
            make.height.equalTo(30);
        }];
        //热按钮
        UIButton *hotBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [hotBtn setImage:[UIImage imageNamed:@"live_hotButton_icon_25x25_"] forState:UIControlStateNormal];
        [hotBtn setImage:[UIImage imageNamed:@"live_hotButton_pressIcon_25x25_"] forState:UIControlStateHighlighted];
        hotBtn.alpha = touM;
        [textView addSubview:hotBtn];
        [hotBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(25);
            make.left.equalTo(10);
            make.centerY.equalTo(0);
        }];
        //右边发送按钮
        UIButton *sendBtn = [[UIButton alloc] init];
        [sendBtn setImage:[UIImage imageNamed:@"btn_player_toolbar_sr_send_normal_25x25_"] forState:UIControlStateNormal];
        [sendBtn setImage:[UIImage imageNamed:@"btn_player_toolbar_sr_send_selected_25x25_"] forState:UIControlStateHighlighted];
        sendBtn.alpha = touM;
        [textView addSubview:sendBtn];
        [sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(25);
            make.right.equalTo(-10);
            make.centerY.equalTo(0);
        }];
        //发送输入框
        UITextField *textField = [[UITextField alloc] init];
        textField.font = [UIFont systemFontOfSize:14];
        textField.alpha = touM;
        textField.textColor = [UIColor whiteColor];
        NSAttributedString *str = [[NSAttributedString alloc]initWithString:@"不发弹幕真的不寂寞吗？" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        textField.attributedPlaceholder = str;
        [textView addSubview:textField];
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.height.equalTo(25);
            make.left.equalTo(hotBtn.mas_right).offset(15);
            make.right.equalTo(sendBtn.mas_left);
        }];
        textField.delegate = self;
        [textField bk_addEventHandler:^(id sender) {
            
        } forControlEvents:UIControlEventEditingDidEndOnExit];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [tap addTarget:self action:@selector(tapOrientationView:)];
        [_orientationView addGestureRecognizer:tap];
        [self configsetBtnDisappTimerWithView:_orientationView];
    }
    return _orientationView;
}
#pragma mark - 横屏配置视图的按钮点击事件
//横屏时 点击隐藏配置视图
-(void)tapOrientationView:(id)sender
{
    [UIView animateWithDuration:.5 animations:^{
        for (UIView *view in _orientationView.subviews)
        {
//            view.hidden = !view.hidden;
            if (view.alpha)
            {
                view.alpha = 0;
            }
            else
            {
                view.alpha = .8;
                [self configsetBtnDisappTimerWithView:_orientationView];
            }
        }
    }];
}

#pragma mark - 键盘通知
//键盘弹起 通知的 事件方法
-(void)openKeyBoard:(NSNotification*)notification
{
    [self.setBtnDisappTimer invalidate];
    //获取动画类型
    NSInteger option = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    //动画持续时间
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //键盘结束时 的 frame
    CGRect frame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat bottom = -frame.size.height;
    
    [_bottomTFView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bottom);
        make.left.right.equalTo(0);
        make.height.equalTo(45);
    }];
    //动画修改约束
    [UIView animateWithDuration:duration delay:0 options:option animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
}

-(void)closeKeyBoard:(NSNotification*)notification
{
    //获取动画类型
    NSInteger option = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    //动画持续时间
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [_bottomTFView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(0);
        make.height.equalTo(45);
    }];
    //动画修改约束
    [UIView animateWithDuration:duration delay:0 options:option animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
}

#pragma mark - Life

//设置任务栏文字颜色为白色
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(instancetype)initWithUid:(NSString *)uid
{
    if (self = [super init])
    {
        self.uid = uid;
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    kAppDelegate.isRotating = YES;//当前window可旋转
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    [_ijkPlayer shutdown];
    _ijkPlayer = nil;
    kAppDelegate.isRotating = NO;//当前window不支持旋转
}

-(void)dealloc
{
    NSLog(@"-------------------room dealloc-------------------");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [NetManager getLiveRommDataWithUid:self.uid CompletionHandler:^(RoomModel *model, NSError *error) {
        if (!error)
        {
            self.model = model;
            [self statusBarView];//顶部任务栏黑色view
            [self configPlayer];//视频播放
            [self configMidView];//中间横视图
            [self configRoomPVC];//底下PageVC
        }
    }];
    //接收键盘弹起的通知  弹起的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openKeyBoard:) name:UIKeyboardWillShowNotification object:nil];
    //接收键盘   收回的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeKeyBoard:) name:UIKeyboardWillHideNotification object:nil];
}

//当横竖屏切换操作 被触发时，会执行
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation ;
    if (UIDeviceOrientationIsLandscape(orientation))
        //是横屏
    {
        _ijkPlayer.view.frame = self.view.bounds;
        //根据横竖屏 可以隐藏和显示 对应的额外控制视图
        self.orientationView.frame = self.view.bounds;
        _statusBarView.hidden = YES;
        _orientationView.hidden = NO;
        _settingView.hidden = YES;
        _middleView.hidden = YES;
        _pvc.view.hidden = YES;
        
    }
    else
    {
       _ijkPlayer.view.frame = CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width * 707/1240);
        _statusBarView.hidden = NO;
        _orientationView.hidden = YES;
        _settingView.hidden = NO;
        _middleView.hidden = NO;
        _pvc.view.hidden = NO;
    }
}


#pragma mark - 配置视频播放
-(void)configPlayer
{
    NSInteger hls = self.model.live.ws.hls.main_mobile;
    NSString *path;
    switch (hls)
    {
        case 0:
            path = self.model.live.ws.hls.zero.src;
            break;
        case 1:
            path = self.model.live.ws.hls.one.src;
            break;
        case 2:
            path = self.model.live.ws.hls.two.src;
            break;
        case 3:
            path = self.model.live.ws.hls.three.src;
            break;
        case 4:
            path = self.model.live.ws.hls.four.src;
            break;
        case 5:
            path = self.model.live.ws.hls.five.src;
            break;
        case 6:
            path = self.model.live.ws.hls.six.src;
            break;
    }
    NSLog(@"hls %ld",hls);
    
    self.ijkPlayer = [[IJKFFMoviePlayerController alloc] initWithContentURLString:path withOptions:[IJKFFOptions optionsByDefault]];
    [self.view addSubview:_ijkPlayer.view];
    _ijkPlayer.view.frame = CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width * 707/1240);
    _ijkPlayer.scalingMode = IJKMPMovieScalingModeAspectFill;
    [_ijkPlayer prepareToPlay];
    
    [self settingView];
}
#pragma mark - 配置中间横视图
-(void)configMidView
{
    [self.avatarIV setImageURL:self.model.avatar.lzj_toURL];
    self.nickLB.text = self.model.nick;
    self.titleLB.text = self.model.title;
    
    NSTextAttachment *strAtt = [[NSTextAttachment alloc]init];
    strAtt.image = [UIImage imageNamed:@"player_audienceCount_icon_10x10_"];
    strAtt.bounds = CGRectMake(1, -2, 10, 10);
    NSAttributedString *str1 = [NSAttributedString attributedStringWithAttachment:strAtt];
    
    NSString *text = self.model.view > 10000 ? [NSString stringWithFormat:@" %.1lf万",self.model.view/10000.0] : [NSString stringWithFormat:@" %ld",self.model.view];
    NSAttributedString *str2 = [[NSAttributedString alloc]initWithString:text attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    NSMutableAttributedString *muStr = [[NSMutableAttributedString alloc]init];
    [muStr appendAttributedString:str1];
    [muStr appendAttributedString:str2];
    
    _viewLB.attributedText = muStr;
}
#pragma mark - 配置底下PageVC
-(void)configRoomPVC
{
    _pvc = [[RoomPageVC alloc] initWithModel:_model];
    _pvc.menuViewStyle = WMMenuViewStyleLine;
    _pvc.titleSizeNormal = 16;
    _pvc.titleSizeSelected = 16;
    _pvc.titleColorNormal = [UIColor lightGrayColor];
    _pvc.titleColorSelected = [UIColor redColor];
    _pvc.progressWidth = 35;
    
    [self addChildViewController:_pvc];
    _pvc.view.frame = CGRectMake(0,_ijkPlayer.view.frame.size.height + _middleView.frame.size.height + 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height -(_ijkPlayer.view.frame.size.height + _middleView.frame.size.height + 20));
    _pvc.viewFrame = CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height -(_ijkPlayer.view.frame.size.height + _middleView.frame.size.height + 20 ));
    [self.view addSubview:_pvc.view];
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
