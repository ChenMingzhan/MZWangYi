//
//  MZLoopViewCell.m
//  WangYiTest
//
//  Created by 铭铭 on 16/4/14.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "MZLoopViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MZLoopViewCell()
/**
 *  新闻图片
 */
@property (nonatomic, strong) UIImageView *iconView;
@end

@implementation MZLoopViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 添加子控件
        UIImageView *iconView = [[UIImageView alloc] init];
        [self addSubview:iconView];
        self.iconView = iconView;
    }
    return self;
}

- (void)layoutSubviews {
 
    [super layoutSubviews];
    
    self.iconView.frame = self.bounds;
}

-(void)setUrl:(NSURL *)url
{
    _url = url;
    
    [self.iconView sd_setImageWithURL:url];
}

@end
