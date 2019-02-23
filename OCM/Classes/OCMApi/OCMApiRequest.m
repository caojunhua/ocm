//
//  OCMApiRequest.m
//  OCM
//
//  Created by 曹均华 on 2018/1/29.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "OCMApiRequest.h"

@implementation OCMApiRequest
+ (instancetype)sharedOCMApiRequest {
    static OCMApiRequest *_ocmRequest = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _ocmRequest = [[OCMApiRequest alloc] init];
    });
    return _ocmRequest;
}

- (void)requestWithMethod:(RequestMethod)requestMethod andUrlString:(NSString *)urlString andParameters:(id) parameters progress:(void(^)())progress andFinished:(void(^)(id response, NSError *error))responseBlock {
    // 定义成功的block
    void (^success)(NSURLSessionDataTask *dataTask, id responseObject) = ^(NSURLSessionDataTask *dataTask,id responseObject)
    {
        responseBlock(responseObject, nil);
    };
    // 定义失败的block
    void (^failure)(NSURLSessionDataTask *dataTask,NSError *error) = ^(NSURLSessionDataTask *dataTask,NSError *error)
    {
        responseBlock(nil, error);
    };
    if (requestMethod == get) {
//        [[AFHTTPSessionManager manager] GET:urlString parameters:parameters success:success failure:failure];
        [[AFHTTPSessionManager manager] GET:urlString parameters:parameters progress:progress success:success failure:failure];
    } else {
//        [[AFHTTPSessionManager manager] POST:urlString parameters:parameters success:success failure:failure];
        [[AFHTTPSessionManager manager] POST:urlString parameters:parameters progress:progress success:success failure:failure];
    }
}

- (void)requestWithData:(NSData *)data andName:(NSString *)name andUrlString:(NSString *)urlString andParameters:(id) parameters progress:(void(^)())progress andFinished:(void(^)(id response, NSError *error))responseBlock {
    void (^success)(NSURLSessionDataTask *dataTask, id responseObject) = ^(NSURLSessionDataTask *dataTask,id responseObject)
    {
        responseBlock(responseObject, nil);
    };
    void (^failure)(NSURLSessionDataTask *dataTask,NSError *error) = ^(NSURLSessionDataTask *dataTask,NSError *error)
    {
        responseBlock(nil, error);
    };
//    [[AFHTTPSessionManager manager] POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        [formData appendPartWithFileData:data name:name fileName:@"aa" mimeType:@"application/octet-stream"];
//    } success:success failure:failure];
    [[AFHTTPSessionManager manager] POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:name fileName:@"aa" mimeType:@"application/octet-stream"];
    } progress:progress success:success failure:failure];
}
@end
