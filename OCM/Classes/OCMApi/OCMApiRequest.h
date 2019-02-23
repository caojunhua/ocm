//
//  OCMApiRequest.h
//  OCM
//
//  Created by 曹均华 on 2018/1/29.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "AFHTTPSessionManager.h"

typedef NS_ENUM(NSUInteger, OCMApiRequestStatusCode) {
    OCMApiRequestStatusCodeGETSuccess        =  200,
    OCMApiRequestStatusCodePOSTSuccess       =  201,
    
    OCMApiRequestStatusCodeBadSuccess        =  400,
    OCMApiRequestStatusCodeUnauthorized      =  401,
    OCMApiRequestStatusCodeForbidden         =  403,
    OCMApiRequestStatusCodeNotFound          =  404,
    
    OCMApiRequestStatusCodeServerError       =  500
};
typedef NS_ENUM(NSInteger, RequestMethod)
{
    post,
    get
};

@interface OCMApiRequest : AFHTTPSessionManager
+ (instancetype)sharedOCMApiRequest;

/**
 * requestMethod:请求方式
 * urlString:请求地址
 * parameters:请求参数
 * responseBlock:请求成功或失败的回调
 */

//- (void)requestWithMethod:(RequestMethod)requestMethod andUrlString:(NSString *)urlString andParameters:(id) parameters andFinished:(void(^)(id response, NSError *error))responseBlock;
- (void)requestWithMethod:(RequestMethod)requestMethod andUrlString:(NSString *)urlString andParameters:(id) parameters progress:(void(^)())progress andFinished:(void(^)(id response, NSError *error))responseBlock;

/**
 * data:上传资料
 * name:上传资料的名字
 * urlString:请求地址
 * parameters:请求参数
 * responseBlock:请求成功或失败的回调
 */

//- (void)requestWithData:(NSData *)data andName:(NSString *)name andUrlString:(NSString *)urlString andParameters:(id) parameters andFinished:(void(^)(id response, NSError *error))responseBlock;
- (void)requestWithData:(NSData *)data andName:(NSString *)name andUrlString:(NSString *)urlString andParameters:(id) parameters progress:(void(^)())progress andFinished:(void(^)(id response, NSError *error))responseBlock;
@end

