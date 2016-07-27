//
//  MZNew.h
//  WangYiTest
//
//  Created by 铭铭 on 16/4/15.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MZNew : NSObject
/**
 *  新闻标题
 */
@property (nonatomic, copy) NSString *title;
/**
 *  新闻摘要
 */
@property (nonatomic, copy) NSString *digest;
/**
 *  新闻图片
 */
@property (nonatomic, copy) NSString *imgsrc;
/**
 *  跟帖数
 */
@property (nonatomic, strong) NSNumber *replyCount;
/**
 *  多图cell的标记
 */
@property (nonatomic, strong) NSArray *imgextra;
/**
 *  大图cell的标记
 */
@property (nonatomic, assign) BOOL imgType;

/**
 *  详情url
 */
@property (nonatomic, copy) NSString *detailURLString;
/**
 *  新闻详情的标记
 */
@property (nonatomic, copy) NSString *docid;


+(instancetype)newWithDict:(NSDictionary *)dict;
/**
 *  加载新闻数据
 *
 *  @param success 成功回调
 *  @param failed  失败回调
 */
+(void)loadNewsDataWithURlString:(NSString *)URlString   Success:(void(^)(NSArray *news))success andfailed:(void(^)(NSError *))failed;
@end
