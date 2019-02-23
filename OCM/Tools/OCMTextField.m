//
//  OCMTextField.m
//  OCM
//
//  Created by 曹均华 on 2017/12/4.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import "OCMTextField.h"

@implementation OCMTextField

- (CGRect)textRectForBounds:(CGRect)bounds
{
    CGRect inset = CGRectMake(bounds.origin.x+10, bounds.origin.y, bounds.size.width-25, bounds.size.height);
    return inset;
}

-(CGRect)editingRectForBounds:(CGRect)bounds
{
    CGRect insert = CGRectMake(bounds.origin.x+10, bounds.origin.y, bounds.size.width-25, bounds.size.height);
    return insert;
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds{
    CGRect insert = CGRectMake(bounds.origin.x+10, bounds.origin.y, bounds.size.width-25, bounds.size.height);
    return insert;
}
@end
