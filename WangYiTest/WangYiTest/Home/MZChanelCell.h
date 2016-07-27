//
//  MZChanelCell.h
//  WangYiTest
//
//  Created by 铭铭 on 16/4/16.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MZChanel;
@class MZNewViewController;
@interface MZChanelCell : UICollectionViewCell

/**
 *  频道新闻
 */
//@property (nonatomic, copy) NSString *URLString;

//@property (nonatomic, strong) MZChanel *chanel;
/**
 *  接收外界的控制器
 */
@property (nonatomic, strong) MZNewViewController *newsVc;
@end
