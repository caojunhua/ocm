//
//  OCMMapV.m
//  OCM
//
//  Created by 曹均华 on 2018/1/16.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "OCMMapV.h"

#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>

@implementation OCMMapV

+ (instancetype)shareInstance {
    static OCMMapV *_mapV = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _mapV = [[OCMMapV alloc] init];
    });
    return _mapV;
}
@end
