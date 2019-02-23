//
//  OCMArchiveTool.h
//  OCM
//
//  Created by 曹均华 on 2018/3/23.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCMArchiveTool : NSObject
+ (void)archiverObject:(id)object ByKey:(NSString *)key WithPath:(NSString *)path;
+ (id)unarchiverObjectByKey:(NSString *)key WithPath:(NSString *)path;
@end
