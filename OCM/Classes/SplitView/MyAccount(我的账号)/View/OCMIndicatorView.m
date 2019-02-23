//
//  OCMIndicatorView.m
//  OCM
//
//  Created by 曹均华 on 2018/1/2.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "OCMIndicatorView.h"
#import "WBPopOverView.h"
#import "CFDynamicLabel.h"

@implementation OCMIndicatorView
{
    NSLock *_lock;
}
static NSString *LookMine = @"lookMineBtnIsSelected";
- (instancetype)initWithData:(NSArray<NSArray *> *)dataArr frame:(CGRect)frame teamsViewNameArr:(NSArray *)teamsArr myData:(NSDictionary *)myPerformance {
    self.dataArrs = dataArr;
    self.teamsNameArr = teamsArr;
    self.myPerformance = myPerformance;
    self->_lock = [NSLock new];
    return [self initWithFrame:frame];
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame: frame]) {
        [_lock lock];
        [self setUpView];
        [_lock unlock];
        [self strokePath];
    }
    return self;
}
- (void)setUpView {
    __weak typeof(self) weakSelf = self;
    /*--------topV----------*/
    CGFloat topH = 50;
    self.topV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, topH)];
    self.topV.backgroundColor = [UIColor colorWithHexString:@"#f9f9f9"];
    ViewBorder(self.topV, 1, [UIColor colorWithHexString:@"cccccc"], 0);
    [self addSubview:self.topV];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"指标名称:新增用户有效数";
    label.textColor = [UIColor colorWithHexString:@"#666666"];
    label.font = [UIFont systemFontOfSize:15];
    [self.topV addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.topV);
        make.left.mas_equalTo(weakSelf.topV).offset(17);
    }];
    
    UIButton *lookMineBtn = [[UIButton alloc] init];
    _lookMineBtn = lookMineBtn;
    lookMineBtn.selected = [YDConfigurationHelper getBoolValueForConfigurationKey:LookMine];
    lookMineBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [lookMineBtn setTitle:@"查看我的" forState:UIControlStateNormal];
    [lookMineBtn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    [lookMineBtn setImage:ImageIs(@"icon_inforeward_rb_select") forState:UIControlStateSelected];
    [lookMineBtn setImage:ImageIs(@"icon_inforeward_rb") forState:UIControlStateNormal];
    [lookMineBtn addTarget:self action:@selector(clickLookMineBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.topV addSubview:lookMineBtn];
    [lookMineBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.topV);
        make.right.mas_equalTo(weakSelf.topV.mas_right).offset(-17);
        make.width.mas_equalTo(130);
        make.height.mas_equalTo(25);
    }];
    /*--------topV----------*/
    
    /*--------midV----------*/
    CGFloat midH = 530;
    self.midV = [[UIView alloc] init];
    [self addSubview:self.midV];
    [self.midV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(weakSelf.width);
        make.height.mas_equalTo(midH);
        make.left.mas_equalTo(weakSelf);
        make.top.mas_equalTo(weakSelf.topV.mas_bottom).offset(-1);
    }];
    ViewBorder(self.midV, 1, [UIColor colorWithHexString:@"cccccc"], 0);
    //筛选条件一行
    
    CGFloat conditonH = 50;
    UIView *conditonV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, conditonH)];//筛选条件
    [self.midV addSubview:conditonV];
    //所有任务按钮
    _btnTask = [[UIButton alloc] init];
    self.taskLabel = [[CFDynamicLabel alloc] initWithFrame:CGRectMake(15, 8, 50, 20)];
    [_btnTask addSubview:self.taskLabel];
    self.taskLabel.speed = 0.9;
    self.taskLabel.textColor = [UIColor colorWithHexString:@"#009dec"];
    self.taskLabel.font = [UIFont systemFontOfSize:14];
    self.taskLabel.backgroundColor = [UIColor clearColor];
    [conditonV addSubview:_btnTask];
    [_btnTask mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(conditonV);
        make.right.mas_equalTo(conditonV.mas_right).offset(-18);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(32);
    }];
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(65, 1, 30, 30)];
    imgV.image = ImageIs(@"xiala");
    [_btnTask addSubview:imgV];
    ViewBorder(_btnTask, 1, [UIColor colorWithHexString:@"#cccccc"], 5);
    //所有片区按钮
    _btnArea = [[UIButton alloc] init];
    self.areaLabel = [[CFDynamicLabel alloc] initWithFrame:CGRectMake(15, 8, 50, 20)];
    [_btnArea addSubview:self.areaLabel];
    self.areaLabel.speed = 0.9;
    self.areaLabel.textColor = [UIColor colorWithHexString:@"#009dec"];
    self.areaLabel.font = [UIFont systemFontOfSize:14];
    self.areaLabel.backgroundColor = [UIColor clearColor];
    [conditonV addSubview:_btnArea];
    [_btnArea mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(conditonV);
        make.right.mas_equalTo(weakSelf.btnTask.mas_left).offset(-18);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(32);
    }];
    UIImageView *imgV1 = [[UIImageView alloc] initWithFrame:CGRectMake(65, 1, 30, 30)];
    imgV1.image = ImageIs(@"xiala");
    [_btnArea addSubview:imgV1];
    ViewBorder(_btnArea, 1, [UIColor colorWithHexString:@"#cccccc"], 5);
    //筛选条件
    UILabel *labelScr = [[UILabel alloc] init];
    labelScr.text = @"筛选条件 :";
    labelScr.textColor = [UIColor colorWithHexString:@"#666666"];
    labelScr.font = [UIFont systemFontOfSize:15];
    [conditonV addSubview:labelScr];
    [labelScr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(conditonV);
        make.right.mas_equalTo(weakSelf.btnArea.mas_left).offset(-18);
    }];

    //中间柱状图

    __block CGFloat barH = 400;
    UIView *barsView = [[UIView alloc] init];
    [self.midV addSubview:barsView];
    [barsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(weakSelf.width);
        make.height.mas_equalTo(barH);
        make.left.mas_equalTo(weakSelf.midV);
        make.top.mas_equalTo(conditonV.mas_bottom).offset(30);
    }];
    //x轴上的百分数
    CGFloat detalH = 400 * 0.1;
    NSInteger y = 10;
    for (int i = 0; i < 11; i++) {
        UILabel *labelPer = [[UILabel alloc] initWithFrame:CGRectMake(0, 400 - i * detalH - 12.5, 50, 25)];
        NSString *perStr = [[@"-" stringByAppendingString:[NSString stringWithFormat:@"%ld",i * y]] stringByAppendingString:@"%"];
        labelPer.text = perStr;
        labelPer.font = [UIFont systemFontOfSize:15];
        labelPer.textColor = [UIColor colorWithHexString:@"#999999"];
        [barsView addSubview:labelPer];
    }
    
    //显示柱状图的scrollV
    self.barScrollV = [[UIScrollView alloc] init];
//    self.barScrollV.backgroundColor = [UIColor lightGrayColor];
    self.barScrollV.showsHorizontalScrollIndicator = NO;
    NSArray *tempArr = self.dataArrs[0];
    [barsView addSubview:self.barScrollV];
    [self.barScrollV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(barsView).offset(-50);
        make.left.mas_equalTo(38);
        make.bottom.mas_equalTo(weakSelf.midV.mas_bottom);
        make.right.mas_equalTo(barsView.mas_right).offset(-54);
    }];
    CGSize size = CGSizeMake(tempArr.count * 115 + 56, self.barScrollV.height);
    self.barScrollV.contentSize = size;
    //向左<--  和   向右--> 按钮
    self.leftBtn = [[UIButton alloc] init];
    self.leftBtn.backgroundColor = [UIColor colorWithHexString:@"#f9f9f9"];
    [self.midV addSubview:self.leftBtn];
    [self.leftBtn setImage:ImageIs(@"icon_inforeward_left") forState:UIControlStateNormal];
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.midV);
        make.bottom.mas_equalTo(weakSelf.midV.mas_bottom);
        make.right.mas_equalTo(weakSelf.barScrollV.mas_left);
        make.height.mas_equalTo(50);
    }];
    //补充被遮盖的0%
    UILabel *labelPer = [[UILabel alloc] initWithFrame:CGRectMake(0,- 12.5, 50, 25)];
    labelPer.text = @"-0%";
    labelPer.font = [UIFont systemFontOfSize:15];
    labelPer.textColor = [UIColor colorWithHexString:@"#999999"];
    [self.leftBtn addSubview:labelPer];
    self.rightBtn = [[UIButton alloc] init];
    self.rightBtn.backgroundColor= [UIColor colorWithHexString:@"#f9f9f9"];
    [self.midV addSubview:self.rightBtn];
    [self.rightBtn setImage:ImageIs(@"icon_inforeward_right") forState:UIControlStateNormal];
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.barScrollV.mas_right);
        make.right.mas_equalTo(weakSelf.midV.mas_right);
        make.bottom.mas_equalTo(weakSelf.midV.mas_bottom);
        make.height.mas_equalTo(50);
    }];
    
    /*--------midV----------*/
    
    /*--------bottomV----------*/

    self.bottomV = [[UIView alloc] init];
    [self addSubview:self.bottomV];
    [self.bottomV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(weakSelf.width);
        make.top.mas_equalTo(weakSelf.midV.mas_bottom);
        make.bottom.mas_equalTo(weakSelf.mas_bottom);
        make.left.mas_equalTo(weakSelf);
    }];
    NSArray *titleArr = @[@"组完成量",@"指标值",@"挑战值",@"个人完成量"];
    NSArray *colorArr = @[[UIColor colorWithHexString:@"#ff8fca"],[UIColor colorWithHexString:@"#71a0fc"],[UIColor colorWithHexString:@"94e6fe"],[UIColor colorWithHexString:@"#fcbb55"]];
    CGFloat btnW = 120;
    CGFloat btnH = 17;
    CGFloat dis = 35;
    for (int i = 0; i < 4; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((btnW + dis) * i, 16, btnW, btnH)];
        [self.bottomV addSubview:btn];
        btn.userInteractionEnabled = NO;
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, btnH, btnH)];
        imgV.image = [UIImage createImageWithColor:(UIColor *)colorArr[i]];
        [btn addSubview:imgV];
        [btn setTitle:(NSString *)titleArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        if (i == 0) {
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
        }
        if (i == 3) {
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, 23, 0, 0);
        }
    }
    // 说明
    UILabel *explainL = [[UILabel alloc] init];
    [self addSubview:explainL];
    explainL.text = @"说明 : 班组前的数字为全市排名,班组按照全市排名进行排序";
    explainL.textColor = [UIColor colorWithHexString:@"#999999"];
    explainL.font = [UIFont systemFontOfSize:15];
    [explainL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.midV.mas_left);
        make.top.mas_equalTo(weakSelf.midV.mas_bottom).offset(48);
    }];
    /*--------bottomV----------*/
}
#pragma mark -- strokePath

- (CGFloat)maxV {
    if (!_maxV) {
        CGFloat a = 0.0,b = 0.0,c = 0.0;
        for (int i = 0; i < self.dataArrs.count; i++) {
            NSArray *subArr = (NSArray *)self.dataArrs[i];
            switch (i) {
                case 0:
                    a = [[subArr valueForKeyPath:@"@max.floatValue"] floatValue];
                    break;
                case 1:
                    b = [[subArr valueForKeyPath:@"@max.floatValue"] floatValue];
                    break;
                case 2:
                    c = [[subArr valueForKeyPath:@"@max.floatValue"] floatValue];
                    break;
                default:
                    break;
            }
        }
        _maxV = (a>b?(a>c?a:c):(b>c?b:c));
    }
    return _maxV;
}
- (void)strokeBars {
    CGFloat barW = 30;
    CGFloat disX = 25;
    NSArray *colorArr = @[[UIColor colorWithHexString:@"#ff8fca"],[UIColor colorWithHexString:@"#71a0fc"],[UIColor colorWithHexString:@"#94e6fe"]];
    for (int i = 0; i < self.dataArrs.count; i++) {
        NSArray *subArr = (NSArray *)self.dataArrs[i];
        for (int j = 0; j < subArr.count; j++) {
            CGFloat h = [subArr[j] floatValue];
            CGFloat x = (3*barW + disX)*j + i *barW;
            CGFloat y = 400*(1 - (h / self.maxV)); // 柱状的-->上限值高度
            CGFloat w = barW;
            CGRect rect = CGRectMake(x, y + 50, w, h/self.maxV * 400);
            UIColor *color = (UIColor *)colorArr[i];
            [self.barScrollV.layer addSublayer:[self shapeLayer:rect color:color]];
        }
    }
    //增加底部班组名字信息
    [self.barScrollV.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIView class]]) {
            [obj removeFromSuperview];
        }
    }];
    NSArray *tempArr = (NSArray *)self.dataArrs[0];
    self.teamNameView = [[UIView alloc] initWithFrame:CGRectMake(0, 400 + 50,(tempArr.count - 1) * 115 + 90 + 100, 50)];
    self.teamNameView.backgroundColor = [UIColor colorWithHexString:@"#f9f9f9"];
    [self.barScrollV addSubview:self.teamNameView];
    
    for (int i = 0; i < tempArr.count; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(115 * i, 0, 90, 50)];
        NSString *titleStr = [[NSString stringWithFormat:@"%02d.",i + 1] stringByAppendingString:self.teamsNameArr[i]];
        [btn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [btn setTitle:titleStr forState:UIControlStateNormal];
        [self.teamNameView addSubview:btn];
    }
    //增加我的业绩信息
    NSArray *keyArr = [self.myPerformance allKeys];
    NSString *nameStr = [keyArr firstObject]; // 键
    if ([self.teamsNameArr containsObject:nameStr]) {
        NSInteger index = [self.teamsNameArr indexOfObject:nameStr]; //索引
        CGFloat value = [[self.myPerformance objectForKey:nameStr] floatValue];
        CGFloat h = value;
        CGFloat x = 115 * index;
        CGFloat y = 400*(1 - (h / self.maxV)); // 柱状的-->上限值高度
        CGFloat w = 30;
        CGRect rect = CGRectMake(x, y + 50, w, h/self.maxV * 400);
        _mineLayer = [self shapeLayer:rect color:[UIColor colorWithHexString:@"fcbb55"]];
        [self.barScrollV.layer.sublayers enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj == _mineLayer) {
                [obj removeFromSuperlayer]; //如果有的话,先移除,防止内存泄露
            }
        }];
        [self.barScrollV.layer addSublayer:_mineLayer];
        if ([YDConfigurationHelper getBoolValueForConfigurationKey:LookMine]) {
            _mineLayer.hidden = NO;
        } else {
            _mineLayer.hidden = YES;
        }
        
        //增加底部选中条
        UIView *selView = [[UIView alloc] initWithFrame:CGRectMake(115 * index, 46, 90, 4)];
        selView.backgroundColor = [UIColor colorWithHexString:@"#009dec"];
        [self.teamNameView addSubview:selView];
        //增加我的业绩信息popView
        dispatch_time_t delayT = GCD_delayT(1);
        __weak typeof(self) weakSelf = self;
        dispatch_after(delayT, dispatch_get_main_queue(), ^{
            __strong typeof(self) theSelf = weakSelf;
            CGPoint point = CGPointMake(x + w * 0.5, y + 50);
            WBPopOverView *view = [[WBPopOverView alloc] initWithOrigin:point Width:70 Height:30 Direction:WBArrowDirectionDown2 onView:theSelf.barScrollV];
            theSelf.view = view;
            view.backView.backgroundColor = [UIColor colorWithHexString:@"#fcbb55"];
            view.backView.layer.cornerRadius = 5;
            UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 30)];
            lable.textAlignment = NSTextAlignmentCenter;
            lable.font = [UIFont systemFontOfSize:10];
            lable.text= [NSString stringWithFormat:@"%.0f",value];
            lable.textColor=[UIColor whiteColor];
            [view.backView addSubview:lable];
            [view popViewToView:theSelf.barScrollV];
            BOOL isSel = [YDConfigurationHelper getBoolValueForConfigurationKey:@"lookMineBtnIsSelected"];
            if (isSel) {
                view.hidden = NO;
                theSelf.mineLayer.hidden = NO;
            } else {
                view.hidden = YES;
                theSelf.mineLayer.hidden = YES;
            }
        });
    }
    for (int i = 0; i < self.dataArrs.count; i++) {
        NSArray *subArr = (NSArray *)self.dataArrs[i];
        for (int j = 0; j < subArr.count; j++) {
            CGFloat h = [subArr[j] floatValue];
            CGFloat x = (3*barW + disX)*j + i *barW;
            CGFloat y = 400*(1 - (h / self.maxV)); // 柱状的-->上限值高度
            UIColor *color = (UIColor *)colorArr[i];
            CGRect rect = CGRectMake(x, y - 20 + 50, barW, 20);
            [self addTextL:(CGRect)rect color:(UIColor *)color value:(CGFloat)h];
        }
    }
}
- (void)addTextL:(CGRect)rect color:(UIColor *)color value:(CGFloat)h{
    CGRect rect0 = rect;
    rect0.origin.y = 430;
    UILabel *label = [[UILabel alloc] initWithFrame:rect0];
    
    label.font = [UIFont systemFontOfSize:10];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = color;
    label.text = [NSString stringWithFormat:@"%.0f",h];
    [self.barScrollV addSubview:label];
    [UIView animateWithDuration:1.0 animations:^{
        label.frame = rect;
    } completion:^(BOOL finished) {
    }];
}
- (void)strokePath {
    [self removeAllLayer];
    [self strokeBars];
}
- (void)removeAllLayer {
    NSArray * sublayers = [NSArray arrayWithArray:self.barScrollV.layer.sublayers];
    for (CALayer * layer in sublayers) {
        [layer removeAllAnimations];
        [layer removeFromSuperlayer];
    }
}
- (CAShapeLayer *)shapeLayer:(CGRect)rect color:(UIColor *)color{
    CAShapeLayer * layer = [CAShapeLayer layer];
    layer.fillColor = color.CGColor;
    layer.lineCap = kCALineCapRound;
    layer.path = [self noFill:rect].CGPath;
    [layer addAnimation:[self animation:rect] forKey:nil];
    return layer;
}
- (UIBezierPath *)noFill:(CGRect)rect{
    CGRect rect0 = rect;
    rect0.origin.y = 400 + 50;
    rect0.size.height = 0;
    rect = rect0;
    UIBezierPath * bezier = [UIBezierPath bezierPathWithRect:rect];
    return bezier;
}
- (UIBezierPath *)fill:(CGRect)rect{
    UIBezierPath * bezier = [UIBezierPath bezierPathWithRect:rect];
    return bezier;
}
- (CABasicAnimation *)animation:(CGRect)rect{
    CABasicAnimation * fillAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    fillAnimation.duration = 1.0;
    fillAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    fillAnimation.fillMode = kCAFillModeForwards;
    fillAnimation.removedOnCompletion = NO;
    fillAnimation.fromValue = (__bridge id)([self noFill:rect].CGPath);
    fillAnimation.toValue = (__bridge id)([self fill:rect].CGPath);
    return fillAnimation;
}
#pragma mark -- 点击事件
- (void)clickLookMineBtn:(UIButton *)sender {
    _lookMineBtn.selected = !_lookMineBtn.selected;
    [YDConfigurationHelper setBoolValueForConfigurationKey:@"lookMineBtnIsSelected" withValue:_lookMineBtn.selected];
    if (_lookMineBtn.selected) {
        _view.hidden = NO;
        _mineLayer.hidden = NO;
    } else {
        _view.hidden = YES;
        _mineLayer.hidden = YES;
    }
}

@end
