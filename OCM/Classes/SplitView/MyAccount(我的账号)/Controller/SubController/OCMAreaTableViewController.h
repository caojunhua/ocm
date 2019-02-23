//
//  OCMAreaTableViewController.h
//  OCM
//
//  Created by 曹均华 on 2018/1/10.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^areaBlock)(NSString *areaStr);
@interface OCMAreaTableViewController : UITableViewController
@property (nonatomic,strong)NSArray *areaArr;//数据源
@property (nonatomic,copy)areaBlock areaBlock;
@end
