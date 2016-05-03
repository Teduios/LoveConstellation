//
//  ArticleModel.m
//  APP
//
//  Created by tarena on 16/4/19.
//  Copyright © 2016年 CK. All rights reserved.
//

#import "ArticleModel.h"

@implementation ArticleModel

+(instancetype)parseArticleJSON:(NSDictionary *)dic{
//    NSMutableArray *array = [NSMutableArray array];
    ArticleModel *model = [ArticleModel new];
    model.title = dic[@"title"];
    model.cTime = dic[@"cTime"];
    model.ID = dic[@"id"];
    model.pic = dic[@"pic"];
//    [array addObject:model];
    return model;
}

@end


