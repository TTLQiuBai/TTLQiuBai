//
//  TTLArticleSubViewFrame.m
//  TTLQiuBai
//
//  Created by Tarena on 15/10/19.
//  Copyright © 2015年 TTL. All rights reserved.
//

#import "TTLArticleSubViewFrame.h"
#import "Constant.h"

@implementation TTLArticleSubViewFrame

- (void)setArticle:(TTLAriticle *)article {
    _article = article;
    
    // 设置头像的位置
    _iconF = CGRectMake(tNormalPadding,tNormalPadding,30, 30);
    
    // 设置名字的位置
    CGFloat x = CGRectGetMaxX(_iconF) + tNormalPadding;
    CGFloat y = tNormalPadding + 5;
    NSString *name = article.user.userName;
    CGRect rect = [name boundingRectWithSize:CGSizeMake(MAXFLOAT, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:tNameFont} context:nil];
    
    CGFloat w = rect.size.width;
    CGFloat h = rect.size.height;
    _nameF = CGRectMake(x, y, w, h);
    
    // 设置正文的位置
    x = tNormalPadding;
    y = CGRectGetMaxY(_iconF) +  tNormalPadding;
    NSString *text = article.content;
    rect = [text boundingRectWithSize:CGSizeMake(tScreenWidth - 5 * tNormalPadding, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:tTextFont} context:nil];
    w = rect.size.width;
    h = rect.size.height;
    _textF = CGRectMake(x, y, w, h);
    
    // 设置赞按钮的位置
    
    y = CGRectGetMaxY(_textF) + 2 * tNormalPadding;
    w = (tScreenWidth - 7 * tNormalPadding) / 3;
    h = _iconF.size.height;
    _diggF = CGRectMake(x, y, w, h);
    
    
    // 设置踩按钮的位置
    
    x = CGRectGetMaxX(_diggF) + tNormalPadding;
    w = (tScreenWidth - 7 * tNormalPadding) / 3;
    h = _iconF.size.height;
    _buryF = CGRectMake(x, y, w, h);
    
    
    // 设置评论按钮的位置
    
    x = CGRectGetMaxX(_buryF) + tNormalPadding;
    w = (tScreenWidth - 7 * tNormalPadding) / 3;
    h = _iconF.size.height;
    _commentF = CGRectMake(x, y, w, h);
    
    _cellHeight = CGRectGetMaxY(_commentF) + tNormalPadding;
    
}
@end
