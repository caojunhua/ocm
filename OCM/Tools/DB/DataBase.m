//
//  DataBase.m
//  OCM
//
//  Created by 曹均华 on 2018/3/8.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "DataBase.h"
#import "OCMListItem.h"
#import "OCMAllNetDetailItem.h"
#import <sqlite3.h>
#import <FMDB/FMDB.h>
//
@implementation DataBase
+ (instancetype)shareInstance {
    static DataBase *_database = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _database = [[DataBase alloc] init];
        [_database creatTabel];
    });
    return _database;
}
- (BOOL)creatTabel {
    NSString *documentsPaths = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePaths = [NSString stringWithFormat:@"%@/%@",documentsPaths,DATABASE_NAME];
    OCMLog(@"filepathc--%@", filePaths);
    self.db = [FMDatabase databaseWithPath:filePaths];
    self.queue = [FMDatabaseQueue databaseQueueWithPath:filePaths];
    if (!dbopen) {
        OCMLog(@"数据库打开失败");
//        NULL 值是空值
//        INTEGER 值是整型
//        REAL 值是浮点数
//        TEXT 值是文本字符串
//        BLOB 值是一个二进制类型
        return NO;
    } else {
        OCMLog(@"数据库打开成功");
        sqlite3_exec((__bridge sqlite3 *)(_db),"PRAGMA synchronous = OFF; ",0,0,0);
        NSString *path = [[NSBundle mainBundle] pathForResource:@"create_table.sql" ofType:nil];
        NSString *sql = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        OCMLog(@"sql--%@", sql);
        __weak typeof(self) weakSelf = self;
        [self.queue inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
            [weakSelf judgeDBError:[db executeStatements:sql] action:DATABASE_CREATE];
        }];
        dbclose;
    }
    return YES;
}
#pragma mark -- OCMListItem
- (void)insertNetInfo:(OCMListItem *)item {
    if (dbopen) {
        NSString *insertSql = [NSString stringWithFormat:@"insert OR IGNORE into T_QDManagerNetInfo values (null,'%@','%@','%@','%@','%@','%@','%@','%@','%@')",item.chName,item.bossId,item.contacts,item.phone,@(item.chLatitude),@(item.chLogngitude),item.rankCode,@(item.distance),item.QDid];
        [self.queue inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
            [self judgeDBError:[db executeUpdate:insertSql] action:DATABASE_INSERT];
        }];
        dbclose;
    }
}
- (NSMutableArray *)getAllNetInfo {
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    if (dbopen) {
        FMResultSet *res = [_db executeQuery:@"select * from T_QDManagerNetInfo"];
        while ([res next]) {
            OCMListItem *item = [[OCMListItem alloc] init];
            item.chName = [res stringForColumn:@"chName"];
            item.bossId = [res stringForColumn:@"bossId"];
            item.contacts = [res stringForColumn:@"contacts"];
            item.phone = [res stringForColumn:@"phone"];
            item.chLatitude = [[res stringForColumn:@"chLatitude"] floatValue];
            item.chLogngitude = [[res stringForColumn:@"chLogngitude"] floatValue];
            item.rankCode = [res stringForColumn:@"rankCode"];
            item.distance = [[res stringForColumn:@"distance"] floatValue];
            item.QDid = [res stringForColumn:@"QDid"];
            [arr addObject:item];
        }
        dbclose;
    }
    return arr;
}
#pragma mark -- OCMAllNetDetailItem
- (void)insertAllNetInfo:(OCMAllNetDetailItem *)item {
    if (dbopen) {
        NSString *insertSql = [NSString stringWithFormat:@"insert or ignore into T_AllNetInfo values (null,'%@','%@')",@(item.chLatitude),@(item.chLogngitude)];
        [self.queue inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
            [self judgeDBError:[db executeUpdate:insertSql] action:DATABASE_INSERT];
        }];
        dbclose;
    }
}
- (NSMutableArray *)getSixThousandNetInfo {
    NSMutableArray *tempArr = [NSMutableArray array];
    if (dbopen) {
        FMResultSet *res = [_db executeQuery:@"select * from T_AllNetInfo"];
        if ([res next]) {
            OCMLog(@"OCMAllNetDetailItem--已经存过缓存了");
            while ([res next]) {
                OCMAllNetDetailItem *item = [[OCMAllNetDetailItem alloc] init];
                item.chLogngitude = [[res stringForColumn:@"chLogngitude"] floatValue];
                item.chLatitude = [[res stringForColumn:@"chLatitude"] floatValue];
                [tempArr addObject:item];
            }
        } else {
            OCMLog(@"OCMAllNetDetailItem--没有存过缓存");
        }
        dbclose;
    }
    return tempArr;
}

- (void)batchAddData:(NSMutableArray *)arr
{
    if ([self.db open])
    {
        NSDate *startTime = [NSDate date];
        [_db beginTransaction];
        BOOL isRollBack = NO;
        @try
        {
            for (OCMAllNetDetailItem *detailItem in arr) {
                NSString *insertSql = [NSString stringWithFormat:@"insert into T_AllNetInfo values (null,'%@','%@')",@(detailItem.chLatitude),@(detailItem.chLogngitude)];
                [self judgeDBError:[_db executeUpdate:insertSql] action:DATABASE_INSERT];
            }
//            for (int i = 0; i < 10000; i++) {
//                NSString *insertSql = [NSString stringWithFormat:@"insert into T_AllNetInfo values (null,'%@','%@')",@(i),@(i)];
//                [_db executeUpdate:insertSql];
//            }
            NSDate *endTime = [NSDate date];
            NSTimeInterval a = [endTime timeIntervalSince1970] - [startTime timeIntervalSince1970];
            OCMLog(@"使用事务插入数据用时%.3f秒",a);
            
        }
        @catch (NSException *exception)
        {
            isRollBack = YES;
            [_db rollback];
        }
        @finally
        {
            if (!isRollBack)
            {
                [_db commit];
            }
        }
        [_db close];
    }
}
/**
 *  打印执行SQL语句的状态
 *
 *  @param judge    SQL语句的执行:成功(YES)/失败(NO)
 *  @param action   SQL语句的相关操作:创建/插入/查询/删除
 */
- (void)judgeDBError:(BOOL)judge action:(NSString *)action {
    if (!judge && [self.db hadError]) {
        //如果有错误,打印错误信息
//        OCMLog(@"%@失败:%@",action,[self.db lastError]);
    } else {
//        OCMLog(@"%@成功",action);
    }
}
@end
