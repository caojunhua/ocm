//
//  OCMLeftBottomViewController.h
//  OCM
//
//  Created by 曹均华 on 2017/12/19.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^swipeUpOrDown)(BOOL isUp);
@interface OCMLeftBottomViewController : UIViewController
@property (nonatomic,copy)swipeUpOrDown swipeUpOrDown;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIImageView *imgV;
@end
