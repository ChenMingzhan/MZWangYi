//
//  MZHeadLine.h
//  WangYiTest
//
//  Created by 铭铭 on 16/4/14.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MZHeadLine : NSObject

/**
 *  头条新闻
 */
@property (nonatomic, copy) NSString *title;

/**
 *  头条图片
 */
@property (nonatomic, copy) NSString *imgsrc;


+(instancetype)headLineWithDic:(NSDictionary *)dic;


/**
 *  加载新闻头条数据
 *
 *  @param success 成功回调
 *  @param failed  失败回调
 */
+(void)headLineWithSuccess:(void(^)(NSArray *headLine))sucess failed:(void(^)(NSError *))failed;

@end
