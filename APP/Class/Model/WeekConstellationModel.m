//
//  WeekConstellationModel.m
//  APP
//
//  Created by tarena on 16/4/15.
//  Copyright © 2016年 CK. All rights reserved.
//

#import "WeekConstellationModel.h"

@implementation WeekConstellationModel

+(NSArray *)parseWeekConstellationData:(NSDictionary *)dic{
    NSMutableArray *mutableArray = [NSMutableArray array];
    WeekConstellationModel *model = [WeekConstellationModel new];
    model.date = dic[@"data"];
    model.name = dic[@"name"];
    model.health = dic[@"health"];
    model.job = dic[@"job"];
    model.love = dic[@"love"];
    model.money = dic[@"money"];
    model.weekth = [dic[@"weekth"] integerValue];
    model.work = dic[@"work"];
    [mutableArray addObject:model];
    return mutableArray;
}

@end
