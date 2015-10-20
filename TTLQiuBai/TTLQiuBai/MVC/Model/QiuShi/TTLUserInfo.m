//
//  TTLUserInfo.m
//  TTLQiuBai
//
//  Created by Tarena on 15/10/19.
//  Copyright © 2015年 TTL. All rights reserved.
//

#import "TTLUserInfo.h"

@implementation TTLUserInfo
- (instancetype)initWithUserName:(NSString *)userName {
    if (self = [super init]) {
        self.userName = userName;
        self.userIcon = @"commenticon_textpage_press";
    }
    return self;
}
@end
