//
//  OCMCheckHeaderView.h
//  OCM
//
//  Created by 曹均华 on 2018/5/15.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OCMCheckWorkItem,OCMCalendarItem;
@interface OCMCheckHeaderView : UIView
@property (nonatomic, strong) UILabel               *dateL;
@property (nonatomic, strong) UILabel               *arrangeL;
@property (nonatomic, strong) UILabel               *timeL;
@property (nonatomic, strong) UILabel               *circleL;
@property (nonatomic, strong) UILabel               *beginTimeL;
@property (nonatomic, strong) UILabel               *stateL;
@property (nonatomic, strong) UIImageView           *imgV;

@property (nonatomic, strong) OCMCheckWorkItem      *item;
@property (nonatomic, strong) OCMCalendarItem       *calendarItem;
@property (nonatomic, assign) BOOL                  isUp;
@end
