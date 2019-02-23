//
//  OCMMoreDetailInfoHeadView.m
//  OCM
//
//  Created by 曹均华 on 2018/3/6.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "OCMMoreDetailInfoHeadView.h"

@implementation OCMMoreDetailInfoHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        self = [[[NSBundle mainBundle] loadNibNamed:@"OCMMoreDetailInfoHeadView" owner:self options:nil] objectAtIndex:0];
//        self.frame = frame;
        OCMMoreDetailInfoHeadView *view = [[[NSBundle mainBundle] loadNibNamed:@"OCMMoreDetailInfoHeadView" owner:self options:nil] objectAtIndex:0];
        view.frame = frame;
        [self addSubview:view];
    }
    return self;
}

@end
