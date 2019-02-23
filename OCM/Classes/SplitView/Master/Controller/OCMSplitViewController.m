//
//  OCMSplitViewController.m
//  OCM
//
//  Created by 曹均华 on 2017/11/30.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import "OCMSplitViewController.h"
#import "OCMLeftBaseNavigationController.h"
#import "OCMMasterViewController.h"

@interface OCMSplitViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) OCMLeftBaseNavigationController *masterVC;
@property (nonatomic, strong) OCMMasterViewController *rootVC;
@property (nonatomic, strong) UISwipeGestureRecognizer *swipGes;
@end

@implementation OCMSplitViewController
- (instancetype)init {
    if (self == [super init]) {
        _rootVC = [[OCMMasterViewController alloc] init];
        _masterVC = [[OCMLeftBaseNavigationController alloc] initWithRootViewController:_rootVC];
        [self addChildViewController:_masterVC];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpLayout];
    [self setNotification];
}
- (void)setNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(masterViewClikcLeftBtn) name:NclickLeftBtn object:nil];
}
- (void)setUpLayout {
    self.maximumPrimaryColumnWidth = kLeftBigWidth;
    _rootVC.leftWidth = kLeftBigWidth;
//    self.preferredDisplayMode = UISplitViewControllerDisplayModePrimaryOverlay;
    _swipGes = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipGes:)];
    _swipGes.direction = UISwipeGestureRecognizerDirectionRight; //向右轻扫
    [self.view addGestureRecognizer:_swipGes];
    _swipGes = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipGes:)];
    _swipGes.direction = UISwipeGestureRecognizerDirectionLeft;//向左轻扫
    [self.view addGestureRecognizer:_swipGes];
    [self addObserver:self forKeyPath:@"maximumPrimaryColumnWidth" options:NSKeyValueObservingOptionNew context:nil];//监听
}
- (void)swipGes:(UISwipeGestureRecognizer *)sender {
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft ) {//3
        OCMLog(@"向左轻扫");
//        [self addTransitiontype:kCATransitionFade direction:(NSString *)kCATransitionFromRight time:0.3f toView:self.view forKey:@"fadeRightAnimation"];
        self.maximumPrimaryColumnWidth = kLeftSmallWidth;
    } else if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
//        [self addTransitiontype:kCATransitionFade direction:(NSString *)kCATransitionFromLeft time:0.3f toView:self.view forKey:@"fadeRightAnimation"];
        self.maximumPrimaryColumnWidth = kLeftBigWidth;
        OCMLog(@"向右轻扫");
    }
}
- (void)masterViewClikcLeftBtn {
    if (self.maximumPrimaryColumnWidth == kLeftSmallWidth) { //fade效果
//        [self addTransitiontype:kCATransitionFade direction:(NSString *)kCATransitionFromLeft time:0.3f toView:self.view forKey:@"fadeRightAnimation"];
        self.maximumPrimaryColumnWidth = kLeftBigWidth;
    } else {
//        [self addTransitiontype:kCATransitionFade direction:(NSString *)kCATransitionFromRight time:0.3f toView:self.view forKey:@"fadeRightAnimation"];
        self.maximumPrimaryColumnWidth = kLeftSmallWidth;
    }
}
- (void)addTransitiontype:(NSString *)transitionType direction:(NSString *)directionType time:(CGFloat)durationTime toView:(UIView *)view forKey:(NSString *)tranKey{
    CATransition *anima = [CATransition animation];
    anima.type = transitionType;//设置动画的类型
    anima.subtype = directionType; //设置动画的方向
    anima.duration = durationTime;
    [view.layer addAnimation:anima forKey:tranKey];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"maximumPrimaryColumnWidth"]) {
        if (self.maximumPrimaryColumnWidth == kLeftSmallWidth) {
            OCMLog(@"监听到宽度为50");
            _rootVC.leftWidth = 50;
            [[NSNotificationCenter defaultCenter] postNotificationName:NswipeLeftGes object:nil];
        } else if (self.maximumPrimaryColumnWidth == kLeftBigWidth) {
            OCMLog(@"监听到宽度为200");
            _rootVC.leftWidth = kLeftBigWidth;
            [[NSNotificationCenter defaultCenter] postNotificationName:NswipeRightGes object:nil];
        }
    }
}
- (BOOL)shouldAutorotate {
    return YES;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
}
#pragma mark -- delloc
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self removeObserver:self forKeyPath:@"maximumPrimaryColumnWidth"];
    OCMLog(@"销毁了SplitViewController");
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
