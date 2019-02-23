//
//  BaseFiltrationViewController.h
//  OCM
//
//  Created by 曹均华 on 2018/3/19.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^hiddenView)(NSMutableArray *arr);
@interface BaseFiltrationViewController : UIViewController
@property (nonatomic, copy) hiddenView hiddenBlock;
@property (nonatomic, strong) NSArray<NSString *> *titleArr;
@property (nonatomic, strong) UIButton *resetBtn;
@property (nonatomic, strong) UIButton *sureBtn;
@property (nonatomic, strong) NSMutableArray *seletedIndexArr;
@property (nonatomic, strong) UITableView *tableView;
- (void)initTitle;
@end
