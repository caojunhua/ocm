//
//  PwdLoginViewController.m
//  OCM
//
//  Created by 曹均华 on 2018/1/22.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "PwdLoginViewController.h"
#import "OCMTextField.h"
#import "AppDelegate.h"
#import "UserItem.h"
#import "UserData.h"

@interface PwdLoginViewController ()
@property (nonatomic, strong) UIImageView *bgView;
@property (nonatomic, strong) UIImageView *logoView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) OCMTextField *textF1;
@property (nonatomic, strong) OCMTextField *textF2;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIView *sepV;
@property (nonatomic, strong) UIButton *switchBtn;
@end

@implementation PwdLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self setNotify];
}
- (void)setNotify {
    //注册键盘弹出通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    //注册键盘隐藏通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}
- (void)initUI {
    __weak typeof(self) weakSelf = self;
    self.bgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.bgView.image = [UIImage imageNamed:@"login_bg"];
    [self.view addSubview:self.bgView];
    
    self.logoView = [[UIImageView alloc] init];
    [self.view addSubview:self.logoView];
    
    self.nameLabel = [[UILabel alloc] init];
    [self.view addSubview:self.nameLabel];
    
    self.textF1 = [[OCMTextField alloc] init];
    [self.view addSubview:self.textF1];
    
    self.textF2 = [[OCMTextField alloc] init];
    [self.view addSubview:self.textF2];
    
    self.loginBtn = [[UIButton alloc] init];
    [self.view addSubview:self.loginBtn];
    
    self.sepV = [[UIView alloc] init];
    [self.view addSubview:self.sepV];
    
    self.switchBtn = [[UIButton alloc] init];
    [self.view addSubview:self.switchBtn];
    /*------------------我是分割线-----------------*/
    [self.logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(232);
        make.centerX.mas_equalTo(weakSelf.view);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    self.logoView.image = ImageIs(@"logo");
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.logoView.mas_bottom).offset(13);
        make.centerX.mas_equalTo(weakSelf.view);
        make.size.mas_equalTo(CGSizeMake(200, 35));
    }];
    self.nameLabel.text = @"外勤工作平台";
    self.nameLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
    self.nameLabel.font = [UIFont systemFontOfSize:30];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.textF1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.nameLabel.mas_bottom).offset(62);
        make.centerX.mas_equalTo(weakSelf.view);
        make.size.mas_equalTo(CGSizeMake(315, 44));
    }];
    ViewBorder(self.textF1, 1, [UIColor clearColor], 5);
    self.textF1.placeholder = @"请输入账号";
    self.textF1.backgroundColor = [UIColor RGBColorWithRed:255 withGreen:255 withBlue:255 withAlpha:0.6];
    self.textF1.font = [UIFont systemFontOfSize:15];
    
    [self.textF2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.textF1.mas_bottom).offset(10);
        make.centerX.mas_equalTo(weakSelf.view);
        make.size.mas_equalTo(CGSizeMake(315, 44));
    }];
    ViewBorder(self.textF2, 1, [UIColor clearColor], 5);
    self.textF2.placeholder = @"请输入密码";
    self.textF2.backgroundColor = [UIColor RGBColorWithRed:255 withGreen:255 withBlue:255 withAlpha:0.6];
    self.textF2.font = [UIFont systemFontOfSize:15];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.textF2.mas_bottom).offset(10);
        make.centerX.mas_equalTo(weakSelf.view);
        make.size.mas_equalTo(CGSizeMake(315, 44));
    }];
    ViewBorder(self.loginBtn, 1, [UIColor clearColor], 5);
    self.loginBtn.backgroundColor = [UIColor whiteColor];
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:[UIColor colorWithHexString:@"#1ca3f0"] forState:UIControlStateNormal];
    [self.loginBtn addTarget:self action:@selector(clickLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.loginBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    
    [self.sepV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(318, 1));
        make.centerX.mas_equalTo(weakSelf.view);
        make.bottom.mas_equalTo(weakSelf.view.mas_bottom).offset(-73);
    }];
    self.sepV.backgroundColor = [UIColor whiteColor];
    self.sepV.alpha = 0.5;
    
    [self.switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(110, 20));
        make.centerX.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(weakSelf.sepV.mas_bottom).offset(10);
    }];
    [self.switchBtn setTitle:@"切换到短信登录" forState:UIControlStateNormal];
    [self.switchBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [self.switchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.switchBtn addTarget:self action:@selector(switchToNormalLogin) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark -- 登录请求
- (void)requestLogin {
    OCMApiRequest *OCMRequest = [OCMApiRequest sharedOCMApiRequest];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"loginName"] = @"zhangsan";
    params[@"password"] = @"123";
    NSString *url = @"/v1/user/login";
    NSString *path = [BaseURL stringByAppendingString:url];
    [OCMRequest POST:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        OCMLog(@"success--%@", responseObject);
        UserItem *user = [UserItem mj_objectWithKeyValues:responseObject];
        NSInteger status = user.code;
        NSString *name = user.data.user;
        NSString *token = user.data.token;
        NSString *message = user.message;
        [YDConfigurationHelper setStringValueForConfigurationKey:UserToken withValue:token];
        OCMLog(@"status--%ld\nname--%@\ntoken--%@\nmessage--%@", status,name,token,message);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        OCMLog(@"fail--%@", error);
    }];
}
#pragma mark -- 点击事件
- (void)getVerify {
    OCMLog(@"getVerify");
}
- (void)clickLogin {
    //登录请求
//    [self requestLogin];
    OCMLog(@"clickLogin");
    id app = [UIApplication sharedApplication].delegate;
    [app showSplitView];
}
- (void)switchToNormalLogin {
    OCMLog(@"switchToNormalLogin");
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- notify
//键盘弹出后将视图向上移动
-(void)keyboardWillShow:(NSNotification *)note {
    [UIView animateWithDuration:0.5 animations:^{
        self.view.frame = CGRectMake(0, -self.view.height * 0.25, self.view.width, self.view.height);
    }];
}
//键盘隐藏后将视图恢复到原始状态
-(void)keyboardWillHide:(NSNotification *)note {
    [UIView animateWithDuration:0.5 animations:^{
        self.view.frame = CGRectMake(0, 0, self.view.width, self.view.height);
    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
#pragma mark -- dealloc
- (void)dealloc {
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
