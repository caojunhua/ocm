//
//  OCMAttendanceViewController.m
//  OCM
//
//  Created by 曹均华 on 2018/4/12.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "OCMAttendanceViewController.h"
#import "OCMCalendarCollectionViewCell.h"
#import "OCMCalendarHeaderView.h"
#import "OCMCalendarItem.h"
#import "OCMPresentFormSheetViewController.h"
#import "OCMCheckViewController.h"
#import "OCMArrangeNavViewController.h"

@interface OCMAttendanceViewController ()
@property (nonatomic, strong) OCMPresentFormSheetViewController *presentNav;
@property (nonatomic, strong) OCMCheckViewController            *checkVC;
//@property (nonatomic, strong) OCMArrangeNavViewController       *navi;
@end

@implementation OCMAttendanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];  //考勤
    self.view.backgroundColor = [UIColor greenColor];
    
    
}
#pragma mark -- 加载后修改显示状态
- (void)setOtherStyle:(OCMCalendarCollectionViewCell *)item indexP:(NSIndexPath *)indexPath {
//    [self.collectionView setContentOffset:CGPointMake(0, self.offSetY)];
    item.calendarItem.textColor = arc4random() % 4;
    [item configFirstStylewithItem];
    
}
- (void)setHeadSubviewHidden {
    self.headerV.arrangeBtn.hidden     = YES;
    self.headerV.selectShiftBtn.hidden = YES;
    [self.headerV.reportBtn addTarget:self action:@selector(clickReportBtn) forControlEvents:UIControlEventTouchUpInside];
}
- (void)clickReportBtn {
    if (self.selectedItem) {
        _checkVC = [[OCMCheckViewController alloc] init];
        _presentNav = [[OCMPresentFormSheetViewController alloc] initWithRootViewController:_checkVC];
        _presentNav.modalPresentationStyle = UIModalPresentationFormSheet;
        _presentNav.modalTransitionStyle   = UIModalTransitionStyleFlipHorizontal;
        _presentNav.preferredContentSize   = CGSizeMake(400, 400);
        [self presentViewController:_presentNav animated:YES completion:nil];
        
        __weak typeof(self) weakSelf              = self;
        self.checkVC.dismissBlock                 = ^{
            typeof(weakSelf) theSelf              = weakSelf;
            theSelf.checkVC                       = nil;
            theSelf.presentNav                    = nil;
        };
    } else {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode           = MBProgressHUDModeText;
        hud.label.text     = @"请选择日期";
        [hud hideAnimated:YES afterDelay:1];
    }
}
#pragma mark -- dealloc
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
