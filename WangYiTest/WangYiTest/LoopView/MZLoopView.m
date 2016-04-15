//
//  MZLoopView.m
//  WangYiTest
//
//  Created by 铭铭 on 16/4/14.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "MZLoopView.h"
#import "MZLoopViewFlowLayout.h"
#import "MZLoopViewCell.h"

@interface MZLoopView ()<UICollectionViewDataSource,UICollectionViewDelegate>
/**
 *  图片数组
 */
@property (nonatomic, strong) NSArray *URLs;

/**
 *  新闻标题数组
 */
@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, weak) UICollectionView *collectionView;
/**
 *   标题
 */
@property (nonatomic, weak) UILabel *titleLable;
/**
 *  分页
 */
@property (nonatomic, weak) UIPageControl *pageControl;
/**
 *  定时器
 */
@property (nonatomic, strong) NSTimer *timer;
/**
 *  选中的回调
 */
@property (nonatomic, copy) void (^didSelected)(NSInteger index);
@end


@implementation MZLoopView



/*
*  根据URLS和titles初始化轮播器
*/
-(instancetype)initWithURls:(NSArray <NSString *> *)URLs andtitle:(NSArray <NSString *> *)title didSelected:(void (^)(NSInteger index))selected
{
    if (self = [super init]) {
        self.URLs = URLs;
        self.titles = title;
        self.didSelected = selected;
         // 设置总页数
        self.pageControl.numberOfPages = self.URLs.count;
        //设置标题
        self.titleLable.text = self.titles[0];
       // 滚动到数组个数指定的位置
        dispatch_async(dispatch_get_main_queue(), ^{
            
        //如果需要滚到到某个位置，那么就需要先创建好这个位置的cell:创建cell
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.URLs.count inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
            
            [self addtimer];
        });
  
    }
    return self;
}
/**
 *  当对象从文件(xib.sb以及任何文件)中创建的时候调用
 */
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
        [self setup];
    }
    return self;
}
/**
 *  当创建控件时,调用init方法初始化,其内部会调用initWithFrame
 */
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
     
          [self setup];
    }
    return self;
}


-(void)setup
{
   //创建UICollectIonView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[MZLoopViewFlowLayout alloc] init]];
    // 设置分页效果
    collectionView.pagingEnabled = YES;
    // 隐藏水平滚动条
    collectionView.showsHorizontalScrollIndicator = NO;
    // 注册cell
    [collectionView registerClass:[MZLoopViewCell class] forCellWithReuseIdentifier:@"loopCell"];
    // 设置背景颜色
    collectionView.backgroundColor = [UIColor whiteColor];
    // 设置数据源
    collectionView.dataSource = self;
    
    collectionView.delegate = self;
    
    [self addSubview:collectionView];
    
    self.collectionView = collectionView;
    
    //创建UILAble
    UILabel *titleLable = [[UILabel alloc] init];
    
    titleLable.textColor = [UIColor grayColor];
    
    titleLable.font = [UIFont systemFontOfSize:16];
    
    [self addSubview:titleLable];
    self.titleLable = titleLable;
    
    //创建UIpageControl
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    
    [self addSubview:pageControl];
    self.pageControl=pageControl;
    
    // 默认2秒自动滚到下一张
    self.timerInterval = 2;
    self.enableTimer = YES;
}

#pragma mark -- 布局collectionview
-(void)layoutSubviews
{
    [super layoutSubviews];

    CGFloat titleH = 30.0f;
    CGRect frame = self.bounds;
    frame.size.height-= titleH;
  
   self.collectionView.frame = frame;
    
    CGFloat marginX = 20;
    
    // 设置pageControl
    CGFloat pageW = 40;
    CGFloat pageX = frame.size.width - pageW - marginX;
    CGFloat pageY = self.collectionView.frame.size.height;
    CGFloat pageH = titleH;
    self.pageControl.frame = CGRectMake(pageX, pageY, pageW, pageH);
    
    // 标题
    CGFloat titleX = marginX * 0.5;
    CGFloat titleY = pageY;
    CGFloat titleW = pageX - titleX;
    self.titleLable.frame = CGRectMake(titleX, titleY, titleW, titleH);
   
}

#pragma mark--添加定时器
/**
 *  添加定时器方法
 */
-(void)addtimer
{
    if (self.timer) return;
    if (!self.enableTimer) return;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.timerInterval target:self selector:@selector(update) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}

-(void)update
{  // 计算当前页号
    NSInteger page = (CGFloat)self.collectionView.contentOffset.x/ self.collectionView.frame.size.width;
    
    CGFloat offsetX = (page +1)*self.collectionView.frame.size.width;
    //如果需要真行偏移，那么就需要先创建到偏移位置的cell:创建cell
    [self.collectionView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}
/**
 *  移除定时器
 */
- (void)remoVeTimer {
    [self.timer invalidate];
    self.timer = nil;
}
#pragma mark  -- UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.URLs.count * 3;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MZLoopViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"loopCell" forIndexPath:indexPath];
    
     // 传递url
    cell.url = [NSURL URLWithString:self.URLs[indexPath.item % self.URLs.count]];
    
  
    
    return cell;

}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 获得索引
    NSInteger index = indexPath.item % self.URLs.count;
    
    if (self.didSelected) {
        
        self.didSelected(index);
    }
}
#pragma mark - UIScrollView 代理方法
/**
 *  当开始拖拽时调用
 */
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self remoVeTimer];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 计算页号
    NSInteger page =  (CGFloat)scrollView.contentOffset.x / scrollView.frame.size.width + 0.5;
    
    // 根据页号获得标题
    self.titleLable.text = self.titles[page % self.titles.count];
    self.pageControl.currentPage = page % self.URLs.count;
}

/**
 *  手动拖拽即将停止时调用
 */
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
      // 获得当前显示的页号
    NSInteger page = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    if (page==0 || page==[self.collectionView numberOfItemsInSection:0]-1) {
        
        CGFloat offsetX = (self.URLs.count - ((page == 0) ? 0:1))* scrollView.frame.size.width;
        
        self.collectionView.contentOffset = CGPointMake(offsetX, 0);
    }
//    if (page == 0) {
//        
//        self.collectionView.contentOffset = CGPointMake(self.URLs.count * scrollView.frame.size.width, 0);
//    }
    // 开启定时器
    [self addtimer];
}
/**
 *  自动滚动结束时调用(手动拖拽不会触发该代理方法)
 */
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self scrollViewDidEndDecelerating:scrollView];

}

- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
    
    [self remoVeTimer];
}
@end

