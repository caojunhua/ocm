//
//  NSString+Base64.h
//  OCM
//
//  Created by 曹均华 on 2017/12/12.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Base64)
/**
 *  转换为Base64编码
 */
- (NSString *)base64EncodedString;
/**
 *  将Base64编码还原
 */
- (NSString *)base64DecodedString;
@end
