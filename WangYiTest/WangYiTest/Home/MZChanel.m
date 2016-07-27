//
//  MZChanel.m
//  WangYiTest
//
//  Created by 铭铭 on 16/4/16.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "MZChanel.h"

@implementation MZChanel

+(instancetype)chanelWithDict:(NSDictionary *)dict
{
    id obj = [[self alloc]init];

    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;

}

-(void)setTid:(NSString *)tid
{
    _tid = tid.copy;
    
    self.URLString = [NSString stringWithFormat:@"/nc/article/headline/%@/0-20.html",tid];

}

/**
 *  返回所有的频道数据
 */
+ (NSArray *)channels{
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"topic_news.json" ofType:nil];
    
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    
    NSString *rootkey = dict.keyEnumerator.nextObject;
    
    NSArray *chanelArray = dict[rootkey];
    
    NSMutableArray *chanelM = [NSMutableArray arrayWithCapacity:chanelArray.count];
    
    [chanelArray enumerateObjectsUsingBlock:^(NSDictionary * dict, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [chanelM addObject:[MZChanel chanelWithDict:dict]];
    }];
    
     // 排序
    chanelM = [chanelM sortedArrayUsingComparator:^NSComparisonResult(MZChanel *obj1, MZChanel *obj2) {
        
        return [obj1.tid compare:obj2.tid];
    
    }].copy;
    
 
    return chanelM;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{};

@end
