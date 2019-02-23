//
//  CALayer+XibBorderColor.m
//  OCM
//
//  Created by 曹均华 on 2018/3/6.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "CALayer+XibBorderColor.h"

@implementation CALayer (XibBorderColor)
- (void)setBorderColorWithUIColor:(UIColor *)color
{
    self.borderColor = color.CGColor;
}
@end
