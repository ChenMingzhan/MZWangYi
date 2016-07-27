//
//  MZNew.m
//  WangYiTest
//
//  Created by 铭铭 on 16/4/15.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "MZNew.h"
#import "MZNetWorkTool.h"
@implementation MZNew
+(instancetype)newWithDict:(NSDictionary *)dict
{
//    NSLog(@"dict: %@", dict);
    MZNew *obj = [[self alloc] init];
    [obj setValuesForKeysWithDictionary:dict];
    if (obj.replyCount == nil) {
        obj.replyCount = @(0);
    }
    return obj;
    
}



+(void)loadNewsDataWithURlString:(NSString *)URlString Success:(void (^)(NSArray *))success andfailed:(void (^)(NSError *))failed
{

    [[MZNetWorkTool shareNetWorkTool] GET:URlString parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary* responseObject) {
        
        NSString *rootkey = responseObject.keyEnumerator.nextObject;
        
        NSArray *news = responseObject[rootkey];
        
        NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:news.count];
        
        [news enumerateObjectsUsingBlock:^(NSDictionary * dict, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [arrayM addObject:[MZNew newWithDict:dict]];
            
        }];
        
        if (success) {
            success(arrayM.copy);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failed) {
            failed(error);
        }
    }];


}
- (void)setDocid:(NSString *)docid {
    _docid = docid.copy;
    _detailURLString = [NSString stringWithFormat:@"/nc/article/%@/full.html",docid];
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{};
@end
