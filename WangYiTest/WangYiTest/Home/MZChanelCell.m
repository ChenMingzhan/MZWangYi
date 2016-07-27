//
//  MZChanelCell.m
//  WangYiTest
//
//  Created by 铭铭 on 16/4/16.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "MZChanelCell.h"
#import "MZNewViewController.h"
#import "MZChanel.h"

@interface MZChanelCell()

//@property (nonatomic, strong) MZNewViewController *newsVc;

@end
@implementation MZChanelCell


//-(void)awakeFromNib
//{
//
//    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MZNew" bundle:nil];
//    
//    self.newsVc = sb.instantiateInitialViewController;
//    
//    [self addSubview:self.newsVc.view];
//}

-(void)setNewsVc:(MZNewViewController *)newsVc
{
    _newsVc=newsVc;
    
    [self addSubview:newsVc.view];
}

//-(void)setChanel:(MZChanel *)chanel
//{
//    _chanel = chanel;
//    
//    self.newsVc.URLString = chanel.URLString;
//}
//-(void)setURLString:(NSString *)URLString
//{
//
//    _URLString = URLString.copy;
//    
//    self.newsVc.URLString = URLString;
//    
//}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
    
    self.newsVc.view.frame = self.bounds;
    
}
@end
