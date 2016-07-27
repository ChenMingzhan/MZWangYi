//
//  MZLabel.m
//  WangYiTest
//
//  Created by 铭铭 on 16/4/16.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "MZLabel.h"
#define HMNormalFontSize 14 // 普通状态下的字体
#define HMSelectedFontSize 18 // 选中状态下的字体
@implementation MZLabel

+ (instancetype)labelWithText:(NSString *)text
{
    // 创建标签
    MZLabel *label = [[MZLabel alloc] init];
    // 设置文字
    label.text = text;
    label.font = [UIFont systemFontOfSize:HMSelectedFontSize];
    // 让标签的尺寸和文字自适应
    [label sizeToFit];
    
    // 再次设置字体
    label.font = [UIFont systemFontOfSize:HMNormalFontSize];

    label.textAlignment = NSTextAlignmentCenter;
    
    label.userInteractionEnabled=YES;
    
    return label;
}


-(void)setScale:(CGFloat)scale
{

    _scale = scale;
    
    // 计算最大的缩放比例
    
    CGFloat maxScale = (CGFloat)(HMSelectedFontSize - HMNormalFontSize)/HMNormalFontSize;
    
    // 计算真实是缩放比例
    CGFloat realScale = (scale * maxScale + 1);
    
    // 通过transform进行缩放
    self.transform = CGAffineTransformMakeScale(realScale, realScale);
    // 设置颜色
    self.textColor = [UIColor colorWithRed:scale green:0 blue:0 alpha:1.0];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.didSelected) {
        
        self.didSelected();
    }

}

@end
