//
//  CKDataManager.h
//  APP
//
//  Created by tarena on 16/4/13.
//  Copyright © 2016年 CK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TodayConstellationModel.h"
#import "WeekConstellationModel.h"
#import "MatchingModel.h"

@interface CKDataManager : NSObject

+ (NSArray *)getAlltodayData:(id)responesObject;

+ (NSArray *)getAllWeekData:(id)responesObject;

+ (NSArray *)getAllMatchingData:(id)responesObject;

+ (NSArray *)getAllArticleData:(id)responesObject;
@end
