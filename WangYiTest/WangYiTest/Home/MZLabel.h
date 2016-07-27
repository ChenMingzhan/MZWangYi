//
//  MZLabel.h
//  WangYiTest
//
//  Created by 铭铭 on 16/4/16.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MZLabel : UILabel
+ (instancetype)labelWithText:(NSString *)text;

/**
 *  缩放比例 (0 到 1)
 *  0 14号字体
 *  1 18号字体
 */
@property (nonatomic, assign) CGFloat scale;


/**
 *  点击label的回调
 */
@property (nonatomic, copy) void (^didSelected)();

@end
