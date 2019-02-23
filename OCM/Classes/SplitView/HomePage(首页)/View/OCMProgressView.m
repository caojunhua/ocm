//
//  OCMLeftTopView.m
//  OCM
//
//  Created by 曹均华 on 2017/12/15.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import "OCMProgressView.h"

@implementation OCMProgressView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        CGRect rect = CGRectMake(0, 0, 0, frame.size.height);
        _progressV = [[UIView alloc] initWithFrame:rect];
        ViewBorder(_progressV, 0, [UIColor clearColor], frame.size.height * 0.5);
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.18];
        ViewBorder(self, 0, [UIColor clearColor], frame.size.height * 0.5);
        [self addSubview:_progressV];
    }
    return self;
}
- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    if (progress == 0) {
        
    } else {
        CGRect rect = CGRectMake(0, 0, self.frame.size.width * progress, self.frame.size.height);
        [UIView animateWithDuration:0.5 animations:^{
            self.progressV.frame = rect;
            CAGradientLayer *gradientLayer = [CAGradientLayer layer];
            gradientLayer.colors = @[(__bridge id)[UIColor colorWithHexString:@"09c5ff"].CGColor, (__bridge id)[UIColor colorWithHexString:@"2b56a9"].CGColor];
            gradientLayer.locations = @[@0, @1.0];
            gradientLayer.startPoint = CGPointMake(0, 0);
            gradientLayer.endPoint = CGPointMake(1.0, 0);
            gradientLayer.frame = _progressV.layer.bounds;
            gradientLayer.cornerRadius = 3;
            [_progressV.layer addSublayer:gradientLayer];
        }];
    }
}

@end
