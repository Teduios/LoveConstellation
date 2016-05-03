//
//  MatchingModel.h
//  APP
//
//  Created by tarena on 16/4/15.
//  Copyright © 2016年 CK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MatchingModel : NSObject

@property (nonatomic, copy) NSString *content1;

@property (nonatomic, copy) NSString *content2;


+(NSArray *)parseMatchingJSON:(NSDictionary *)dic;

@end

