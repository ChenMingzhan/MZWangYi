//
//  MZChanel.h
//  WangYiTest
//
//  Created by 铭铭 on 16/4/16.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MZChanel : NSObject
/**
 *  频道名称
 */
@property (nonatomic, copy) NSString *tname;
/**
 *  频道id
 */
@property (nonatomic, copy) NSString *tid;

/**
 *  频道新闻
 */
@property (nonatomic, copy) NSString *URLString;


+(instancetype)chanelWithDict:(NSDictionary *)dict;


/**
 *  返回所有的频道数据
 */
+ (NSArray *)channels;
@end
