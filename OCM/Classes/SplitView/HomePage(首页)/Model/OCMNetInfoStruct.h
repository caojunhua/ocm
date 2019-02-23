//
//  OCMNetInfoStruct.h
//  OCM
//
//  Created by 曹均华 on 2018/2/6.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import <Foundation/Foundation.h>

struct netInfoStruct {
    char *chName;            //代理点名字
    char *bossId;            //网点编号
    char *contacts;          //联系人名字
    char *rankCode;          //星级
    char *phone;             //电话
    CGFloat chLatitude;      //纬度
    CGFloat chLogngitude;    //经度
    CGFloat distance;        //距离
    char *qdid;              //渠道id
};
typedef struct netInfoStruct NetInfo;
CG_INLINE NetInfo netInfoMake(char *chName,
                              char *bossId,
                              char *contacts,
                              char *rankCode,
                              char *phone,
                              CGFloat chLatitude,
                              CGFloat chLogngitude,
                              CGFloat distance,
                              char *qdid) {
    NetInfo netInfo;
    netInfo.chName = chName;
    netInfo.bossId = bossId;
    netInfo.contacts = contacts;
    netInfo.rankCode = rankCode;
    netInfo.phone = phone;
    netInfo.chLatitude = chLatitude;
    netInfo.chLogngitude = chLogngitude;
    netInfo.distance = distance;
    netInfo.qdid = qdid;
    return netInfo;
}
@interface OCMNetInfoStruct : NSObject
@property (nonatomic, assign) NetInfo netDetailInfo;
@end
