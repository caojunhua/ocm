//
//  NSObject+LogLine.m
//  OCM
//
//  Created by 曹均华 on 2017/11/29.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import "NSObject+LogLine.h"

@implementation NSObject (LogLine)
- (NSString *)LogFileName {
    NSString *str = [[NSString alloc] initWithString:(NSString *)self];
    NSRange range = [str rangeOfString:@"/" options:NSBackwardsSearch];
    if (range.location != NSNotFound) {
        str = [str substringFromIndex:range.location + 1];
    }
    return str;
}
@end
