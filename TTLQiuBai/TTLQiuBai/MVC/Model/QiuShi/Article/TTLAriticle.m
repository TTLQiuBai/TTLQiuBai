//
//  TTLAriticle.m
//  TTLQiuBai
//
//  Created by Tarena on 15/10/19.
//  Copyright © 2015年 TTL. All rights reserved.
//

#import "TTLAriticle.h"

@implementation TTLAriticle



+ (NSArray *)articlesWithDict:(NSDictionary *)dict {
    NSMutableArray *array = [NSMutableArray array];
    NSArray *contents = [dict valueForKeyPath:@"items.content"];
    NSLog(@"%@",contents);
    
    for (NSString *content in contents) {
      TTLAriticle *article = [[TTLAriticle alloc]init];
        article.content = content;
        [array addObject:article];
    }
    
    return array;
    
}


@end
