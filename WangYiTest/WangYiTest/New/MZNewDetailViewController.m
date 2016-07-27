//
//  MZNewDetailViewController.m
//  WangYiTest
//
//  Created by 铭铭 on 16/4/19.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "MZNewDetailViewController.h"
#import "MZNew.h"
#import "MZNetWorkTool.h"

@interface MZNewDetailViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

/**
 *  详情数据
 */
//@property (nonatomic, strong) NSDictionary *data;

/**
 *  内容
 */
@property (nonatomic, copy) NSString *body;
/**
 *  新闻标题
 */
@property (nonatomic, copy) NSString *newsTitle;
/**
 *  时间和来源
 */
@property (nonatomic, copy) NSString *timeAndSource;

@end

@implementation MZNewDetailViewController


-(void)loadView
{
    self.webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.webView.backgroundColor = [UIColor whiteColor];
    
    self.view=self.webView;
     self.webView.delegate = self;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
   
    [self loadData];
}

/**
 *  加载新闻详情
 */
-(void)loadData
{
    [[MZNetWorkTool shareNetWorkTool] GET:self.news.detailURLString parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * responseObject) {
        
         NSLog(@"responseObject = %@",responseObject);
        // rootKey
        NSString *rootKey = responseObject.keyEnumerator.nextObject;
        NSDictionary *dict = responseObject[rootKey];
        
        // 获得body内容
        self.body = dict[@"body"];
        // 获得时间和来源
        self.timeAndSource = [NSString stringWithFormat:@"%@  %@",dict[@"ptime"],dict[@"source"]];
        //获得标题
        self.newsTitle = dict[@"title"];
        
//          获得新闻图片
        NSArray *imgs= dict[@"img"];
        for (NSDictionary *img in imgs) {
            // 获得ref
            NSString *ref = img[@"ref"];
            // 获得图片的URLString
            NSString *imgURL = img[@"src"];
            // 获得alt
            NSString *alt = img[@"alt"];
            // img标签内容
            NSString *imgTag = [NSString stringWithFormat:@"<img src=\"%@\" width=100%%/> <br /> <span style=\"color: gray;font-size: 15px\">%@</span>",imgURL,alt];
            
            self.body = [self.body stringByReplacingOccurrencesOfString:ref withString:imgTag];
            
        }
        // 获得视频
        NSArray *videos = dict[@"video"];
        for (NSDictionary *video in videos) {
            // 获得ref
            NSString *ref = video[@"ref"];
            // 获得alt
            NSString *alt = video[@"alt"];
            // 视频文件
            NSString *mp4_url = video[@"url_mp4"];
            // 获得封面
            NSString *cover = video[@"cover"];
            
            // 获得video标签字符串
            NSString *videoTag = [NSString stringWithFormat:@"<video width=\"100%%\" height=200px controls poster=\"%@\"> <source src=\"%@\" type=\"video/mp4\"> </video> <br /> <span style=\"color: gray;font-size: 15px\">%@</span>",cover,mp4_url,alt];
            // 将body中的ref替换成videoTag
            self.body = [self.body stringByReplacingOccurrencesOfString:ref withString:videoTag];
        }
        
        
        
        // 加载网页文件
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"detail.html" ofType:nil]]]];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        
    }];
   

}
#pragma mark - webView代理方法
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *js = [NSString stringWithFormat:@"changeContent('%@','%@','%@')",self.newsTitle,self.timeAndSource,self.body];
    
    [webView stringByEvaluatingJavaScriptFromString:js];

}

@end
