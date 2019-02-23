//
//  FingerLockViewController.m
//  OCM
//
//  Created by 曹均华 on 2018/1/23.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "FingerLockViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "AppDelegate.h"
#import "UIView+Toast.h"
#import "GestureLoginViewController.h"

@interface FingerLockViewController ()
@property (nonatomic, strong) GestureLoginViewController *gesVC;
@property (nonatomic, strong) UIImageView *logoView;
@property (nonatomic, strong) UILabel *nameLabel;
@end

@implementation FingerLockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
//    [self setFingerPrint];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setFingerPrint];
}
- (void)initUI {
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imgV.image = ImageIs(@"login_bg");
    [self.view addSubview:imgV];
    
    self.logoView = [[UIImageView alloc] init];
    [self.view addSubview:self.logoView];
    
    self.nameLabel = [[UILabel alloc] init];
    [self.view addSubview:self.nameLabel];
    
    UIButton *switchBtn = [[UIButton alloc] init];
    [self.view addSubview:switchBtn];
    [switchBtn setTitle:@"切换到手势解锁" forState:UIControlStateNormal];
    __weak typeof(self) weakSelf = self;
    [switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(110, 20));
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.bottom.mas_equalTo(weakSelf.view.mas_bottom).offset(-70);
    }];
    [switchBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [switchBtn setTintColor:[UIColor whiteColor]];
    [switchBtn addTarget:self action:@selector(useGesture) forControlEvents:UIControlEventTouchUpInside];
    
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
- (void)useGesture {
    if (_gesVC == nil) {
        GestureLoginViewController *gesVC = [[GestureLoginViewController alloc] init];
        _gesVC = gesVC;
    }
//    _gesVC = [GestureLoginViewController sharedInstance];
    [_gesVC setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
//    [self presentViewController:_gesVC animated:YES completion:nil];
    [self presentViewController:_gesVC animated:YES completion:^{
        _gesVC.btn.hidden = NO;
    }];
}
- (void)setFingerPrint {
    __weak typeof(self) weakSelf = self;
    LAContext *context = [[LAContext alloc] init];
    context.localizedFallbackTitle = @"忘记密码?";
    NSError *error = nil;
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"请按home指纹解锁" reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                NSLog(@"验证成功,刷新主界面");
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.view makeToast:@"解锁成功"];
                    [weakSelf success];
                });
            } else {
                NSLog(@"%@",[error debugDescription]);
                switch (error.code) {
                    case LAErrorSystemCancel:
                        NSLog(@"LAErrorSystemCancel");
                        break;
                    case LAErrorUserCancel: //点击了取消
                        NSLog(@"LAErrorSystemCancel");
                    {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            __strong typeof(self) theSelf = weakSelf;
                            [theSelf useGesture];
                        });
                    }
                        break;
                    case LAErrorAuthenticationFailed:
                        NSLog(@"LAErrorAuthenticationFailed"); // 失败三次来到这里
                    {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            __strong typeof(self) theSelf = weakSelf;
                            [theSelf useGesture];
                        });
                    }
                        break;
                    case LAErrorPasscodeNotSet:
                        NSLog(@"LAErrorPasscodeNotSet");
                    {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [weakSelf.view makeToast:@"您还没设置指纹密码"];
                        });
                    }
                        
                        break;
                    case LAErrorTouchIDNotAvailable:
                        NSLog(@"LAErrorTouchIDNotAvailable");
                        break;
                    case LAErrorTouchIDNotEnrolled:
                        NSLog(@"LAErrorTouchIDNotEnrolled");
                        break;
                    case LAErrorUserFallback:
                        NSLog(@"LAErrorUserFallback");
                        break;
                    case kLAErrorTouchIDLockout:
                        OCMLog(@"kLAErrorTouchIDLockout");
                        break;
                    case kLAErrorAppCancel:
                        OCMLog(@"kLAErrorAppCancel");
                        break;
                    case kLAErrorInvalidContext:
                        OCMLog(@"kLAErrorInvalidContext");
                        break;
                    default:
                        NSLog(@"其他");
                        break;
                }
            }
        }];
    } else {
        NSLog(@"不支持指纹识别");
        switch (error.code) {
            case LAErrorTouchIDNotEnrolled:
            {
                NSLog(@"TouchID is not enrolled");
                break;
            }
            case LAErrorPasscodeNotSet:
            {
                NSLog(@"A passcode has not been set");
                break;
            }
                case kLAErrorTouchIDNotAvailable:
            {
                OCMLog(@"kLAErrorTouchIDNotAvailable");
            }
            case LAErrorSystemCancel:
                NSLog(@"LAErrorSystemCancel");
                break;
            case LAErrorUserCancel: //点击了取消
                NSLog(@"LAErrorSystemCancel");
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    __strong typeof(self) theSelf = weakSelf;
                    [theSelf useGesture];
                });
            }
                break;
            case LAErrorAuthenticationFailed:
                NSLog(@"LAErrorAuthenticationFailed"); // 失败三次来到这里
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    __strong typeof(self) theSelf = weakSelf;
                    [theSelf useGesture];
                });
            }
                break;
            case LAErrorUserFallback:
                NSLog(@"LAErrorUserFallback");
                break;
            case kLAErrorTouchIDLockout:
                OCMLog(@"kLAErrorTouchIDLockout");
            {
                dispatch_async(dispatch_get_main_queue(), ^{
//                    [weakSelf.view makeToast:@"指纹失败次数过多,Touch ID 已被锁定"];
                    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:weakSelf.view animated:YES];
                    hud.mode = MBProgressHUDModeText;
                    hud.label.text = @"指纹失败次数过多,Touch ID 已被锁定";
                    dispatch_time_t delayT = GCD_delayT(1.5);
                    dispatch_after(delayT, dispatch_get_main_queue(), ^{
                        [hud hideAnimated:YES];
                    });
                });
            }
                break;
            case kLAErrorAppCancel:
                OCMLog(@"kLAErrorAppCancel");
                break;
            case kLAErrorInvalidContext:
                OCMLog(@"kLAErrorInvalidContext");
                break;
            default:
            {
                NSLog(@"TouchID not available");
                break;
            }
        }
    }
}
- (void)success {
    id app = [UIApplication sharedApplication].delegate;
    [app showSplitView];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
