//
//  OCMRemunShapeLayer.m
//  OCM
//
//  Created by 曹均华 on 2017/12/29.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import "OCMRemunShapeLayer.h"

@implementation OCMRemunShapeLayer

- (void)drawInContext:(CGContextRef)ctx {
    UIGraphicsPushContext(ctx); //linesView高度为400(显示所有曲线的按钮高度)  整体frame 应该 y减少50左右(布局误差)
    NSMutableArray *maxValueArr = [NSMutableArray array];
    NSMutableArray *minValueArr = [NSMutableArray array];
    for (int i = 0; i < self.pointArr.count; i++) {
        NSArray *subArr = self.pointArr[i];
        CGFloat maxTemp = [[subArr valueForKeyPath:@"@max.floatValue"] floatValue];
        [maxValueArr addObject:[NSString stringWithFormat:@"%f",maxTemp]];
        CGFloat minTemp = [[subArr valueForKeyPath:@"@min.floatValue"] floatValue];
        [minValueArr addObject:[NSString stringWithFormat:@"%f",minTemp]];
    }
    CGFloat currentMax = [[maxValueArr valueForKeyPath:@"@max.floatValue"] floatValue];
    CGFloat currentMin = [[minValueArr valueForKeyPath:@"@min.floatValue"] floatValue];
    if (self.showedLineArr.count) { // 有要显示的线
            for (int i = 0; i < self.pointArr.count; i++) {
                UIBezierPath *subPath = [UIBezierPath bezierPath];
                [subPath setLineWidth:5.0];
                [subPath setLineCapStyle:kCGLineCapRound];
                [subPath setLineJoinStyle:kCGLineJoinRound];
                NSArray *subArr = self.pointArr[i];
               
                BOOL isHidden = YES;
                for (int m = 0; m < self.showedLineArr.count; m++) {
                    NSInteger k = [self.showedLineArr[m] integerValue]; // 要显示的第k条线
                    if (k == i) {
                        isHidden = NO;
                        break;
                    }
                }
                CGFloat h = 350;
                for (int j = 0; j < subArr.count; j++) {
                    if (j == 0) {
                        [subPath moveToPoint:CGPointMake(self.detalX * (j + 1) - self.detalX * 0.5, (1 - ([subArr[j] floatValue] - currentMin) / (currentMax - currentMin)) * h + 45)];
                    } else {
                        [subPath addLineToPoint:CGPointMake(self.detalX * (j + 1) - self.detalX * 0.5, (1 - ([subArr[j] floatValue] - currentMin) / (currentMax - currentMin)) * h + 45)];
                    }
                }
                [self addAnim:subPath isShouldHidden:(BOOL)isHidden tag:i];
            }
    } else { // 隐藏任何线
        for (int i = 0; i < self.pointArr.count; i++) {
            UIBezierPath *subPath = [UIBezierPath bezierPath];
            [subPath setLineWidth:5.0];
            [subPath setLineCapStyle:kCGLineCapRound];
            [subPath setLineJoinStyle:kCGLineJoinRound];
            NSArray *subArr = self.pointArr[i];
            for (int j = 0; j < subArr.count; j++) {
                if (j == 0) {
                    [subPath moveToPoint:CGPointMake(self.detalX * (j + 1), [subArr[j] floatValue])];
                } else {
                    [subPath addLineToPoint:CGPointMake(self.detalX * (j + 1), [subArr[j] floatValue])];
                }
            }
            [self addAnim:subPath isShouldHidden:YES tag:i];
        }
    }
}
- (void)addAnim:(UIBezierPath *)subPath isShouldHidden:(BOOL)isHidden tag:(int)tag{
    NSArray *colorArr = @[[UIColor colorWithHexString:@"#fd6060"],[UIColor colorWithHexString:@"#60d56a"],[UIColor colorWithHexString:@"#ffba5d"],[UIColor colorWithHexString:@"#7cdfff"],[UIColor colorWithHexString:@"#fb55ab"],[UIColor colorWithHexString:@"#b15edc"],[UIColor colorWithHexString:@"#2172e8"]];
    if (self.sublayers.count >= self.pointArr.count && isHidden) { //要隐藏第tag根线
        _animLayer = (CAShapeLayer *)self.sublayers[tag];
        _animLayer.strokeColor = [UIColor clearColor].CGColor;
        return;
    } else if (self.sublayers.count >= self.pointArr.count && !isHidden) { //要显示第tag根线
        _animLayer = (CAShapeLayer *)self.sublayers[tag];
        NSInteger lastTag = [self.showedLineArr[self.showedLineArr.count - 1] integerValue];
        if (tag == lastTag && (self.newCount > self.lastCount)) { //在增加的时候
            _animLayer.strokeColor = [(UIColor *)colorArr[tag] CGColor];
            CABasicAnimation *animation = [self anim];
            [_animLayer addAnimation:animation forKey:[NSString stringWithFormat:@"%d",tag]];
        } else {
            _animLayer.strokeColor = [(UIColor *)colorArr[tag] CGColor];
        }
        return;
    } else { //初始加载的时候
        _animLayer = [CAShapeLayer layer];
        [self addSublayer:_animLayer];
    }
    
    _animLayer.path = subPath.CGPath;
    _animLayer.lineWidth = 5.f;
    [_animLayer setLineCap:kCALineCapRound];
    _animLayer.lineJoin = kCALineJoinRound;
    if (isHidden) {
        _animLayer.strokeColor = [UIColor clearColor].CGColor;
//        OCMLog(@"透明色");
    } else {
        _animLayer.strokeColor = [(UIColor *)colorArr[tag] CGColor];
//        OCMLog(@"彩色");
    }
    _animLayer.fillColor = [UIColor clearColor].CGColor;
    _animLayer.strokeStart = 0.f;
    _animLayer.strokeEnd = 0.f;

    CABasicAnimation *animation = [self anim];
    [_animLayer addAnimation:animation forKey:[NSString stringWithFormat:@"%d",tag]];
//    OCMLog(@"self.sublayer.count--%ld", self.sublayers.count);
}
- (CABasicAnimation *)anim {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 3.f;
    animation.fromValue = @(0);
    animation.toValue = @(1);
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    // 动画缓慢的进入，中间加速，然后减速的到达目的地。
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    return animation;
}
- (void)setShowedLineArr:(NSMutableArray *)hiddenArr {
    self.newCount = hiddenArr.count;
    self.lastCount = _showedLineArr.count;
    _showedLineArr = hiddenArr;
}
@end
