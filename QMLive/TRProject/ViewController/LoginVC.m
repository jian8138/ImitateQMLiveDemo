//
//  LoginVC.m
//  TRProject
//
//  Created by Jian on 2016/11/23.
//  Copyright © 2016年 Tedu. All rights reserved.
//

#import "LoginVC.h"
#import "RegisterVC.h"
#import "EMSDK.h"

@interface LoginVC ()

@property (nonatomic) UIView* accountView;
@property (nonatomic) UIView* pwView;
@property (nonatomic) UIView* bottomLine;

@property (nonatomic) UITextField* accountTF;
@property (nonatomic) UITextField* passwordTF;
@property (nonatomic) UIButton* codeShowBtn;
@property (nonatomic) UIButton* loginBtn;
@property (nonatomic) UIButton* forgetPWBtn;
@property (nonatomic) UIButton* qqBtn;
@property (nonatomic) UIButton* sinaBtn;
@property (nonatomic) UIButton* weixinBtn;

@end

@implementation LoginVC

#pragma mark - Lazy
-(UIView *)accountView
{
    if (!_accountView)
    {
        _accountView = [[UIView alloc]init];
        _accountView.backgroundColor = [UIColor colorWithRed:230/255.0 green:239/255.0 blue:243/255.0 alpha:1.0];
        _accountView.layer.cornerRadius = 25;
        _accountView.clipsToBounds = YES;
        [self.view addSubview:_accountView];
        [_accountView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(50);
            make.left.equalTo(10);
            make.right.equalTo(-10);
            make.top.equalTo(15);
        }];
        UIImageView *picIV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ic_log_account_25x25_"]];
        [_accountView addSubview:picIV];
        [picIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(25);
            make.centerY.equalTo(0);
            make.left.equalTo(10);
        }];
    }
    return _accountView;
}

-(UIView *)pwView
{
    if (!_pwView)
    {
        _pwView = [[UIView alloc]init];
        _pwView.backgroundColor = [UIColor colorWithRed:230/255.0 green:239/255.0 blue:243/255.0 alpha:1.0];
        _pwView.layer.cornerRadius = 25;
        _pwView.clipsToBounds = YES;
        [self.view addSubview:_pwView];
        [_pwView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(50);
            make.left.equalTo(10);
            make.right.equalTo(-10);
            make.top.equalTo(self.accountView.mas_bottom).offset(15);
        }];
        
        UIImageView *picIV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ic_log_code_25x25_"]];
        [_pwView addSubview:picIV];
        [picIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(25);
            make.centerY.equalTo(0);
            make.left.equalTo(10);
        }];
    }
    return _pwView;
}

-(UITextField *)accountTF
{
    if (!_accountTF)
    {
        _accountTF = [[UITextField alloc]init];
        _accountTF.placeholder = @"用户名/手机号";
        _accountTF.font = [UIFont systemFontOfSize:15];
        [self.accountView addSubview:_accountTF];
        [_accountTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.left.equalTo(45);
            make.right.equalTo(-45);
        }];
    }
    return _accountTF;
}

-(UITextField *)passwordTF
{
    if (!_passwordTF)
    {
        _passwordTF = [[UITextField alloc]init];
        _passwordTF.placeholder = @"输入密码";
        _passwordTF.secureTextEntry = YES;
        _passwordTF.font = [UIFont systemFontOfSize:15];
        [self.pwView addSubview:_passwordTF];
        [_passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.left.equalTo(45);
            make.right.equalTo(-45);
        }];
    }
    return _passwordTF;
}

-(UIButton *)codeShowBtn
{
    if (!_codeShowBtn)
    {
        _codeShowBtn = [[UIButton alloc]init];
        [_codeShowBtn setImage:[UIImage imageNamed:@"ic_log_code_hide_25x25_"] forState:UIControlStateNormal];
        [_codeShowBtn setImage:[UIImage imageNamed:@"ic_log_code_show_25x25_"] forState:UIControlStateSelected];
        [_codeShowBtn addTarget:self action:@selector(codeShowBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.pwView addSubview:_codeShowBtn];
        [_codeShowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(25);
            make.centerY.equalTo(0);
            make.right.equalTo(-10);
        }];
    }
    return _codeShowBtn;
}

-(UIButton *)loginBtn
{
    if (!_loginBtn)
    {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _loginBtn.backgroundColor = [UIColor colorWithRed:251/255.0 green:51/255.0 blue:67/255.0 alpha:1.0];
        _loginBtn.layer.cornerRadius = 25;
        _loginBtn.clipsToBounds = YES;
        NSAttributedString *attrStr = [[NSAttributedString alloc]initWithString:@"登录" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:19]}];
        [_loginBtn setAttributedTitle:attrStr forState:UIControlStateNormal];
        [_loginBtn addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_loginBtn];
        [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(50);
            make.left.equalTo(10);
            make.right.equalTo(-10);
            make.top.equalTo(self.pwView.mas_bottom).offset(15);
        }];
    }
    return _loginBtn;
}

-(UIButton *)forgetPWBtn
{
    if (!_forgetPWBtn)
    {
        _forgetPWBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _forgetPWBtn.backgroundColor = [UIColor clearColor];
        [_forgetPWBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
        [_forgetPWBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.view addSubview:_forgetPWBtn];
        [_forgetPWBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.top.equalTo(self.loginBtn.mas_bottom).offset(15);
        }];
    }
    return _forgetPWBtn;
}

-(UIView *)bottomLine
{
    if (!_bottomLine)
    {
        _bottomLine = [[UIView alloc]init];
        _bottomLine.backgroundColor = [UIColor colorWithRed:235/255.0 green:248/255.0 blue:248/255.0 alpha:1.0];
        [self.view addSubview:_bottomLine];
        [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(1);
            make.left.equalTo(10);
            make.right.equalTo(-10);
            make.bottom.equalTo(-150);
        }];
        UILabel *label = [[UILabel alloc]init];
        label.text = @"第三方登录";
        label.textColor = [UIColor lightGrayColor];
        label.font = [UIFont systemFontOfSize:15];
        label.backgroundColor = [UIColor colorWithRed:244/255.0 green:251/255.0 blue:1.0 alpha:1.0];
        label.textAlignment = NSTextAlignmentCenter;
        [_bottomLine addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(100);
            make.center.equalTo(0);
        }];
    }
    return _bottomLine;
}

-(UIButton *)sinaBtn
{
    if (!_sinaBtn)
    {
        _sinaBtn = [[UIButton alloc]init];
        _sinaBtn.contentMode = UIViewContentModeScaleAspectFit;
        [_sinaBtn setImage:[UIImage imageNamed:@"btn_player_share_weibo_50x50_"] forState:UIControlStateNormal];
        [self.view addSubview:_sinaBtn];
        [_sinaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(50);
            make.centerX.equalTo(0);
            make.top.equalTo(self.bottomLine.mas_bottom).offset(30);
        }];
    }
    return _sinaBtn;
}

-(UIButton *)qqBtn
{
    if (!_qqBtn)
    {
        _qqBtn = [[UIButton alloc]init];
        _qqBtn.contentMode = UIViewContentModeScaleAspectFit;
        [_qqBtn setImage:[UIImage imageNamed:@"btn_player_share_qq_50x50_"] forState:UIControlStateNormal];
        [self.view addSubview:_qqBtn];
        [_qqBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(50);
            make.right.equalTo(self.sinaBtn.mas_left).offset(-50);
            make.top.equalTo(self.bottomLine.mas_bottom).offset(30);
        }];
    }
    return _qqBtn;
}

-(UIButton *)weixinBtn
{
    if (!_weixinBtn)
    {
        _weixinBtn = [[UIButton alloc]init];
        _weixinBtn.contentMode = UIViewContentModeScaleAspectFit;
        [_weixinBtn setImage:[UIImage imageNamed:@"btn_player_share_wechat_50x50_"] forState:UIControlStateNormal];
        [self.view addSubview:_weixinBtn];
        [_weixinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(50);
            make.left.equalTo(self.sinaBtn.mas_right).offset(50);
            make.top.equalTo(self.bottomLine.mas_bottom).offset(30);
        }];
    }
    return _weixinBtn;
}

#pragma mark - Life
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:244/255.0 green:251/255.0 blue:1.0 alpha:1.0];
    self.navigationItem.title = @"登录";
    
    __weak LoginVC *weakSelf = self;
    
    UIBarButtonItem *leftbarItem = [[UIBarButtonItem alloc]bk_initWithImage:[UIImage imageNamed:@"btn_nav_log_close_25x25_"] style:UIBarButtonItemStylePlain handler:^(id sender) {
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -15;
    self.navigationItem.leftBarButtonItems = @[spaceItem,leftbarItem];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    rightBtn.frame = CGRectMake(0, 0, 60, 30);
    [rightBtn setTitle:@"注册" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    rightBtn.layer.cornerRadius = 30/2.0;
    rightBtn.clipsToBounds = YES;
    rightBtn.layer.borderWidth = 1;
    rightBtn.layer.borderColor = [UIColor redColor].CGColor;
    [rightBtn bk_addEventHandler:^(id sender) {
        [weakSelf.navigationController pushViewController:[[RegisterVC alloc]init] animated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightbarItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightbarItem;
    
    [self accountTF];
    [self passwordTF];
    [self codeShowBtn];
    [self loginBtn];
    [self forgetPWBtn];
    [self qqBtn];
    [self weixinBtn];
}

-(void)loginBtnClick:(UIButton*)sender
{
    if (!_accountTF.text.length || !_passwordTF.text.length)
    {
        [self.view showMsg:@"账号名或密码不能为空!"];
        return;
    }
    __block EMError *error = nil;
    [[NSOperationQueue new] addOperationWithBlock:^{
//        [[EMClient sharedClient].options setIsAutoLogin:YES];
        error = [[EMClient sharedClient] loginWithUsername:_accountTF.text password:_passwordTF.text];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            if (!error)
            {
                UIViewController *vc = [[UIViewController alloc] init];
                vc.view.backgroundColor = [UIColor purpleColor];
                [self.navigationController pushViewController:vc animated:YES];
            }
            else
            {
                [self.view showMsg:@"登录失败!"];
            }
        }];
    }];
    
//    EMError *error = [[EMClient sharedClient] loginWithUsername:@"10086" password:@"10010"];
//    if (!error) {
//        //对于全民直播项目来说，登录成功以后，可以把用户名 存放到NSUserdefaults中，通过判断此字符串是否存在来确定用户登录状态
//        [[EMClient sharedClient].options setIsAutoLogin:YES];
//        NSLog(@"登录成功");
//    }
}

-(void)codeShowBtnClick:(UIButton*)sender
{
    sender.selected = !sender.selected;
    self.passwordTF.secureTextEntry = !sender.selected;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    NSLog(@"LoginVC dealloc!");
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
