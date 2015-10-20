//
//  TTLAriticle.m
//  TTLQiuBai
//
//  Created by Tarena on 15/10/19.
//  Copyright © 2015年 TTL. All rights reserved.
//

#import "TTLAriticle.h"


@implementation TTLAriticle



+ (NSArray *)articlesWithDict:(NSDictionary *)dict{
    NSMutableArray *array = [NSMutableArray array];
    NSArray *contents = [dict valueForKeyPath:@"items.content"];
    NSLog(@"contentsCount %ld",contents.count);
    NSArray *votes = [dict valueForKeyPath:@"items.votes"];
//    NSLog(@"votes %ld",votes.count);
    NSArray *commentsCount = [dict valueForKeyPath:@"items.comments_count"];
    NSLog(@"commentsCount %ld",commentsCount.count);
    
    NSArray *users = [dict valueForKeyPath:@"items.user"];
    NSLog(@"users %ld",users.count);
//    NSLog(@"%@",contents);
    
    for (int i = 0; i < contents.count; i++) {
        TTLAriticle *article = [[TTLAriticle alloc]init];
        article.content = contents[i];
        article.commentCount = commentsCount[i];
//        NSLog(@"%@",users[i]);
        NSDictionary *userDict = users[i];
        NSString *userName = nil;
//        if (userDict[@"login"] != NULL) {
//            userName  = userDict[@"login"];
//        }else {
//            userName = @"匿名用户";
//        }

        TTLUserInfo *user = [[TTLUserInfo alloc]initWithUserName:userName];
        article.user = user;
//        article.downCount = votes[i][@"down"];
//        article.upCount = votes[i][@"up"];
        [array addObject:article];
    }

                    

    return array;
    
}


@end
