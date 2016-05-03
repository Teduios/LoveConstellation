//
//  CKarticleViewController.m
//  APP
//
//  Created by tarena on 16/4/19.
//  Copyright © 2016年 CK. All rights reserved.
//

#import "CKArticleViewController.h"

@interface CKArticleViewController ()


@property (nonatomic,strong)UIWebView *webView;
@end

@implementation CKArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
//    self.hidesBottomBarWhenPushed = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = self.titleStr;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self createWebView];
    [self createLeftItem];

}

-(void)createWebView{
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:SCREEN_BOUNDS];
    self.webView = webView;
    
    NSString *urlStr = [NSString stringWithFormat:@"http://jtbk.vipappsina.com/xingxing/v20/articleDetail.php?id=%@",self.IDStr];
//    MYLog(@"%@",urlStr);
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.view addSubview:webView];
    [webView loadRequest:request];
    [self reloadInputViews];
}

-(void)createLeftItem{
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(clickBackBtn)];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(clickBackBtn)];
    self.navigationItem.leftBarButtonItem = leftItem;
}

-(void)clickBackBtn{
    CATransition *transition = [CATransition animation];
    
    //返回动画
    transition.duration =0.4;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionReveal;
    //transition.subtype = kCATransitionFromBottom;
    transition.delegate = self;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
