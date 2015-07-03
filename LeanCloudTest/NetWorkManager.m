


//
//  NetWorkManager.m
//  LeanCloudTest
//
//  Created by zhougj on 15/6/9.
//  Copyright (c) 2015年 iiseeuu. All rights reserved.
//

#import "NetWorkManager.h"

@implementation NetWorkManager

+ (instancetype)shard
{
    static NetWorkManager *_shareNetWorkManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareNetWorkManager = [[NetWorkManager alloc] init];
    });
    return _shareNetWorkManager;
}

@end
