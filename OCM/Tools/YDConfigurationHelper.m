//
//  YDConfigurationHelper.m
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

#import "YDConfigurationHelper.h"

#define      bYDAuthenticated                     @"bYDAuthenticated"
#define      bYDFirstLaunch                       @"bYDFirstLaunch"
@implementation YDConfigurationHelper
+(void)setApplicationStartupDefaults
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize]; 
    [defaults setBool:NO forKey:bYDFirstLaunch];
    [defaults setBool:NO forKey:bYDAuthenticated];
    [defaults synchronize];
}

+(BOOL)getBoolValueForConfigurationKey:(NSString *)_objectkey
{
    //create an instance of NSUserDefaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize]; //let's make sure the object is synchronized
    return [defaults boolForKey:_objectkey];
}

+(NSString *)getStringValueForConfigurationKey:(NSString *)_objectkey
{
    //create an instance of NSUserDefaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize]; //let's make sure the object is synchronized
    if ([defaults stringForKey:_objectkey] == nil )
    {
        //I don't want a (null) returned since the result might be a text property of a UILabel
        return @"";
    }
    else
    {
        
        return [defaults stringForKey:_objectkey];
    }
}
+(void)setBoolValueForConfigurationKey:(NSString *)_objectkey withValue:(BOOL)_boolvalue
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize]; //let's make sure the object is synchronized
    [defaults setBool:_boolvalue forKey:_objectkey];
    [defaults synchronize];//make sure you're synchronized again
}

+(void)setStringValueForConfigurationKey:(NSString *)_objectkey withValue:(NSString *)_value
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize]; //let's make sure the object is synchronized
    [defaults setValue:_value forKey:_objectkey];
    [defaults synchronize];//make sure you're synchronized again
}
+ (void)setIntegerForConfigurationKey:(NSString *)_objectkey withValue:(NSInteger)_integerValue {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    [defaults setInteger:_integerValue forKey:_objectkey];
    [defaults synchronize];
}
+ (void)setFloatForConfigureationKey:(NSString *)_objectket withValue:(CGFloat)_floatValue {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    [defaults setFloat:_floatValue forKey:_objectket];
    [defaults synchronize];
}
+ (CGFloat)getFloatForConfigurationKey:(NSString *)_objectkey {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    if (![defaults floatForKey:_objectkey])
    {
        return 0;
    }
    else
    {
        return [defaults floatForKey:_objectkey];
    }
}
+ (NSInteger)getIntegerValueForConfigurationKey:(NSString *)_objectkey {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    if (![defaults integerForKey:_objectkey])
    {
        return 0;
    }
    else
    {
        return [defaults integerForKey:_objectkey];
    }
}
//+ (void)setObject:(nullable id)value forKey:(NSString *)_objectkey {
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults synchronize];
//    [defaults setObject:value forKey:_objectkey];
//    [defaults synchronize];
//}
//+ (nullable id)getObjectForKey:(NSString *)_objectkey {
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults synchronize];
//    if (![defaults objectForKey:_objectkey])
//    {
//        return 0;
//    }
//    else
//    {
//        return [defaults objectForKey:_objectkey];
//    }
//}
@end
