//
//  MZNewViewController.m
//  WangYiTest
//
//  Created by 铭铭 on 16/4/15.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "MZNewViewController.h"
#import "MZNew.h"
#import "MZHewCell.h"
#import "MZNewDetailViewController.h"

@interface MZNewViewController ()
/**
 *  所有的新闻
 */
@property (nonatomic, strong)NSArray  *news;
@end

@implementation MZNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
  
}
-(void)setURLString:(NSString *)URLString
{
    _URLString = URLString.copy;
    
    
    NSLog(@"URLString=%@",URLString);
    
    [MZNew loadNewsDataWithURlString:URLString Success:^(NSArray *news) {
        self.news=news;
        
        [self.tableView reloadData];
        
    } andfailed:^(NSError *error) {
        
    }];
}
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    [MZNew loadNewsDataSuccess:^(NSArray *news) {
//        
//        self.news=news;
//        
//        [self.tableView reloadData];
//        
//    } andfailed:^(NSError *error) {
//        
//    }];
//}

#pragma mark -- 数据源方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.news.count;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MZNew *news = self.news[indexPath.row];
    
    MZHewCell *cell = [tableView dequeueReusableCellWithIdentifier:[MZHewCell indentifierWithNews:news] forIndexPath:indexPath];
    
    cell.news = news;
    
  
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MZNew *news = self.news[indexPath.row];
    
    return [MZHewCell cellHeight:news];

}
#pragma mark - UITableView 代理方法

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MZNew *news = self.news[indexPath.row];
    
    MZNewDetailViewController *detailVc = [[MZNewDetailViewController alloc] init];
    
    detailVc.news=news;
    
 
    
    [self.navigationController pushViewController:detailVc animated:YES];
    
    
    
    
    NSLog(@"%@", detailVc);

}


@end
