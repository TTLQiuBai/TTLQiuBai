//
//  TTLAriticle.m
//  TTLQiuBai
//
//  Created by Tarena on 15/10/19.
//  Copyright © 2015年 TTL. All rights reserved.
//

#import "TTLAriticle.h"


@implementation TTLAriticle

- (instancetype)initWithDic:(NSDictionary *)dict {
    if (self = [super init]) {
        self.downCount = dict[@"votes"][@"down"];
        self.upCount = dict[@"votes"][@"up"];
        self.content = dict[@"content"];
        self.commentCount = dict[@"comments_count"];
        NSDictionary *userDic = dict[@"user"];
        NSLog(@"%@",userDic);
        NSString *userName = @"匿名用户";
        if (![userDic isEqual:[NSNull null]]) {
            
            userName = userDic[@"login"];
        }
        TTLUserInfo *user = [[TTLUserInfo alloc]initWithUserName:userName];
        self.user = user;
        
    }
    return self;
}

+ (NSArray *)articlesWithDict:(NSDictionary *)dict{
    NSMutableArray *array = [NSMutableArray array];
    NSArray *items = dict[@"items"];
    
    for (NSDictionary *item in items) {
      TTLAriticle *article =  [[self alloc]initWithDic:item];
        [array addObject:article];
    }
    
    return array;
    
}


@end
