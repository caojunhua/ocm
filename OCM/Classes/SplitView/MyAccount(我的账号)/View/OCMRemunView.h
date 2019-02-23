//
//  OCMRemunView.h
//  OCM
//
//  Created by 曹均华 on 2017/12/28.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^selectedCur)(NSInteger cur);
@interface OCMRemunView : UIView
@property (nonatomic,strong)UIView *upView;
@property (nonatomic,strong)UIView *topView;
@property (nonatomic,strong)UILabel *titleL;
@property (nonatomic,strong)UIButton *leftArrBtn;
@property (nonatomic,strong)UIScrollView *yearsScrollV;
@property (nonatomic,strong)UIButton *rightArrBtn;

@property (nonatomic,strong)UIView *midView;
@property (nonatomic,strong)UIButton *showAllLineBtn;
@property (nonatomic,strong)UIView *linesView;
@property (nonatomic,strong)UIView *XAxisNamesView;


@property (nonatomic,strong)UIView *downView;
- (void)reAddLinesView;
@end
