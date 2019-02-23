//
//  OCMFromRightViewController.h
//  OCM
//
//  Created by 曹均华 on 2018/2/9.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OCMFromRightViewController : UIViewController
//第一部分view
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic, strong) UIImageView *starImg;
@property (nonatomic, assign) NSInteger stars;
@property (nonatomic, strong) UIButton *dismissBtn;
//第二部分
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) NSInteger imgCounts;


/**
 展示更多信息按钮
 */
@property (nonatomic, strong) UIButton *moreDetailBtn;
//请求参数
@property (nonatomic, copy) NSString *QDid;

@end
