//
//  MZHewCell.m
//  WangYiTest
//
//  Created by 铭铭 on 16/4/15.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "MZHewCell.h"
#import "MZNew.h"
#import <SDWebImage/UIButton+WebCache.h>

@interface MZHewCell ()
/**
 *  图片
 */
@property (nonatomic, weak) IBOutlet UIButton *iconBtn;
/**
 *  标题
 */
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
/**
 *  摘要
 */
@property (nonatomic, weak) IBOutlet UILabel *digestLabel;
/**
 *  跟帖数
 */
@property (nonatomic, weak) IBOutlet UILabel *replyCountLabel;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *imageButtons;
@end

@implementation MZHewCell

-(void)setNews:(MZNew *)news
{
    _news=news;

    self.titleLabel.text = news.title;
    self.digestLabel.text = news.digest;
    self.replyCountLabel.text = [NSString stringWithFormat:@"%@跟贴",news.replyCount.description];
    
    [self.iconBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:news.imgsrc] forState:UIControlStateNormal];
    
    [news.imgextra enumerateObjectsUsingBlock:^(NSDictionary *imgDict, NSUInteger idx, BOOL * _Nonnull stop) {
         // 根据idx获得按钮
        UIButton *imageBtn = self.imageButtons[idx];
        // 获得图片URL
        NSString *URLStr = imgDict[@"imgsrc"];
         // 加载图片
        [imageBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:URLStr] forState:UIControlStateNormal];
        
    }];

}
/**
 *  根据新闻模型返回对应cell的重用标识
 */
+(NSString *)indentifierWithNews:(MZNew *)news
{
    if (news.imgextra) {
        
        return @"imageCell";
    }else if (news.imgType)
    {
        return @"bigImagecell";
    }else
    {
        return @"news";
    }

}
+(CGFloat)cellHeight:(MZNew *)news
{
    if (news.imgextra) {
        return 120;
    }else if (news.imgType)
    {
        return 170;
    }else
    {
        return 80;
    }
}
@end
