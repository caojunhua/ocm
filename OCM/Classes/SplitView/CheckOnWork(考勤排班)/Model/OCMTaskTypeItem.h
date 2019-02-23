//
//  OCMTaskTypeItem.h
//  OCM
//
//  Created by 曹均华 on 2018/5/8.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCMTaskTypeItem : NSObject
@property (nonatomic, assign) NSInteger imgType;
@property (nonatomic, copy)   NSString  *name;
@property (nonatomic, strong) NSArray   *subArr;
@end
