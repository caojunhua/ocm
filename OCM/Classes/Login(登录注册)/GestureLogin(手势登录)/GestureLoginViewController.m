//
//  GestureLoginViewController.m
//  OCM
//
//  Created by 曹均华 on 2017/12/12.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import "GestureLoginViewController.h"
#import <DBGuestureLock/DBGuestureLock.h>
#import "AppDelegate.h"
#import "UIView+Toast.h"

@interface GestureLoginViewController ()<UITextFieldDelegate>
@property (nonatomic,strong)UIView *bgView;
@property (nonatomic,strong)UILabel *label;
@property (nonatomic,strong) DBGuestureLock *lock;

@property (nonatomic, strong) UIImageView *logoView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UITextField *pwdField;
@property (nonatomic, strong) UIAlertController *alertC;
@end

@implementation GestureLoginViewController
+ (instancetype)sharedInstance {
    static GestureLoginViewController *_gestureVC = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _gestureVC = [[GestureLoginViewController alloc] init];
    });
    return _gestureVC;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imgV.image = ImageIs(@"login_bg");
    [self.view addSubview:imgV];
    [self setAlert];
    [self setUpUI];
}
- (void)setAlert {
    __weak typeof(self) weakSelf = self;
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"重设手势" message:nil preferredStyle:UIAlertControllerStyleAlert];
    _alertC = alertC;
    [alertC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入账号的密码";
    }];
    _pwdField = alertC.textFields.firstObject;
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        __strong typeof(self) theSelf = weakSelf;
//        [theSelf dismiss];
        [weakSelf dismiss];
    }];
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        __strong typeof(self) theSelf = weakSelf;
        [theSelf matchPwd];
    }];
    [alertC addAction:cancelAction];
    [alertC addAction:OKAction];
}
- (void)setUpUI {
    __weak typeof(self) weakSelf = self;
    {
        self.label = [[UILabel alloc] init];
        _label.height = 50;
        _label.width = 300;
        CGRect rect = _label.frame;
        rect.origin.y = 50;
        rect.origin.x = self.view.width * 0.5 - 25;
        _label.frame = rect;
        [self.view addSubview:_label];
        _label.backgroundColor = [UIColor redColor];
        _label.hidden = YES;
    }
    {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(screenWidth * 0.5 - 200, screenHeight - 500 - 50, 400, 400)];
        [self.view addSubview:_bgView];
    }
    {
        _resetBtn = [[UIButton alloc] init];
        [_resetBtn setTitle:@"重设手势" forState:UIControlStateNormal];
        [self.view addSubview:_resetBtn];
        [_resetBtn addTarget:self action:@selector(resetGes) forControlEvents:UIControlEventTouchUpInside];
        [_resetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(110, 50));
            make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
            make.bottom.mas_equalTo(weakSelf.view.mas_bottom).offset(-70);
        }];
        _resetBtn.hidden = YES;
        [_resetBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    }
    {
        UIButton *switchBtn = [[UIButton alloc] init];
        _btn = switchBtn;
        [self.view addSubview:switchBtn];
        [switchBtn setTitle:@"切换到指纹解锁" forState:UIControlStateNormal];
        [switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(110, 20));
            make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
            make.bottom.mas_equalTo(weakSelf.view.mas_bottom).offset(-70);
        }];
        [switchBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [switchBtn setTintColor:[UIColor whiteColor]];
        [switchBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        _btn.hidden = YES;
    }
    {
//        _cancelBtn = [[UIButton alloc] init];
//        [self.view addSubview:_cancelBtn];
//        [_cancelBtn setTitle:@"我不设置了~" forState:UIControlStateNormal];
//        [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.size.mas_equalTo(CGSizeMake(110, 50));
//            make.centerX.mas_equalTo(weakSelf.view.mas_centerX).offset(-150);
//            make.bottom.mas_equalTo(weakSelf.view.mas_bottom).offset(-70);
//        }];
//        [_cancelBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    {
        self.logoView = [[UIImageView alloc] init];
        [self.view addSubview:self.logoView];
        
        self.nameLabel = [[UILabel alloc] init];
        [self.view addSubview:self.nameLabel];
        
        __weak typeof(self) weakSelf = self;
        [self.logoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(100);
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
    }
    [self setGesture];
}
- (void)resetGes {
    [self checkPwd];
}
- (void)checkPwd {
    OCMLog(@"checkPwd");
    [self presentViewController:_alertC animated:YES completion:nil];
}
- (void)matchPwd {
    NSString *str = _pwdField.text;
    OCMLog(@"输入的str--%@", str);
    if ([str isEqualToString:@"abc"]) {
        [DBGuestureLock clearGuestureLockPassword]; //密码正确 清空除原来的手势
        // 开始输入新手势
        [self setGesture];
    } else {
        //密码错误
    }
}
- (void)setGesture {
    [self.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[DBGuestureLock class]]) {
            [obj removeFromSuperview];
        }
    }];
    __weak typeof(self) weakSelf = self;
    DBGuestureLock *lock = [DBGuestureLock lockOnView:self.bgView onPasswordSet:^(DBGuestureLock *lock, NSString *password) {
        if (password.length < 4) {
            OCMLog(@"长度小于4");
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:weakSelf.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text = @"长度小于4个";
            dispatch_time_t delayT = GCD_delayT(1);
            dispatch_after(delayT, dispatch_get_main_queue(), ^{
                [hud hideAnimated:YES];
            });
            [DBGuestureLock clearGuestureLockPassword];
        } else {
            if (lock.firstTimeSetupPassword == nil && password.length >= 4) { //第一次为空
//                OCMLog(@"第一次为空");
                lock.firstTimeSetupPassword = password;
//                weakSelf.label.text = @"enter your password again";
                [weakSelf.view makeToast:@"请再输入一次手势" duration:1.5 position:@"center"];
            }
        }
    } onGetCorrectPswd:^(DBGuestureLock *lock, NSString *password) {//
        if (lock.firstTimeSetupPassword && ![lock.firstTimeSetupPassword isEqualToString:DBFirstTimeSetupPassword]) {
            lock.firstTimeSetupPassword = DBFirstTimeSetupPassword;
//            weakSelf.label.text = @"password has been setup";
            [weakSelf.view makeToast:@"新手势设置成功" duration:1.5 position:@"center"];
        } else {
            OCMLog(@"登录成功");
            weakSelf.label.text = @"login success";
            __strong typeof(self) theSelf = weakSelf;
            [theSelf successLogin];
        }
    } onGetIncorrectPswd:^(DBGuestureLock *lock, NSString *password) {
        if (![lock.firstTimeSetupPassword isEqualToString:DBFirstTimeSetupPassword]) {
            weakSelf.label.text = @"Not equal to first setup!";
        } else {
            //登录失败
            weakSelf.label.text = @"login failed";
        }
    }];
    [self.bgView addSubview:lock];
    _lock = lock;
    lock.frame = self.bgView.bounds;
    self.bgView.backgroundColor = [UIColor clearColor];
}
- (void)successLogin {
    id app = [UIApplication sharedApplication].delegate;
    [app showSplitView];
}
- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)dismiss1 {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
- (void)dealloc {
    OCMLog(@"GestureLoginViewController.h--Dealloc");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)shouldAutorotate {
    return YES;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
}
@end
