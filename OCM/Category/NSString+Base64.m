//
//  NSString+Base64.m
//  OCM
//
//  Created by 曹均华 on 2017/12/12.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import "NSString+Base64.h"

@implementation NSString (Base64)
//编码
- (NSString *)base64EncodedString;
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}
//解码
- (NSString *)base64DecodedString
{
    NSData *data = [[NSData alloc]initWithBase64EncodedString:self options:0];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}
@end
