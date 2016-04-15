//
//  MZLoopView.h
//  WangYiTest
//
//  Created by 铭铭 on 16/4/14.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MZLoopView : UIView
/** 
 *  根据URLs和titles初始化轮播器
 */
-(instancetype)initWithURls:(NSArray <NSString *> *)URLs andtitle:(NSArray <NSString *> *)title didSelected:(void (^)(NSInteger index))selected;

/**
 *  定时器间隔
 */
@property (nonatomic, assign) NSInteger timerInterval;
/**
 *  是否开启定时器
 */
@property (nonatomic, assign) BOOL enableTimer;
@end
