//
//  MZNetWorkTool.h
//  WangYiTest
//
//  Created by 铭铭 on 16/4/14.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface MZNetWorkTool : AFHTTPSessionManager

/**
 *  网络单例
 */
+(instancetype)shareNetWorkTool;

@end
