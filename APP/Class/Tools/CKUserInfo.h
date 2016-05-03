//
//  CKUserInfo.h
//  APP
//
//  Created by tarena on 16/4/16.
//  Copyright © 2016年 CK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

@interface CKUserInfo : NSObject
singleton_interface(CKUserInfo)
/** 昵称 */
@property (nonatomic,copy)NSString *nickName;
/** 出生日期 */
@property (nonatomic,copy)NSString *userDate;
/** 用户星座 */
@property (nonatomic,copy)NSString *userConstellation;

@end
