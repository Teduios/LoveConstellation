//
//  TodayConstellationModel.m
//  APP
//
//  Created by tarena on 16/4/13.
//  Copyright © 2016年 CK. All rights reserved.
//

#import "TodayConstellationModel.h"

@implementation TodayConstellationModel
//+(NSDictionary *)modelCustomPropertyMapper{
//    return @{@"dateTime":@"datetime"};
//}

+(NSArray *)parseTodayConstellationJSON:(NSDictionary *)dic{
    NSMutableArray *mutableArray = [NSMutableArray array];
    TodayConstellationModel *todayModel = [[TodayConstellationModel alloc]init];
    todayModel.name = dic[@"name"];
    todayModel.QFriend = dic[@"QFriend"];
    todayModel.all = dic[@"all"];
    todayModel.color = dic[@"color"];
    todayModel.datetime = dic[@"datetime"];
    todayModel.health = dic[@"health"];
    todayModel.love = dic[@"love"];
    todayModel.money = dic[@"money"];
    todayModel.number = [dic[@"number"] integerValue];
    todayModel.summary = dic[@"summary"];
    todayModel.work = dic[@"work"];
    [mutableArray addObject:todayModel];
//    [todayModel setValuesForKeysWithDictionary:dic];
    return mutableArray;
}

@end
