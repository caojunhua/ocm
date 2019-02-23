//
//  OCMTeamView.m
//  OCM
//
//  Created by 曹均华 on 2018/1/10.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "OCMTeamView.h"
#import "CFDynamicLabel.h"

@implementation OCMTeamView
{
    NSLock *_lock;
    UIView *_sepV;
    CGFloat _sepWidth;
}
- (instancetype)initWithFrame:(CGRect)frame
                     planData:(NSMutableArray<NSMutableArray*> *)planArr
                completedData:(NSMutableArray<NSMutableArray*> *)completedArr
                     teamName:(NSMutableArray *)teamNameArr
                     taskName:(NSMutableArray *)taskNameArr
                     sepWidth:(CGFloat)sepWidth
                 selectedData:(NSInteger)sel
                        curX1:(CGFloat)curX1
{
    self.planArr = planArr;
    self.completeArr = completedArr;
    self.teamNameArr = teamNameArr;
    self.taskNameArr = taskNameArr;
    self.currentIndex = sel;
    self.curX1 = curX1;
    self->_sepWidth = sepWidth;
    self->_lock = [NSLock new];
    return [self initWithFrame:frame];
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [_lock lock];
        [self setUpView];
        [_lock unlock];
        [self strokePath];
    }
    return self;
}
- (void)setUpView {
    __weak typeof(self) weakSelf = self;
//    UIView *upView = [UIView alloc];
    /*--------------topV-----------------*/
    CGFloat topH = 50;
    self.topV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, topH)];
//    ViewBorder(self.topV, 1, [UIColor colorWithHexString:@"cccccc"], 0);
    [self addSubview:self.topV];
    
    CGFloat conditonH = 50;
    UIView *conditonV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, conditonH)];//筛选条件
    [self.topV addSubview:conditonV];
    //所有任务按钮
    _taskBtn = [[UIButton alloc] init];
    self.taskLabel = [[CFDynamicLabel alloc] initWithFrame:CGRectMake(15, 8, 50, 20)];
    [_taskBtn addSubview:self.taskLabel];
    self.taskLabel.speed = 0.9;
    self.taskLabel.textColor = [UIColor colorWithHexString:@"#009dec"];
    self.taskLabel.font = [UIFont systemFontOfSize:14];
    self.taskLabel.backgroundColor = [UIColor clearColor];
    [conditonV addSubview:_taskBtn];
    [_taskBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(conditonV);
        make.right.mas_equalTo(conditonV.mas_right).offset(-18);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(32);
    }];
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(70, 1, 30, 30)];
    imgV.image = ImageIs(@"xiala");
    [_taskBtn addSubview:imgV];
    ViewBorder(_taskBtn, 1, [UIColor colorWithHexString:@"#cccccc"], 5);
    //所有片区按钮
    _areaBtn = [[UIButton alloc] init];
    self.areaLabel = [[CFDynamicLabel alloc] initWithFrame:CGRectMake(15, 8, 50, 20)];
    [_areaBtn addSubview:self.areaLabel];
    self.areaLabel.speed = 0.9;
    self.areaLabel.textColor = [UIColor colorWithHexString:@"#009dec"];
    self.areaLabel.font = [UIFont systemFontOfSize:14];
    self.areaLabel.backgroundColor = [UIColor clearColor];
    [conditonV addSubview:_areaBtn];
    [_areaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(conditonV);
        make.right.mas_equalTo(weakSelf.taskBtn.mas_left).offset(-18);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(32);
    }];
    UIImageView *imgV1 = [[UIImageView alloc] initWithFrame:CGRectMake(70, 1, 30, 30)];
    imgV1.image = ImageIs(@"xiala");
    [_areaBtn addSubview:imgV1];
    ViewBorder(_areaBtn, 1, [UIColor colorWithHexString:@"#cccccc"], 5);
    //筛选条件
    UILabel *labelScr = [[UILabel alloc] init];
    labelScr.text = @"筛选条件 :";
    labelScr.textColor = [UIColor colorWithHexString:@"#666666"];
    labelScr.font = [UIFont systemFontOfSize:15];
    [conditonV addSubview:labelScr];
    [labelScr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(conditonV);
        make.right.mas_equalTo(weakSelf.areaBtn.mas_left).offset(-18);
    }];
    /*--------------topV-----------------*/
    
    /*--------------midV-----------------*/
    CGFloat midH = 530;
    self.midV = [[UIView alloc] init];
    [self addSubview:self.midV];
    [self.midV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(weakSelf.width);
        make.height.mas_equalTo(midH);
        make.left.mas_equalTo(weakSelf);
        make.top.mas_equalTo(weakSelf.topV.mas_bottom).offset(-1);
    }];
//    ViewBorder(self.midV, 1, [UIColor colorWithHexString:@"cccccc"], 0);
    //中间柱状图
    
    CGFloat barH = 400;
    UIView *barsView = [[UIView alloc] init];
    [self.midV addSubview:barsView];
    [barsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(weakSelf.width);
        make.height.mas_equalTo(barH);
        make.left.mas_equalTo(weakSelf.midV);
        make.top.mas_equalTo(conditonV.mas_bottom).offset(30);
    }];
    //添加第一个scrollView
    self.scrollView1 = [[UIScrollView alloc] init];
    self.scrollView1.showsHorizontalScrollIndicator = NO;
    [barsView addSubview:self.scrollView1];
    [self.scrollView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(38);
        make.top.mas_equalTo(barsView.mas_top).offset(-50);
        make.right.mas_equalTo(barsView.mas_right).offset(-38);
        make.bottom.mas_equalTo(barsView.mas_bottom).offset(50);
    }];
    [self.scrollView1 setContentOffset:CGPointMake(_curX1, 0)];
    //任务分割线
    UIView *sepV = [[UIView alloc] initWithFrame:CGRectMake(0, 450, _sepWidth, 1)];
    _sepV = sepV;
    _sepV.backgroundColor = [UIColor colorWithHexString:@"cccccc"];
    [self.scrollView1 addSubview:_sepV];
    //添加任务名字
    CGFloat h = 15;
    CGFloat w = 100;
    CGFloat y1 = 450 + 35 * 0.5;
    for (int i = 0; i < self.taskNameArr.count; i++) {
        CGFloat x =  25 + i * (86 + 36) + 18;
        CGRect rect = CGRectMake(x, y1, w, h);
        UILabel *label = [[UILabel alloc] initWithFrame:rect];
        label.centerX = x;
        label.font = [UIFont systemFontOfSize:15];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor colorWithHexString:@"#666666"];
        label.text = [NSString stringWithFormat:@"%@",self.taskNameArr[i]];
        [self.scrollView1 addSubview:label];
    }

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
    //向左<--  和   向右--> 按钮
    self.leftBtn = [[UIButton alloc] init];
    self.leftBtn.backgroundColor = [UIColor colorWithHexString:@"#f9f9f9"];
    [self.midV addSubview:self.leftBtn];
    [self.leftBtn setImage:ImageIs(@"icon_inforeward_left") forState:UIControlStateNormal];
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.midV);
        make.bottom.mas_equalTo(weakSelf.midV.mas_bottom);
        make.width.mas_equalTo(38);
        make.height.mas_equalTo(50);
    }];
    //向右-->
    self.rightBtn = [[UIButton alloc] init];
    self.rightBtn.backgroundColor= [UIColor colorWithHexString:@"#f9f9f9"];
    [self.midV addSubview:self.rightBtn];
    [self.rightBtn setImage:ImageIs(@"icon_inforeward_right") forState:UIControlStateNormal];
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(38);
        make.right.mas_equalTo(weakSelf.midV.mas_right);
        make.bottom.mas_equalTo(weakSelf.midV.mas_bottom);
        make.height.mas_equalTo(50);
    }];
    /*--------------midV-----------------*/
    
    /*--------------bottomV-----------------*/
    self.bottomV = [[UIView alloc] init];
    [self addSubview:self.bottomV];
    [self.bottomV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(weakSelf.width);
        make.top.mas_equalTo(weakSelf.midV.mas_bottom);
        make.height.mas_equalTo(70);
        make.left.mas_equalTo(weakSelf);
    }];
    UIImageView *imaV1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 50, 26, 20)];
    UIImage *image1 = [UIImage createImageWithColor:[UIColor colorWithHexString:@"#b15edc"]];
    imaV1.image = image1;
    [self.bottomV addSubview:imaV1];
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(46, 50, 100, 20)];
    label1.font = [UIFont systemFontOfSize:15];
    label1.textColor = [UIColor colorWithHexString:@"#666666"];
    label1.text = @"已完成";
    [self.bottomV addSubview:label1];
    
    UIImageView *imaV2 = [[UIImageView alloc] initWithFrame:CGRectMake(160, 50, 26, 20)];
    UIImage *image2 = [UIImage createImageWithColor:[UIColor colorWithHexString:@"#e4c5ea"]];
    imaV2.image = image2;
    [self.bottomV addSubview:imaV2];
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(196, 50, 100, 20)];
    label2.font = [UIFont systemFontOfSize:15];
    label2.textColor = [UIColor colorWithHexString:@"#666666"];
    label2.text = @"未完成";
    [self.bottomV addSubview:label2];
    /*--------------bottomV-----------------*/
    [self addLine];
}
- (void)addLine {
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 1;
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(self.width, 0)];
    [path addLineToPoint:CGPointMake(self.width, 580 - 2)];
    [path addLineToPoint:CGPointMake(0, 580 - 2)];
    [path closePath];
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.path = path.CGPath;
    lineLayer.fillColor = [UIColor clearColor].CGColor;
    lineLayer.strokeColor = [UIColor colorWithHexString:@"cccccc"].CGColor;
    [self.layer addSublayer:lineLayer];
}

#pragma mark -- strokPath
- (void)strokePath {
    [self strokePlan]; // 计划的任务
    [self strokeCompleted]; // 完成的任务
}
- (void)strokePlan {
    CGFloat xDis = 86;
    CGFloat barW = 36;
    if (self.currentIndex && self.currentIndex < self.planArr.count + 1) {
        NSArray *arr = self.planArr[self.currentIndex - 1];
        for (int i = 0; i < arr.count; i++) {
            CGFloat h = 400;
            CGFloat w = barW;
            CGFloat x =  25 + i * (xDis + barW);
            CGFloat y = 50;
            CGRect rect = CGRectMake(x, y, w, h);
            [self.scrollView1.layer addSublayer:[self shapeLayer:rect color:[UIColor colorWithHexString:@"#e4c5ea"] isAnima:NO]];
        }
        for (int i = 0; i < arr.count; i++) {
            CGFloat h = 15;
            CGFloat w = barW;
            CGFloat x =  25 + i * (xDis + barW);
            CGFloat y = 35;
            CGRect rect = CGRectMake(x, y, w, h);
            CGFloat value = [arr[i] floatValue];
            [self addTextL:rect color:[UIColor colorWithHexString:@"#b15edc"] value:value isDelay:NO];
        }
    }
}
- (void)strokeCompleted {
    CGFloat xDis = 86;
    CGFloat barW = 36;
    if (self.currentIndex && self.currentIndex < self.planArr.count + 1) {
        NSArray *arr = self.completeArr[self.currentIndex - 1];
        NSArray *arr2 = self.planArr[self.currentIndex - 1];
        for (int i = 0; i < arr.count; i++) {
            CGFloat completedValue = [arr[i] floatValue];
            for (int j = 0; j < arr2.count; j++) {
                if (i == j) {
                    CGFloat planedValue = [arr2[j] floatValue];
                    CGFloat h = 400 * (completedValue / planedValue);
                    CGFloat w = barW;
                    CGFloat x =  25 + i * (xDis + barW);
                    CGFloat y = 450 - h;
                    CGRect rect = CGRectMake(x, y, w, h);
                    [self.scrollView1.layer addSublayer:[self shapeLayer:rect color:[UIColor colorWithHexString:@"#b15edc"] isAnima:YES]];
                    break;
                }
            }
            for (int j = 0; j < arr2.count; j++) {
                if (i == j) {
                    CGFloat planedValue = [arr2[j] floatValue];
                    CGFloat h = 15;
                    CGFloat w = barW;
                    CGFloat x =  25 + i * (xDis + barW);
                    CGFloat y = 450 - (400 * (completedValue / planedValue) * 0.5) - h * 0.5;
                    CGRect rect = CGRectMake(x, y, w, h);
                    [self addTextL:rect color:[UIColor whiteColor] value:completedValue isDelay:YES];
                    break;
                }
            }
        }
    }
}
//- (void)addTaskName:(CGRect)rect name:(NSString *)name color:(UIColor *)color{
//    UILabel *label = [[UILabel alloc] initWithFrame:rect];
//    label.font = [UIFont systemFontOfSize:14];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.textColor = color;
//    label.text = [NSString stringWithFormat:@"%@",name];
//    [self.scrollView1 addSubview:label];
//}
- (void)addTextL:(CGRect)rect color:(UIColor *)color value:(CGFloat)h isDelay:(BOOL)isDelay{
    if (isDelay) {
        dispatch_time_t delayT = GCD_delayT(1);
        dispatch_after(delayT, dispatch_get_main_queue(), ^{
            UILabel *label = [[UILabel alloc] initWithFrame:rect];
            label.font = [UIFont systemFontOfSize:14];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = color;
            label.text = [NSString stringWithFormat:@"%.0f",h];
            [self.scrollView1 addSubview:label];
        });
    } else {
        UILabel *label = [[UILabel alloc] initWithFrame:rect];
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = color;
        label.text = [NSString stringWithFormat:@"%.0f",h];
        [self.scrollView1 addSubview:label];
    }
}
- (CAShapeLayer *)shapeLayer:(CGRect)rect color:(UIColor *)color isAnima:(BOOL)isAnimation{
    CAShapeLayer * layer = [CAShapeLayer layer];
    layer.fillColor = color.CGColor;
    layer.lineCap = kCALineCapRound;
    layer.path = [self fill:rect].CGPath;
    if (isAnimation) {
        [layer addAnimation:[self animation:rect] forKey:nil];
    }
    return layer;
}
- (UIBezierPath *)noFill:(CGRect)rect{
    CGRect rect0 = rect;
    rect0.origin.y = 450;
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
@end
