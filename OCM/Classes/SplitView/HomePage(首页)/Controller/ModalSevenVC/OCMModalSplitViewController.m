//
//  OCMModalSplitViewController.m
//  OCM
//
//  Created by 曹均华 on 2018/3/15.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "OCMModalSplitViewController.h"
#import "OCMLeftBaseNavigationController.h"
#import "ModalRightBaseViewController.h"
#import "OCMMasterTableViewCell.h"
//右侧控制器
#import "OCMDetailNetViewController.h"
#import "ModalSecondViewController.h"
#import "ModalThirdViewController.h"
#import "ModalFourthViewController.h"
#import "ModalFifthViewController.h"
#import "ModalSixthViewController.h"
#import "ModalSeventhViewController.h"

#import "OCMRightBaseNavigationViewController.h"
#import "OCMBaseRightViewController.h"

@interface OCMModalSplitViewController ()
@property (nonatomic, strong) OCMLeftBaseNavigationController *masterVC;
@property (nonatomic, strong) ModalRightBaseViewController *rightBaseVC;
@end

@implementation OCMModalSplitViewController

- (instancetype)init {
    if (self = [super init]) {
        _rightBaseVC = [[ModalRightBaseViewController alloc] init];
        _masterVC = [[OCMLeftBaseNavigationController alloc] initWithRootViewController:_rightBaseVC];
        [self addChildViewController:_masterVC];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.maximumPrimaryColumnWidth = kLeftBigWidth;
    _rightBaseVC.selectIndex = self.selectIndex;
}
- (BOOL)shouldAutorotate {
    return YES;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
}
@end
