//
//  MZHeadLine.m
//  WangYiTest
//
//  Created by 铭铭 on 16/4/14.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "MZHeadLine.h"
#import "MZNetWorkTool.h"

@implementation MZHeadLine

+(instancetype)headLineWithDic:(NSDictionary *)dic
{
    id obj = [[self alloc]init];
    
    [obj setValuesForKeysWithDictionary:dic];

    return obj;
}

+(void)headLineWithSuccess:(void (^)(NSArray *))sucess failed:(void (^)(NSError *))failed
{
    [[MZNetWorkTool shareNetWorkTool] GET:@"headline/0-4.html" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task,NSDictionary * responseObject) {
        
//        NSLog(@"%@--",responseObject);
        
      // 获得字典的第一个key
        NSString *rootkey = responseObject.keyEnumerator.nextObject;
//        NSLog(@"rootkey==%@",rootkey);
        
        // 根据key获得数组
        NSArray * headLine = responseObject[rootkey];
        
//        NSLog(@"%@",headLine);
        
        NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:headLine.count];
        
        [headLine enumerateObjectsUsingBlock:^(NSDictionary * dic, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [arrayM addObject:[MZHeadLine headLineWithDic:dic]];
        }];
        
        //回调结果
        if (sucess) {
           sucess(arrayM.copy);   
        }
    
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failed) {
            failed(error);
        }
        
    }];


}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{};
@end
