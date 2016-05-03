//
//  MatchingModel.m
//  APP
//
//  Created by tarena on 16/4/15.
//  Copyright © 2016年 CK. All rights reserved.
//

#import "MatchingModel.h"

@implementation MatchingModel

+(NSArray *)parseMatchingJSON:(NSDictionary *)dic{
    NSMutableArray *array = [NSMutableArray array];
    MatchingModel *model = [MatchingModel new];
    model.content1 = dic[@"content1"];
    model.content2 = dic[@"content2"];
    [array addObject:model];
    return array;
}

@end


