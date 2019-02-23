//
//  UserItem.h
//  OCM
//
//  Created by 曹均华 on 2018/1/29.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserData;

//@interface UserData : NSObject
//@property (nonatomic, copy) NSString *user;
//@property (nonatomic, copy) NSString *token;
//@end

@interface UserItem : NSObject
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, strong) UserData *data;
@property (nonatomic, copy) NSString *message;
@end

