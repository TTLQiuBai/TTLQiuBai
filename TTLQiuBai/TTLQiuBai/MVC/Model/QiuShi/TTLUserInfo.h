//
//  TTLUserInfo.h
//  TTLQiuBai
//
//  Created by Tarena on 15/10/19.
//  Copyright © 2015年 TTL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTLUserInfo : NSObject
// 用户名
@property (nonatomic, strong) NSString *userName;

// 用户头像
@property (nonatomic, strong) NSString *userIcon;


- (instancetype)initWithUserName:(NSString *) userName;

@end
