//
//  TTLAriticle.h
//  TTLQiuBai
//
//  Created by Tarena on 15/10/19.
//  Copyright © 2015年 TTL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTLUserInfo.h"

@interface TTLAriticle : NSObject

@property (nonatomic, strong) NSString *content;

@property (nonatomic, strong) TTLUserInfo *user;


@property (nonatomic, assign) NSNumber *downCount;

@property (nonatomic, assign) NSNumber *upCount;

@property (nonatomic, assign) NSNumber *commentCount;


- (instancetype)initWithDic:(NSDictionary *)dict;

+ (instancetype)articleWithDic:(NSDictionary *)dict;

+ (NSArray *)articlesWithDict:(NSDictionary *)dict;
@end
