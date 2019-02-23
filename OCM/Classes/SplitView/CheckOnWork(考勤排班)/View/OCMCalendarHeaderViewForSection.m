//
//  OCMCalendarHeaderViewForSection.m
//  OCM
//
//  Created by 曹均华 on 2018/4/17.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "OCMCalendarHeaderViewForSection.h"

@implementation OCMCalendarHeaderViewForSection
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self config];
    }
    return self;
}
- (void)config {
    CGFloat h = 25.f;
    self.sepView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, h)];
    self.sepView.backgroundColor = [UIColor RGBColorWithRed:252 withGreen:252 withBlue:252 withAlpha:1.0];
    [self addSubview:self.sepView];
    
    CGFloat monthWidth = 100.f;
    self.monthL = [[UILabel alloc] initWithFrame: CGRectMake(self.width * 0.5 - monthWidth * 0.5, 0, monthWidth, h)];
    self.monthL.textColor = [UIColor colorWithHexString:@"666666"];
    self.monthL.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.monthL];
}

@end
