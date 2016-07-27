//
//  MZHewCell.h
//  WangYiTest
//
//  Created by 铭铭 on 16/4/15.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MZNew;

@interface MZHewCell : UITableViewCell

@property (nonatomic, strong) MZNew *news;
/**
 *  根据新闻模型返回对应cell的重用标识
 */
+(NSString *)indentifierWithNews:(MZNew *)news;
/**
 *  根据模型返回对应的行高
 */
+(CGFloat)cellHeight:(MZNew *)news;
@end
