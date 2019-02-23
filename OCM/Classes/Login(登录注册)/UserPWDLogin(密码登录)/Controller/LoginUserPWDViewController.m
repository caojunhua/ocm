//
//  LoginUserPWDViewController.m
//  OCM
//
//  Created by 曹均华 on 2017/11/29.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import "LoginUserPWDViewController.h"
#import "AppDelegate.h"
#import "KeyChainItemWrapper.h"
#import "OCMTextField.h"
#import "UIView+Toast.h"
#import "GestureLoginViewController.h"
#import "MessageLoginViewController.h"

@interface LoginUserPWDViewController ()
@property (nonatomic,strong)UIView *bgView;
@property (nonatomic,strong)UIView *logoView;
@property (nonatomic,strong)UIView *accountAndPWDView;
@property (nonatomic,strong)OCMTextField *accountField;
@property (nonatomic,strong)OCMTextField *pwdField;
@property (nonatomic,strong)UIButton *leftBtn;
@property (nonatomic,strong)UIButton *rightBtn;
@property (nonatomic,strong)UIButton *loginBtn;
@property (nonatomic,strong)UILabel *versionLabel;
@property (nonatomic,strong)UIButton *gestureBtn;
@property (nonatomic,strong)GestureLoginViewController *gesVC;
@end

@implementation LoginUserPWDViewController

static NSString *UserName = @"username";
static NSString *Userpwd = @"userpwd";
static NSString *LoginWrapper = @"LoginWrapper";
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor randomColor];
    [self setUpLayout];
    [self setUserName];
}
- (void)setUserName {
    KeychainItemWrapper *keyWrapper = [[KeychainItemWrapper alloc] initWithIdentifier:LoginWrapper accessGroup:nil];
    NSString *user = [keyWrapper objectForKey:(__bridge id)kSecAttrAccount];
    OCMLog(@"setUserName--%@", user);
    if (user) {
        self.accountField.text = user;
    }
}
- (void)setUpLayout {
    __weak typeof(self) weakSelf = self;
    //1.整体背景
    {
        self.bgView = [[UIView alloc] initWithFrame:self.view.bounds];
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.bgView.bounds];
        imgView.image = [UIImage imageNamed:@"login_bg"];
        [self.bgView addSubview:imgView];
        [self.view addSubview:_bgView];
    }
    //2.logo
    {
        self.logoView = [[UIView alloc] init];
        [self.view addSubview:_logoView];
        
        UIImageView *logoView = [[UIImageView alloc] init];
        logoView.image = [UIImage imageNamed:@"LogoImage"];
        [self.logoView addSubview:logoView];
        
        UILabel *logoLabel = [[UILabel alloc] init];
        logoLabel.text = @"外勤工作平台";
        logoLabel.font = [UIFont boldSystemFontOfSize:27];
        logoLabel.textColor = [UIColor whiteColor];
        [self.logoView addSubview:logoLabel];
        
        UIImageView *headIconView = [[UIImageView alloc] init];
        headIconView.image = [UIImage imageNamed:@"LoginDefaultIcon"];
        [self.logoView addSubview:headIconView];
        //约束
        [self.logoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(weakSelf.view);
            make.centerY.mas_equalTo(-weakSelf.view.height * 0.25);
            make.width.mas_equalTo(300);
            make.height.mas_equalTo(230);
        }];
        [logoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(45);
            make.top.mas_equalTo(16);
            make.width.height.mas_equalTo(34);
        }];
        [logoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(87);
            make.top.mas_equalTo(12);
            make.width.mas_equalTo(167);
            make.height.mas_equalTo(42);
        }];
        [headIconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(102);
            make.top.mas_equalTo(73);
            make.width.height.mas_equalTo(95);
        }];
    }
    //3.账号密码
    {
        self.accountAndPWDView = [[UIView alloc] init];
        [self.view addSubview:_accountAndPWDView];
        
        
        self.accountField = [[OCMTextField alloc] init];
        [self.accountAndPWDView addSubview:_accountField];
        self.accountField.placeholder = @"账号";
        ViewBorder(_accountField, 1, [UIColor grayColor], 5);

        self.pwdField = [[OCMTextField alloc] init];
        [self.accountAndPWDView addSubview:_pwdField];
        self.pwdField.placeholder = @"密码";
        ViewBorder(_pwdField, 1, [UIColor grayColor], 5);
        
        UIButton *leftBtn = [[UIButton alloc] init];
        _leftBtn = leftBtn;
        UIButton *rightBtn = [[UIButton alloc] init];
        _rightBtn = rightBtn;
        ViewBorder(leftBtn, 1, [UIColor grayColor], 5);
        ViewBorder(rightBtn, 1, [UIColor grayColor], 5);
        [self.accountAndPWDView addSubview:leftBtn];
        [self.accountAndPWDView addSubview:rightBtn];
        {
            leftBtn.tag = UserLoginModeByNormal;
            rightBtn.tag = UserLoginModeBySMS;

            leftBtn.imageEdgeInsets = UIEdgeInsetsZero;
            leftBtn.titleEdgeInsets = UIEdgeInsetsZero;
            rightBtn.imageEdgeInsets = UIEdgeInsetsZero;
            rightBtn.imageEdgeInsets = UIEdgeInsetsZero;
            //默认左边按钮是选中状态
            [leftBtn setImage:[UIImage imageNamed:@"RadioSelectImage"] forState:UIControlStateNormal];
            [leftBtn setTitle:@"普通登录" forState:UIControlStateNormal];

            [rightBtn setImage:[UIImage imageNamed:@"RadioUnselectImage"] forState:UIControlStateNormal];
            [rightBtn setTitle:@"短信登录" forState:UIControlStateNormal];

            [leftBtn addTarget:self action:@selector(clickLoginType:) forControlEvents:UIControlEventTouchUpInside];
            [rightBtn addTarget:self action:@selector(clickLoginType:) forControlEvents:UIControlEventTouchUpInside];
        }
        //约束
        [self.accountAndPWDView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view);
            make.top.mas_equalTo(self.logoView.mas_bottom).offset(10);
            make.width.mas_equalTo(284);
            make.height.mas_equalTo(145);
        }];
        [self.accountField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.accountAndPWDView.mas_top);
            make.left.mas_equalTo(weakSelf.accountAndPWDView.mas_left);
            make.right.mas_equalTo(weakSelf.accountAndPWDView.mas_right);
            make.height.mas_equalTo(54);
        }];
        [self.pwdField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.accountField.mas_bottom).offset(-1);
            make.left.mas_equalTo(weakSelf.accountField.mas_left);
            make.right.mas_equalTo(weakSelf.accountField.mas_right);
            make.height.mas_equalTo(54);
        }];
        [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.pwdField.mas_bottom);
            make.left.mas_equalTo(weakSelf.pwdField.mas_left);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(40);
        }];
        [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.pwdField.mas_bottom);
            make.right.mas_equalTo(weakSelf.pwdField.right);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(40);
        }];
    }
    //4.登录按钮
    {
        self.loginBtn = [[UIButton alloc] init];
        [self.view addSubview:self.loginBtn];
        ViewBorder(self.loginBtn, 2, [UIColor grayColor], 5);
        [self.loginBtn setTitle:@"点击登录" forState:UIControlStateNormal];
        [self.loginBtn setBackgroundColor:[UIColor randomColor]];
        [self.loginBtn addTarget:self action:@selector(clickLoginBtn) forControlEvents:UIControlEventTouchUpInside];
        [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.leftBtn.mas_bottom).offset(10);
            make.centerX.mas_equalTo(weakSelf.view);
            make.width.mas_equalTo(284);
            make.height.mas_equalTo(54);
        }];
    }
    //5.版本显示
    {
        self.versionLabel = [[UILabel alloc] init];
        [self.view addSubview:self.versionLabel];
        NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
        NSString *version = [infoDict objectForKey:@"CFBundleShortVersionString"];
        self.versionLabel.text = [NSString stringWithFormat:@"版本:%@",version];
        self.versionLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(weakSelf.view);
            make.bottom.mas_equalTo(weakSelf.view.mas_bottom).offset(-10);
            make.width.mas_equalTo(150);
            make.height.mas_equalTo(30);
        }];
    }
    //6.手势密码
    {
        self.gestureBtn = [[UIButton alloc] init];
        [self.view addSubview:self.gestureBtn];
        ViewBorder(self.gestureBtn, 2, [UIColor grayColor], 5);
        [self.gestureBtn setTitle:@"手势密码设置" forState:UIControlStateNormal];
        [self.gestureBtn addTarget:self action:@selector(clickGesture) forControlEvents:UIControlEventTouchUpInside];
        
        [self.gestureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(weakSelf.view);
            make.width.mas_equalTo(weakSelf.loginBtn.mas_width);
            make.top.mas_equalTo(weakSelf.loginBtn.mas_bottom).offset(5);
            make.height.mas_equalTo(weakSelf.loginBtn.mas_height);
        }];
    }
}
#pragma mark -- 点击事件
- (void)clickLoginBtn {
    OCMLog(@"点击了登录");
    id app = [UIApplication sharedApplication].delegate;
    [app showSplitView];
    return;
    
    if ([self.accountField.text isEqualToString:@"zhangsan"]) {
        if ([self.pwdField.text isEqualToString:@"123"]) {
            [self.view makeToastActivity:CSToastPositionCenter];
            dispatch_time_t delayT = GCD_delayT(2);
            dispatch_after(delayT, dispatch_get_main_queue(), ^{
                [self.view hideToastActivity];
                [self loginSuccess];
            });
        } else {
            [self.view makeToast:@"密码错误" duration:2.0 position:CSToastPositionBottom title:@"登录失败" image:[UIImage createImageWithColor:[UIColor redColor]] style:nil completion:^(BOOL didTap) {
                nil;
            }];
            
        }
    } else {
        [self.view makeToast:@"账号错误" duration:2.0 position:CSToastPositionBottom];
    }
}
- (void)clickGesture {
    OCMLog(@"clickGesture");
//    GestureLoginViewController *gesVC = [[GestureLoginViewController alloc] init];
//    [self presentViewController:gesVC animated:YES completion:nil];
    MessageLoginViewController *msgVC = [[MessageLoginViewController alloc] init];
    [msgVC setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    [self presentViewController:msgVC animated:YES completion:nil];
}
- (void)loginSuccess {
    OCMLog(@"登录成功");
    //清空设置
//    [_keyWrapper resetKeychainItem];
    KeychainItemWrapper *keyWrapper = [[KeychainItemWrapper alloc] initWithIdentifier:LoginWrapper accessGroup:nil];
    [keyWrapper setObject:self.accountField.text forKey:(__bridge id)kSecAttrAccount];
    [keyWrapper setObject:self.pwdField.text forKey:(__bridge id)kSecValueData];
    [self saveToken];
    //跳转
    id app = [UIApplication sharedApplication].delegate;
    [app showSplitView];
}
- (void)saveToken {
    NSMutableString *mutableName = [[NSMutableString alloc] initWithString:self.accountField.text];
    [mutableName insertString:@"a" atIndex:0];//加3次盐
    [mutableName insertString:@"z" atIndex:mutableName.length / 2];
    [mutableName insertString:@"0" atIndex:mutableName.length];
    NSMutableString *mutablePWD = [[NSMutableString alloc] initWithString:self.pwdField.text];
    [mutablePWD insertString:@"0" atIndex:0];//加3次盐
    [mutablePWD insertString:@"9" atIndex:mutablePWD.length / 2];
    [mutablePWD insertString:@"a" atIndex:mutablePWD.length];
    NSString *baseName = [mutableName base64EncodedString];
    NSString *basePWD = [mutablePWD base64EncodedString];
    NSString *nameMD5 = [baseName MD5]; //账号不md5加密
    NSString *pwdMD5 = [basePWD MD5];
    OCMLog(@"salt_name-->%@\nsalt_pwd-->%@\nbaseName-->%@\nbasePWD-->%@\nnameMD5-->%@\npwdMD5-->%@", mutableName,mutablePWD,baseName,basePWD,nameMD5,pwdMD5);
    //发送加密后的账号密码-->服务器;
    //服务器返回了一个token
    NSString *token = @"token";
    //保存token到本地沙盒
    [YDConfigurationHelper setStringValueForConfigurationKey:TOKEN withValue:token];
}
- (void)clickLoginType:(UIButton *)sender {
    if (sender.tag == UserLoginModeByNormal) {
        [_leftBtn setImage:[UIImage imageNamed:@"RadioSelectImage"] forState:UIControlStateNormal];
        [_rightBtn setImage:[UIImage imageNamed:@"RadioUnselectImage"] forState:UIControlStateNormal];
        OCMLog(@"普通登录");
    } else if (sender.tag == UserLoginModeBySMS){
        [_rightBtn setImage:[UIImage imageNamed:@"RadioSelectImage"] forState:UIControlStateNormal];
        [_leftBtn setImage:[UIImage imageNamed:@"RadioUnselectImage"] forState:UIControlStateNormal];
        OCMLog(@"短信登录");
    }
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
