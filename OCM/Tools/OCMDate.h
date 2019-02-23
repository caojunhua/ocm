//
//  OCMDate.h
//  OCM
//
//  Created by 曹均华 on 2018/4/2.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCMDate : NSDate

/**
 获取当前时间

 @return 获取当前时间
 */
- (NSString *)currentDateStr;

/**
 获取当前时间戳

 @return 获取当前时间戳
 */
- (NSString *)currentTimeStr;

/**
 时间戳转时间,时间戳为13位是精确到毫秒的，10位精确到秒

 @param str str
 @return str
 */
- (NSString *)getDateStringWithTimeStr:(NSString *)str;

/**
 字符串转时间戳 如：2017-4-10 17:15:10

 @param str str
 @return str
 */
- (NSString *)getTimeStrWithString:(NSString *)str;
+ (NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format;
@end
