//
//  LiaoTianVC.m
//  TRProject
//
//  Created by Jian on 2016/11/25.
//  Copyright © 2016年 Tedu. All rights reserved.
//

#import "LiaoTianVC.h"

@interface LiaoTianVC ()<UITextFieldDelegate>

@property (nonatomic) UIView* labelView;
@property (nonatomic) UIView* inputView;

@end

@implementation LiaoTianVC

#pragma mark - Lazy
-(UIView *)labelView
{
    if (!_labelView)
    {
        _labelView = [[UIView alloc] init];
        [self.view addSubview:_labelView];
        [_labelView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(0);
        }];
        
        UILabel *label = [[UILabel alloc] init];
        label.text = @"全民直播平台支持直播低俗、侵权、色情以及反动内容";
        label.textColor = [UIColor redColor];
        label.font = [UIFont systemFontOfSize:14];
        [_labelView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(10);
        }];
        
        
        
        UILabel *label1 = [[UILabel alloc] init];
        label1.text = @"正在连接弹幕服务器...";
        label1.textColor = [UIColor lightGrayColor];
        label1.font = [UIFont systemFontOfSize:14];
        [_labelView addSubview:label1];
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(label.mas_bottom);
            make.left.equalTo(10);
        }];
        
//        UILabel *label2 = [[UILabel alloc] init];
//        label2.text = @"弹幕服务器连接成功";
//        label2.textColor = [UIColor lightGrayColor];
//        label2.font = [UIFont systemFontOfSize:14];
//        [_labelView addSubview:label2];
//        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(label1.mas_bottom);
//            make.left.equalTo(10);
//            make.bottom.equalTo(0);
//        }];
    }
    return _labelView;
}

-(UIView *)inputView
{
    if (!_inputView)
    {
        _inputView = [[UIView alloc] init];
        _inputView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_inputView];
        [_inputView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(0);
            make.height.equalTo(40);
        }];
        
        UIButton *hotBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [hotBtn setImage:[UIImage imageNamed:@"live_hotButton_icon_25x25_"] forState:UIControlStateNormal];
        [hotBtn setImage:[UIImage imageNamed:@"live_hotButton_pressIcon_25x25_"] forState:UIControlStateHighlighted];
        [_inputView addSubview:hotBtn];
        [hotBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(25);
            make.left.equalTo(18);
            make.centerY.equalTo(0);
        }];
        
        UIButton *gifttBtn = [[UIButton alloc] init];
        [gifttBtn setImage:[UIImage imageNamed:@"btn_bofang_toolbar_gift_25x25_"] forState:UIControlStateNormal];
        [_inputView addSubview:gifttBtn];
        [gifttBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(25);
            make.right.equalTo(-18);
            make.centerY.equalTo(0);
        }];
        
        UIView *textView = [[UIView alloc] init];
        textView.layer.cornerRadius = 25/2.0;
        textView.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1.0];
        [_inputView addSubview:textView];
        [textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(25);
            make.left.equalTo(60);
            make.right.equalTo(-60);
            make.centerY.equalTo(0);
        }];
        
        UIButton *sendBtn = [[UIButton alloc] init];
        [sendBtn setImage:[UIImage imageNamed:@"btn_player_toolbar_sr_send_normal_25x25_"] forState:UIControlStateNormal];
        [sendBtn setImage:[UIImage imageNamed:@"btn_player_toolbar_sr_send_selected_25x25_"] forState:UIControlStateHighlighted];
        [textView addSubview:sendBtn];
        [sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(25);
            make.right.equalTo(-10);
            make.centerY.equalTo(0);
        }];
        
        UITextField *textField = [[UITextField alloc] init];
        textField.font = [UIFont systemFontOfSize:14];
        textField.placeholder = @"弹幕走一走，活到九十九";
        [textView addSubview:textField];
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(0);
            make.height.equalTo(25);
            make.left.equalTo(10);
            make.right.equalTo(-35);
        }];
        
        [textField bk_addEventHandler:^(id sender) {
            
        } forControlEvents:UIControlEventEditingDidEndOnExit];
    }
    return _inputView;
}

#pragma mark - Life
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:244/255.0 green:251/255.0 blue:1.0 alpha:1.0];
    [self inputView];
    [self labelView];
    
    //接收键盘弹起的通知  弹起的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openKeyBoard:) name:UIKeyboardWillShowNotification object:nil];
    //接收键盘   收回的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeKeyBoard:) name:UIKeyboardWillHideNotification object:nil];
}

//键盘弹起 通知的 事件方法
-(void)openKeyBoard:(NSNotification*)notification
{
    //获取动画类型
    NSInteger option = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    //动画持续时间
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //键盘结束时 的 frame
    CGRect frame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat bottom = -frame.size.height;
    
    [_inputView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bottom);
        make.left.right.equalTo(0);
        make.height.equalTo(40);
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
    [_inputView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(0);
        make.height.equalTo(40);
    }];
    //动画修改约束
    [UIView animateWithDuration:duration delay:0 options:option animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
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
