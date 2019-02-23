//
//  YDConfigurationHelper.h
//  MyPersonalLibrary
//  This file is part of source code lessons that are related to the book
//  Title: Professional IOS Programming
//  Publisher: John Wiley & Sons Inc
//  ISBN 978-1-118-66113-0
//  Author: Peter van de Put
//  Company: YourDeveloper Mobile Solutions
//  Contact the author: www.yourdeveloper.net | info@yourdeveloper.net
//  Copyright (c) 2013 with the author and publisher. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDConfigurationHelper : NSObject

+(void)setApplicationStartupDefaults;

+(BOOL)getBoolValueForConfigurationKey:(NSString *)_objectkey;

+(NSString *)getStringValueForConfigurationKey:(NSString *)_objectkey;

+(void)setBoolValueForConfigurationKey:(NSString *)_objectkey withValue:(BOOL)_boolvalue;

+(void)setStringValueForConfigurationKey:(NSString *)_objectkey withValue:(NSString *)_value;

+ (void)setIntegerForConfigurationKey:(NSString *)_objectkey withValue:(NSInteger)_integerValue;

+ (void)setFloatForConfigureationKey:(NSString *)_objectket withValue:(CGFloat)_floatValue;

+ (CGFloat)getFloatForConfigurationKey:(NSString *)_objectkey;

+ (NSInteger)getIntegerValueForConfigurationKey:(NSString *)_objectkey;

//+ (void)setObject:(nullable id)value forKey:(NSString *_Nullable)_objectkey;
//+ (nullable id)getObjectForKey:(NSString *)_objectkey;
@end
