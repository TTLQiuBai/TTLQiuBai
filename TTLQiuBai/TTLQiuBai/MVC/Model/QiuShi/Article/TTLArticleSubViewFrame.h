//
//  TTLArticleSubViewFrame.h
//  TTLQiuBai
//
//  Created by Tarena on 15/10/19.
//  Copyright © 2015年 TTL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TTLAriticle.h"

@interface TTLArticleSubViewFrame : NSObject

// 发布人头像
@property (nonatomic, assign) CGRect iconF;

// 发布人昵称
@property (nonatomic, assign) CGRect nameF;

//正文
@property (nonatomic, assign) CGRect textF;

// 赞
@property (nonatomic, assign) CGRect diggF;

// 踩
@property (nonatomic, assign) CGRect buryF;

// 评论
@property (nonatomic, assign) CGRect commentF;

// 引入模型,所有控件的尺寸都根据模型来计算
@property (nonatomic, strong) TTLAriticle *article;

// 行高
@property (nonatomic, assign) CGFloat cellHeight;

// 热门
@property (nonatomic, assign) CGRect hotF;

// 数组用于存放所有模型的大小
+ (NSArray *)articleFrame;

@end
