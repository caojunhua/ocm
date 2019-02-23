//
//  OCMPersonalView.m
//  OCM
//
//  Created by 曹均华 on 2018/1/15.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "OCMPersonalView.h"

@implementation OCMPersonalView
{
    UIView *_topV;
    UIView *_midV;
//    UIScrollView *_scrollV;
    UIView *_bottomV;
    NSLock *_lock;
}

- (instancetype)initWithTeamName:(NSString *)teamName person:(NSString *)personName completedArr:(NSArray *)compArr planArr:(NSArray *)planArr taskArr:(NSArray *)taskArr frame:(CGRect)frame {
    self.teamName = teamName;
    self.personName = personName;
    self.completeArr = compArr;
    self.planArr = planArr;
    self.taskArr = taskArr;
    return [self initWithFrame:frame];
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [_lock lock];
        [self config];
        [_lock unlock];
        [self strokeBars];
    }
    return self;
}
- (void)config {
    __weak typeof(self) weakSelf = self;
    /*-------------topV-------------*/
    CGFloat topH = 50;
    _topV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, topH)];
    _topV.backgroundColor = [UIColor colorWithHexString:@"#f9f9f9"];
    ViewBorder(_topV, 1, [UIColor colorWithHexString:@"#cccccc"], 0);
    [self addSubview:_topV];
    UILabel *teamL = [[UILabel alloc] initWithFrame:CGRectMake(17, 20, 150, 16)];
    teamL.textColor = [UIColor colorWithHexString:@"#666666"];
    teamL.font = [UIFont systemFontOfSize:15];
    NSString *str1 = @"班组名称 : ";
    teamL.text = [str1 stringByAppendingString:self.teamName];
    [self addSubview:teamL];
    
    UILabel *nameL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 16)];
    nameL.textColor = [UIColor colorWithHexString:@"#666666"];
    nameL.font = [UIFont systemFontOfSize:15];
    NSString *str2 = @"渠道经理 : ";
    nameL.text = [str2 stringByAppendingString:self.personName];
    [self addSubview:nameL];
    [nameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.mas_right).offset(-15);
        make.top.mas_equalTo(20);
    }];
    /*-------------topV-------------*/
    
    /*-------------midV-------------*/
    CGFloat midH = 491;
    _midV = [[UIView alloc] initWithFrame:CGRectMake(0, topH - 1, self.width, midH)];
    [self addSubview:_midV];
    ViewBorder(_midV, 1, [UIColor colorWithHexString:@"#cccccc"], 0);
    CGFloat barH = 400;
    UIView *barsView = [[UIView alloc] init];
    [_midV addSubview:barsView];
    [barsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(weakSelf.width);
        make.height.mas_equalTo(barH);
        make.left.mas_equalTo(weakSelf);
        make.top.mas_equalTo(weakSelf).offset(30+topH);
    }];
    //x轴上的百分数
    CGFloat detalH = 400 * 0.1;
    NSInteger y = 10;
    for (int i = 0; i < 11; i++) {
        UILabel *labelPer = [[UILabel alloc] initWithFrame:CGRectMake(0, 420 - i * detalH - 12.5, 50, 25)];
        NSString *perStr = [[@"-" stringByAppendingString:[NSString stringWithFormat:@"%ld",i * y]] stringByAppendingString:@"%"];
        labelPer.text = perStr;
        labelPer.font = [UIFont systemFontOfSize:15];
        labelPer.textColor = [UIColor colorWithHexString:@"#999999"];
        [barsView addSubview:labelPer];
    }
    //scrollView
    CGFloat scrollVH = 490;
    _scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(38, -30, self.width - 76, scrollVH)];
    CGFloat w1 = (86 + 36) * self.taskArr.count - 86 + 25 + 25 + 5;// 左右各多25间距
    _scrollV.contentSize = CGSizeMake(w1, scrollVH);
    _scrollV.showsHorizontalScrollIndicator = NO;
    [barsView addSubview:_scrollV];
    //任务分割线
    UIView *sepV = [[UIView alloc] initWithFrame:CGRectMake(0, 450, self.width, 1)];
//    _sepV = sepV;
    sepV.backgroundColor = [UIColor colorWithHexString:@"cccccc"];
    [_scrollV addSubview:sepV];
    //添加任务名字
    CGFloat h = 15;
    CGFloat w = 100;
    CGFloat y1 = 450 + 25 * 0.5;
    for (int i = 0; i < self.taskArr.count; i++) {
        CGFloat x =  25 + i * (86 + 36) + 18;
        CGRect rect = CGRectMake(x, y1, w, h);
        UILabel *label = [[UILabel alloc] initWithFrame:rect];
        label.centerX = x;
        label.font = [UIFont systemFontOfSize:15];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor colorWithHexString:@"#666666"];
        label.text = [NSString stringWithFormat:@"%@",self.taskArr[i]];
        [_scrollV addSubview:label];
    }
    /*-------------midV-------------*/
    
    /*-------------botV-------------*/
    _bottomV = [[UIView alloc] init];
    [self addSubview:_bottomV];
    [_bottomV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(weakSelf.width);
        make.top.mas_equalTo(_midV.mas_bottom);
        make.height.mas_equalTo(70);
        make.left.mas_equalTo(weakSelf);
    }];
    UIImageView *imaV1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 50, 26, 20)];
    UIImage *image1 = [UIImage createImageWithColor:[UIColor colorWithHexString:@"#b15edc"]];
    imaV1.image = image1;
    [_bottomV addSubview:imaV1];
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(46, 50, 100, 20)];
    label1.font = [UIFont systemFontOfSize:15];
    label1.textColor = [UIColor colorWithHexString:@"#666666"];
    label1.text = @"已完成";
    [_bottomV addSubview:label1];
    
    UIImageView *imaV2 = [[UIImageView alloc] initWithFrame:CGRectMake(160, 50, 26, 20)];
    UIImage *image2 = [UIImage createImageWithColor:[UIColor colorWithHexString:@"#e4c5ea"]];
    imaV2.image = image2;
    [_bottomV addSubview:imaV2];
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(196, 50, 100, 20)];
    label2.font = [UIFont systemFontOfSize:15];
    label2.textColor = [UIColor colorWithHexString:@"#666666"];
    label2.text = @"未完成";
    [_bottomV addSubview:label2];
    /*-------------botV-------------*/
}
#pragma mark -- strokeBars
- (void)strokeBars {
    [self strokePlan]; // 计划的任务
    [self strokeCompleted]; // 完成的任务
}
- (void)strokePlan {
    CGFloat xDis = 86;
    CGFloat barW = 36;
//    if (self.currentIndex && self.currentIndex < self.planArr.count + 1) {
        NSArray *arr = self.planArr;
        for (int i = 0; i < arr.count; i++) {
            CGFloat h = 400;
            CGFloat w = barW;
            CGFloat x =  25 + i * (xDis + barW);
            CGFloat y = 50;
            CGRect rect = CGRectMake(x, y, w, h);
            [_scrollV.layer addSublayer:[self shapeLayer:rect color:[UIColor colorWithHexString:@"#e4c5ea"] isAnima:NO]];
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
//    }
}
- (void)strokeCompleted {
    CGFloat xDis = 86;
    CGFloat barW = 36;
//    if (self.currentIndex && self.currentIndex < self.planArr.count + 1) {
        NSArray *arr = self.completeArr;
        NSArray *arr2 = self.planArr;
    CGFloat bigH = 450;
        for (int i = 0; i < arr.count; i++) {
            CGFloat completedValue = [arr[i] floatValue];
            for (int j = 0; j < arr2.count; j++) {
                if (i == j) {
                    CGFloat planedValue = [arr2[j] floatValue];
                    CGFloat h = 400 * (completedValue / planedValue);
                    CGFloat w = barW;
                    CGFloat x =  25 + i * (xDis + barW);
                    CGFloat y = bigH - h;
                    CGRect rect = CGRectMake(x, y, w, h);
                    [_scrollV.layer addSublayer:[self shapeLayer:rect color:[UIColor colorWithHexString:@"#b15edc"] isAnima:YES]];
                    break;
                }
            }
            for (int j = 0; j < arr2.count; j++) {
                if (i == j) {
                    CGFloat planedValue = [arr2[j] floatValue];
                    CGFloat h = 15;
                    CGFloat w = barW;
                    CGFloat x =  25 + i * (xDis + barW);
                    CGFloat y = bigH - (400 * (completedValue / planedValue) * 0.5) - h * 0.5;
                    CGRect rect = CGRectMake(x, y, w, h);
                    [self addTextL:rect color:[UIColor whiteColor] value:completedValue isDelay:YES];
                    break;
                }
            }
        }
//    }
}
//- (void)addTaskName:(CGRect)rect name:(NSString *)name color:(UIColor *)color{
//    UILabel *label = [[UILabel alloc] initWithFrame:rect];
//    label.font = [UIFont systemFontOfSize:14];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.textColor = color;
//    label.text = [NSString stringWithFormat:@"%@",name];
//    [_scrollV addSubview:label];
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
            [_scrollV addSubview:label];
        });
    } else {
        UILabel *label = [[UILabel alloc] initWithFrame:rect];
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = color;
        label.text = [NSString stringWithFormat:@"%.0f",h];
        [_scrollV addSubview:label];
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
