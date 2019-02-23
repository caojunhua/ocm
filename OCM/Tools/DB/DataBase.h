//
//  DataBase.h
//  OCM
//
//  Created by 曹均华 on 2018/3/8.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>

#define DATABASE_NAME @"ocm.db"
#define DATABASE_INSERT @"数据库插入"
#define DATABASE_CREATE @"数据库创建"
#define DATABASE_DELETE @"数据库删除"
#define DATABASE_SELECT @"数据库查询"
#define DATABASE_UPDATE @"数据库更新"
#define dbopen [_db open]
#define dbclose [_db close]

@class OCMListItem,OCMAllNetDetailItem;
@interface DataBase : NSObject
@property (nonatomic, strong) FMDatabase *db;
@property (nonatomic, strong) FMDatabaseQueue *queue;
+ (instancetype)shareInstance;
/*-----OCMListItem----*/
- (void)insertNetInfo:(OCMListItem *)item;
- (NSMutableArray *)getAllNetInfo;


/*-----OCMAllNetDetailItem----*/
- (void)insertAllNetInfo:(OCMAllNetDetailItem *)item;
- (NSMutableArray *)getSixThousandNetInfo;
//- (void)insertDetailItemArr:(NSMutableArray *)arr;
- (void)batchAddData:(NSMutableArray *)arr;
@end
