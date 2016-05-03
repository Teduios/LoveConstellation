//
//  CKNetworkingManager.h
//  APP
//
//  Created by tarena on 16/4/13.
//  Copyright © 2016年 CK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CKNetworkingManager : NSObject

+(void)sendRequestWithUrl:(NSString *)url
               parameters:(NSDictionary *)parameters
                  success:(void(^)(id responesObject))success
                  failure:(void(^)(NSError *error))failure;

@end
