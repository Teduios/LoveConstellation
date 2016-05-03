//
//  TodayConstellationModel.h
//  APP
//
//  Created by tarena on 16/4/13.
//  Copyright © 2016年 CK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TodayConstellationModel : NSObject
/** 当日财运 */
@property (nonatomic, copy) NSString *money;
/** 当日工作运势 */
@property (nonatomic, copy) NSString *work;
/** 当日幸运色 */
@property (nonatomic, copy) NSString *color;
/** 当日爱情指数 */
@property (nonatomic, copy) NSString *love;
/** 当日契合星座 */
@property (nonatomic, copy) NSString *QFriend;
/** 当日健康指数 */
@property (nonatomic, copy) NSString *health;
/** 当日幸运数 */
@property (nonatomic, assign) NSInteger number;
/** 当日运势 */
@property (nonatomic, copy) NSString *all;
/** 当日概要 */
@property (nonatomic, copy) NSString *summary;
/** 星座名 */
@property (nonatomic, copy) NSString *name;
/** 当日时间 */
@property (nonatomic, copy) NSString *datetime;


+(NSArray *)parseTodayConstellationJSON:(NSDictionary *)dic;
@end
