//
//  MZNetWorkTool.m
//  WangYiTest
//
//  Created by 铭铭 on 16/4/14.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "MZNetWorkTool.h"

@implementation MZNetWorkTool

+(instancetype)shareNetWorkTool{

    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSURL *baseURl = [NSURL URLWithString:@"http://c.m.163.com/nc/ad/"];
        
        instance = [[self alloc]initWithBaseURL:baseURl];
        
    });
    return instance;
}


@end
