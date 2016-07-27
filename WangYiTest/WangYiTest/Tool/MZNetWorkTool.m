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

    static MZNetWorkTool *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
//        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        //manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
//        AFXMLParserResponseSerializer *searializer = [AFXMLParserResponseSerializer serializer];
        
//        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
//        searializer.acceptableContentTypes =
        
//        acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", nil];
        
        NSURL *baseURl = [NSURL URLWithString:@"http://c.m.163.com/nc/ad/"];
        
        instance = [[self alloc]initWithBaseURL:baseURl];
        
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];

        
//        NSLog(@"%p--%p",instance,manager);
        
    });
    return instance;
}


@end
