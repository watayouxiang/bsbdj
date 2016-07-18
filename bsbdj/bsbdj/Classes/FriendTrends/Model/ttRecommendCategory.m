//
//  ttRecommendCategory.m
//  bsbdj
//
//  Created by 王涛 on 16/7/18.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "ttRecommendCategory.h"

@implementation ttRecommendCategory

-(NSMutableArray *)users{
    if (!_users) {
        _users = [NSMutableArray array];
    }
    return _users;
}

@end
