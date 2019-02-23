//
//  OCMArchiveTool.m
//  OCM
//
//  Created by 曹均华 on 2018/3/23.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "OCMArchiveTool.h"

@implementation OCMArchiveTool
+ (void)archiverObject:(id)object ByKey:(NSString *)key WithPath:(NSString *)path {
    //初始化存储对象信息的data
    NSMutableData *data = [NSMutableData data];
    //创建归档工具对象
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    //开始归档
    [archiver encodeObject:object forKey:key];
    //结束归档
    [archiver finishEncoding];
    //写入本地
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).lastObject;
    NSString *destPath = [[docPath stringByAppendingPathComponent:@"Caches"] stringByAppendingPathComponent:path];
    
    [data writeToFile:destPath atomically:YES];
}

+ (id)unarchiverObjectByKey:(NSString *)key WithPath:(NSString *)path {
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).lastObject;
    NSString *destPath = [[docPath stringByAppendingPathComponent:@"Caches"] stringByAppendingPathComponent:path];
    NSData *data = [NSData dataWithContentsOfFile:destPath];
    //创建反归档对象
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    //接收反归档得到的对象
    id object = [unarchiver decodeObjectForKey:key];
    return object;
}
@end
