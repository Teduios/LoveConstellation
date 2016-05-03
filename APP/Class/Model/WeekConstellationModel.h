//
//  WeekConstellationModel.h
//  APP
//
//  Created by tarena on 16/4/15.
//  Copyright © 2016年 CK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeekConstellationModel : NSObject
/** 本周健康指数 */
@property (nonatomic, copy) NSString *health;
/** 本周财运 */
@property (nonatomic, copy) NSString *money;
/** 第几周 */
@property (nonatomic, assign) NSInteger weekth;
/** 本周工作建议 */
@property (nonatomic, copy) NSString *work;
/** 时间 */
@property (nonatomic, copy) NSString *date;
/** 求职 */
@property (nonatomic, copy) NSString *job;
/** 星座名 */
@property (nonatomic, copy) NSString *name;
/** 恋情 */
@property (nonatomic, copy) NSString *love;


+(NSArray *)parseWeekConstellationData:(NSDictionary *)dic;

@end
