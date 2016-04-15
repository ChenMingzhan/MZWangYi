//
//  MZLoopViewFlowLayout.m
//  WangYiTest
//
//  Created by 铭铭 on 16/4/14.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "MZLoopViewFlowLayout.h"

@implementation MZLoopViewFlowLayout

-(void)prepareLayout
{
    self.itemSize =self.collectionView.bounds.size;
    
    // 设置滚动方向
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    // 设置间隔
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
}

@end
