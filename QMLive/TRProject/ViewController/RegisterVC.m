//
//  RegisterVC.m
//  TRProject
//
//  Created by Jian on 2016/11/23.
//  Copyright © 2016年 Tedu. All rights reserved.
//

#import "RegisterVC.h"
#import <SMS_SDK/SMSSDK.h>
#import "EMSDK.h"

@interface RegisterVC ()

@property (nonatomic) UIView* telephoneView;
@property (nonatomic) UIView* yzmView;
@property (nonatomic) UIView* nicknameView;
@property (nonatomic) UIView* pwView;

@property (nonatomic) UITextField* telephoneTF;
@property (nonatomic) UITextField* yzmTF;
@property (nonatomic) UITextField* accountTF;
@property (nonatomic) UITextField* passwordTF;
@property (nonatomic) UIButton* codeShowBtn;

@property (nonatomic) UIButton* registerBtn;
@property (nonatomic) UIButton* yzmBtn;

@property (nonatomic) UILabel* protocolLB;
@end

@implementation RegisterVC

#pragma mark - Lazy
-(UIView *)telephoneView
{
    if (!_telephoneView)
    {
        _telephoneView = [[UIView alloc]init];
        _telephoneView.backgroundColor = [UIColor colorWithRed:230/255.0 green:239/255.0 blue:243/255.0 alpha:1.0];
        _telephoneView.layer.cornerRadius = 25;
        _telephoneView.clipsToBounds = YES;
        [self.view addSubview:_telephoneView];
        [_telephoneView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(50);
            make.left.equalTo(10);
            make.right.equalTo(-10);
            make.top.equalTo(15);
        }];
    }
    return _telephoneView;
}

-(UIButton *)yzmBtn
{
    if (!_yzmBtn)
    {
        _yzmBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _yzmBtn.backgroundColor = [UIColor colorWithRed:45/255.0 green:150/255.0 blue:242/255.0 alpha:1.0];
        _yzmBtn.layer.cornerRadius = 15;
        _yzmBtn.clipsToBounds = YES;
        NSAttributedString *attrStr = [[NSAttributedString alloc]initWithString:@"获取验证码" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:15]}];
        [_yzmBtn setAttributedTitle:attrStr forState:UIControlStateNormal];
        [_yzmBtn addTarget:self action:@selector(sendSMS:) forControlEvents:UIControlEventTouchUpInside];
        [self.telephoneView addSubview:_yzmBtn];
        [_yzmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(100);
            make.height.equalTo(30);
            make.left.equalTo(self.telephoneTF.mas_right);
            make.right.equalTo(-10);
            make.centerY.equalTo(0);
        }];
    }
    return _yzmBtn;
}

-(UIView *)yzmView
{
    if (!_yzmView)
    {
        _yzmView = [[UIView alloc]init];
        _yzmView.backgroundColor = [UIColor colorWithRed:230/255.0 green:239/255.0 blue:243/255.0 alpha:1.0];
        _yzmView.layer.cornerRadius = 25;
        _yzmView.clipsToBounds = YES;
        [self.view addSubview:_yzmView];
        [_yzmView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(50);
            make.left.equalTo(10);
            make.right.equalTo(-10);
            make.top.equalTo(self.telephoneView.mas_bottom).offset(15);
        }];
    }
    return _yzmView;
}

-(UIView *)nicknameView
{
    if (!_nicknameView)
    {
        _nicknameView = [[UIView alloc]init];
        _nicknameView.backgroundColor = [UIColor colorWithRed:230/255.0 green:239/255.0 blue:243/255.0 alpha:1.0];
        _nicknameView.layer.cornerRadius = 25;
        _nicknameView.clipsToBounds = YES;
        [self.view addSubview:_nicknameView];
        [_nicknameView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(50);
            make.left.equalTo(10);
            make.right.equalTo(-10);
            make.top.equalTo(self.yzmView.mas_bottom).offset(15);
        }];
    }
    return _nicknameView;
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
            make.top.equalTo(self.nicknameView.mas_bottom).offset(15);
        }];
    }
    return _pwView;
}

-(UITextField *)telephoneTF
{
    if (!_telephoneTF)
    {
        _telephoneTF = [[UITextField alloc]init];
        _telephoneTF.placeholder = @"请输入手机号";
        _telephoneTF.font = [UIFont systemFontOfSize:15];
        [self.telephoneView addSubview:_telephoneTF];
        [_telephoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.left.equalTo(15);
//            make.right.equalTo(-45);
        }];
    }
    return _telephoneTF;
}

-(UITextField *)yzmTF
{
    if (!_yzmTF)
    {
        _yzmTF = [[UITextField alloc]init];
        _yzmTF.placeholder = @"请输入验证码";
        _yzmTF.font = [UIFont systemFontOfSize:15];
        [self.yzmView addSubview:_yzmTF];
        [_yzmTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.left.equalTo(15);
            make.right.equalTo(-45);
        }];
    }
    return _yzmTF;
}

-(UITextField *)accountTF
{
    if (!_accountTF)
    {
        _accountTF = [[UITextField alloc]init];
        _accountTF.placeholder = @"昵称";
        _accountTF.font = [UIFont systemFontOfSize:15];
        [self.nicknameView addSubview:_accountTF];
        [_accountTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.left.equalTo(15);
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
        _passwordTF.placeholder = @"密码";
        _passwordTF.secureTextEntry = YES;
        _passwordTF.font = [UIFont systemFontOfSize:15];
        [self.pwView addSubview:_passwordTF];
        [_passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.left.equalTo(15);
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

-(UIButton *)registerBtn
{
    if (!_registerBtn)
    {
        _registerBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _registerBtn.backgroundColor = [UIColor colorWithRed:251/255.0 green:51/255.0 blue:67/255.0 alpha:1.0];
        _registerBtn.layer.cornerRadius = 25;
        _registerBtn.clipsToBounds = YES;
        NSAttributedString *attrStr = [[NSAttributedString alloc]initWithString:@"注册" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:19]}];
        [_registerBtn setAttributedTitle:attrStr forState:UIControlStateNormal];
        [_registerBtn addTarget:self action:@selector(valiCode:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_registerBtn];
        [_registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(50);
            make.left.equalTo(10);
            make.right.equalTo(-10);
            make.top.equalTo(self.pwView.mas_bottom).offset(15);
        }];
    }
    return _registerBtn;
}

-(UILabel *)protocolLB
{
    if (!_protocolLB)
    {
        _protocolLB = [[UILabel alloc]init];
        NSTextAttachment *strAtt = [[NSTextAttachment alloc]init];
        strAtt.image = [UIImage imageNamed:@"UMS_oauth_on"];
        strAtt.bounds = CGRectMake(5, -4, 15, 15);
        NSAttributedString *str1 = [NSAttributedString attributedStringWithAttachment:strAtt];
        NSAttributedString *str2 = [[NSAttributedString alloc]initWithString:@" 同意 《" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor],NSFontAttributeName:[UIFont systemFontOfSize:15]}];
        NSAttributedString *str3 = [[NSAttributedString alloc]initWithString:@" 全民直播用户注册协议" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor],NSUnderlineStyleAttributeName:@1,NSFontAttributeName:[UIFont systemFontOfSize:15]}];
        NSAttributedString *str4 = [[NSAttributedString alloc]initWithString:@"》" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor],NSFontAttributeName:[UIFont systemFontOfSize:15]}];
        NSMutableAttributedString *muStr = [[NSMutableAttributedString alloc]init];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
            NSLog(@"label click");
        }];
        [_protocolLB addGestureRecognizer:tap];
        _protocolLB.userInteractionEnabled = YES;
        
        [muStr appendAttributedString:str1];
        [muStr appendAttributedString:str2];
        [muStr appendAttributedString:str3];
        [muStr appendAttributedString:str4];
        _protocolLB.attributedText = muStr;
        [self.view addSubview:_protocolLB];
        [_protocolLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.top.equalTo(self.registerBtn.mas_bottom).offset(15);
        }];
    }
    return _protocolLB;
}

#pragma mark - Life

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:244/255.0 green:251/255.0 blue:1.0 alpha:1.0];
    self.navigationItem.title = @"手机注册";
    [TRFactrory addBackItemToVC:self];
    
    [self telephoneTF];
    [self yzmTF];
    [self accountTF];
    [self passwordTF];
    [self codeShowBtn];
    [self registerBtn];
    [self yzmBtn];
    [self protocolLB];
}

-(void)sendSMS:(UIButton*)sender
{
    if (_telephoneTF.text.length != 11)
    {
        [self.view showMsg:@"手机格式输入错误!"];
    }
    else
    {
        [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_telephoneTF.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
            NSLog(@"%@",error ? error : @"发送成功");
            if (!error)
            {
                [self.view showMsg:@"发送成功!"];
            }
            else
            {
                [self.view showMsg:@"发送失败!"];
            }
        }];
    }
}

-(void)valiCode:(UIButton*)sender
{
    if (!_yzmTF.text.length || !_accountTF.text.length || !_passwordTF.text.length)
    {
        [self.view showMsg:@"验证码、账号名或密码输入格式错误"];
        return;
    }
    //注册流程应该是->发送验证码->验证通过后->向服务器注册 用户名和密码
    [SMSSDK commitVerificationCode:self.yzmTF.text phoneNumber:self.telephoneTF.text zone:@"86" result:^(SMSSDKUserInfo *userInfo, NSError *error) {
        NSLog(@"%@,%@", userInfo, error);
        NSLog(@"%@",error ? error : @"验证成功！");
        if (!error)
        {
            __block EMError *error = nil;
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                error = [[EMClient sharedClient] registerWithUsername:_accountTF.text password:_passwordTF.text];
                dispatch_async(dispatch_get_main_queue(),^{
                    NSLog(@"%@",error ? error : @"注册成功！");
                    if (error==nil)
                    {
                        [self.view showMsg:@"注册成功"];
                    }
                    else
                    {
                        [self.view showMsg:@"注册失败"];
                    }
                });
            });
        }
        else
        {
            [self.view showMsg:@"验证码验证错误"];
        }
    }];
}

-(void)codeShowBtnClick:(UIButton*)sender
{
    sender.selected = !sender.selected;
    self.passwordTF.secureTextEntry = !sender.selected;
}

-(void)dealloc
{
    NSLog(@"RegisterVC dealloc!");
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
