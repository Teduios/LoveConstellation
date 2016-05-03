//
//  CKDataManager.m
//  APP
//
//  Created by tarena on 16/4/13.
//  Copyright © 2016年 CK. All rights reserved.
//

#import "CKDataManager.h"
#import "MatchingModel.h"
#import "ArticleModel.h"

@implementation CKDataManager

+(NSArray *)getAlltodayData:(id)responesObject{
    
    NSArray *todayModel = [TodayConstellationModel parseTodayConstellationJSON:responesObject];
    return todayModel;
}

+(NSArray *)getAllWeekData:(id)responesObject{
    NSArray *weekModel = [WeekConstellationModel parseWeekConstellationData:responesObject];
    return weekModel;
}

+(NSArray *)getAllMatchingData:(id)responesObject{
    NSDictionary *dic = responesObject[@"result"];
    NSArray *matchingModel = [MatchingModel parseMatchingJSON:dic];
    return matchingModel;
}

+(NSArray *)getAllArticleData:(id)responesObject{
    NSArray *array = responesObject;
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        ArticleModel *model = [ArticleModel parseArticleJSON:dic];
        [mutableArray addObject:model];
    }
    return mutableArray;
}

@end
