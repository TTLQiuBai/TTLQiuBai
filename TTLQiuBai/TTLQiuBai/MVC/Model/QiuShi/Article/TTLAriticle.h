//
//  TTLAriticle.h
//  TTLQiuBai
//
//  Created by Tarena on 15/10/19.
//  Copyright © 2015年 TTL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTLAriticle : NSObject

@property (nonatomic, strong) NSString *content;

- (instancetype)initWithDic:(NSDictionary *)dict;

+ (instancetype)articleWithDic:(NSDictionary *)dict;

+ (NSArray *)articlesWithDict:(NSDictionary *)dict;
@end
