//
//  MZHomeViewController.m
//  WangYiTest
//
//  Created by 铭铭 on 16/4/16.
//  Copyright © 2016年 itcast. All rights reserved.


#import "MZHomeViewController.h"
#import "MZChanel.h"
#import "MZLabel.h"
#import "MZChanelCell.h"
#import "MZNewViewController.h"

@interface MZHomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
/**
 *  新闻频道数组
 */
@property (nonatomic, strong) NSArray *channels;
/**
 *  频道view
 */
@property (weak, nonatomic) IBOutlet UIScrollView *channelView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
//控制器缓存池
@property (nonatomic, strong) NSMutableDictionary *controllerCache;
/**
 *  默认显示频道标签的索引
 */
@property (nonatomic, assign) NSInteger currentIndex;
@end

@implementation MZHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     [self.navigationItem setBackBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil]];
    
    self.collectionView.dataSource=self;
    
    self.collectionView.delegate = self;
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
   [self setupChannelView];
    
   
}
/**
 *  当控制器的view布局子控件时调用,只要调用该方法,控制器view的frame就应经设置好尺寸
 */
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
     [self setFlowLayout];
}

-(void)setupChannelView
{
    self.currentIndex = 0;
    // 设置不要自动调UIScrollView整偏移量
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    CGFloat labelX = 8;
    CGFloat labelH = self.channelView.frame.size.height;
    NSInteger index = 0;
    for (MZChanel *chanel in self.channels) {
        
        MZLabel *lable = [MZLabel labelWithText:chanel.tname];
        
       
        // 设置标记
        lable.tag = index ++;
        // 设置标记
        __weak typeof(self)weakVc = self;
        __weak typeof(lable)weakLabel = lable;
    
        lable.didSelected = ^{
        
            // 设置点击之前选中label的scale为0
            MZLabel *currentLabel = weakVc.channelView.subviews[weakVc.currentIndex];
        
            currentLabel.scale = 0.0;
            
            // 设置当前点击的label的scale为1
            weakLabel.scale = 1.0;
            
            //重新复制currentIndex
            weakVc.currentIndex = weakLabel.tag;
            
            //滚动到指定的位置
            [weakVc.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:weakLabel.tag inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
            
            // 计算channalView  x方向要偏移的值
            CGFloat offset =weakLabel.center.x - weakVc.channelView.frame.size.width * 0.5;
            // 计算lable最大滚动范围
            CGFloat maxoffset = weakVc.channelView.contentSize.width - weakVc.channelView.frame.size.width;
            
            if (offset<=0) {
                offset=0;
            }else if(offset>=maxoffset)
            {
                offset = maxoffset;
            }
            
            [weakVc.channelView setContentOffset:CGPointMake(offset, 0) animated:YES];
        };
        
      
        lable.frame = CGRectMake(labelX, 0, lable.frame.size.width, labelH);
        
        [self.channelView addSubview:lable];
        
        labelX += lable.frame.size.width;
        
    }
    
    // 设置滚动范围
    self.channelView.contentSize = CGSizeMake(labelX, 0);
    self.channelView.showsHorizontalScrollIndicator = NO;
    self.channelView.showsVerticalScrollIndicator = NO;
    
     // 默认头条选中
    MZLabel *headLable = self.channelView.subviews[self.currentIndex];
    
    headLable.scale = 1.0;
}

-(void)setFlowLayout
{
    self.flowLayout.itemSize = self.collectionView.bounds.size;
    
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

    self.flowLayout.minimumInteritemSpacing=0;
    
    self.flowLayout.minimumLineSpacing=0;
    
    self.collectionView.showsHorizontalScrollIndicator=NO;
    
    self.collectionView.pagingEnabled=YES;
}


#pragma mark --UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.channels.count;

}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MZChanelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"chanelCell" forIndexPath:indexPath];
  
//    // 移除cell当前控制器的view
    [cell.newsVc.view removeFromSuperview];
    
    
    //获得频道模型
    MZChanel *channel = self.channels[indexPath.item];
    
    //根据模型的tid缓存池获得对应的控制器
    MZNewViewController *newVc =[self newVc:channel];
    

 
    // 将新闻控制器添加到当前控制器上
    // 重要:如果两个控制器的view互为父子关系,则这两个控制器也必须互为父子关系.
    if (![self.childViewControllers containsObject:newVc]) {
        [self addChildViewController:newVc];
    }
//    cell.URLString = channel.URLString;

//    cell.chanel = channel;
        cell.newsVc = newVc;
    return cell;
}

#pragma mark - UIScrollView 代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
     // 获得当前选中的频道标签
    MZLabel *currentLable = self.channelView.subviews[self.currentIndex];
    
     // 获得当前可视的items
    NSArray *indexPaths = [self.collectionView indexPathsForVisibleItems];
   
    // 下一个频道标签
    MZLabel *nextLable = nil;
   
    // 遍历数组,查找下一个频道标签
    for (NSIndexPath *indexPath in indexPaths) {
        
        if (indexPath.item != self.currentIndex) {
            
            nextLable = self.channelView.subviews[indexPath.item];
            
            break;
        }
        
    }
  // 如果没有找到下一个频道标签
    if (nextLable==nil) {
        return;
    }

    // 计算下一个频道标签的缩放比例
    
    CGFloat nextScale = ABS(self.collectionView.contentOffset.x/self.collectionView.frame.size.width - self.currentIndex);
   
    // 当前频道标签缩放比例
    CGFloat currentScale = 1 - nextScale;
    
    // 设置比例
    currentLable.scale = currentScale;
    nextLable.scale = nextScale;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 重新赋值 currentIndex属性
    self.currentIndex = scrollView.contentOffset.x / scrollView.frame.size.width;
    NSLog(@"self.currentIndex = %zd",self.currentIndex);
}

#pragma mark - 根据频道模型获得对应新闻控制器
//根据模型获得对应的控制器
-(MZNewViewController *)newVc :(MZChanel *)chanel
{
    MZNewViewController *newVc = self.controllerCache[chanel.tid];
    
    if (newVc==nil) {
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MZNew" bundle:nil];
        
        newVc = sb.instantiateInitialViewController;
        
        // 将频道URLString传递给控制器
        newVc.URLString = chanel.URLString;
        
          NSLog(@"newsVc.URLString=%@",  newVc.URLString );
        
        [self.controllerCache setObject:newVc forKey:chanel.tid];
    }
    return newVc;
}


#pragma mark -- 懒加载
-(NSArray *)channels
{
    if (_channels == nil) {
        _channels = [MZChanel channels];
    }
    return _channels;
}
-(NSMutableDictionary *)controllerCache
{
    if (_controllerCache==nil) {
        _controllerCache =[NSMutableDictionary dictionary];
    }
    return _controllerCache;
}
@end
