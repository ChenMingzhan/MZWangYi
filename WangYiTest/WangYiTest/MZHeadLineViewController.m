//
//  MZHeadLineViewController.m
//  WangYiTest
//
//  Created by 铭铭 on 16/4/14.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "MZHeadLineViewController.h"
#import "MZNetWorkTool.h"
#import "MZHeadLine.h"
#import "MZLoopView.h"
@interface MZHeadLineViewController ()
/**
 *   新闻头条数组
 */
@property (nonatomic, strong) NSArray *headline;

@end

@implementation MZHeadLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 加载头条数据
    [MZHeadLine headLineWithSuccess:^(NSArray *headLine) {
      if(headLine.count == 0)return;
//        // 图片数组
        NSArray *imgs = [headLine valueForKeyPath:@"imgsrc"];
//
//        NSLog(@"%@",imgs);
//        //新闻标题
        NSArray *titles = [headLine valueForKeyPath:@"title"];
        
        MZLoopView *loopView = [[MZLoopView alloc] initWithURls:imgs andtitle:titles didSelected:^(NSInteger index) {
            
             NSLog(@"index = %@",headLine[index]);
        }];;
        
        
        loopView.frame = self.view.bounds;
        
        [self.view addSubview:loopView];
        
    } failed:^(NSError *error) {
        
    }];

}





@end
