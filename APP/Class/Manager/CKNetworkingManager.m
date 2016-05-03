//
//  CKNetworkingManager.m
//  APP
//
//  Created by tarena on 16/4/13.
//  Copyright © 2016年 CK. All rights reserved.
//

#import "CKNetworkingManager.h"
#import "AFNetworking.h"
#import "MBProgressHUD+KR.h"

@implementation CKNetworkingManager

+(void)sendRequestWithUrl:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    
}

@end
