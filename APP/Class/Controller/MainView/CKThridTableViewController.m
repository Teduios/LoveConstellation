//
//  CKThridTableViewController.m
//  APP
//
//  Created by tarena on 16/4/19.
//  Copyright © 2016年 CK. All rights reserved.
//

#import "CKThridTableViewController.h"
#import "CKNetworkingManager.h"
#import "ArticleModel.h"
#import "CKDataManager.h"
#import "CKArticleDataCell.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "CKArticleViewController.h"
#import "UIScrollView+Refresh.h"
#import "MBProgressHUD+KR.h"


@interface CKThridTableViewController ()

@property (nonatomic,strong)NSArray *array;

@end

@implementation CKThridTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(showAlert)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [self requestArticleData];
    self.tableView.estimatedRowHeight = 70;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self createRefreshControl];
    
}

#pragma mark - 请求数据
-(void)requestArticleData{
    [CKNetworkingManager sendRequestWithUrl:@"http://jtbk.vipappsina.com/xingxing/v20/article.php?pad=0&markId=0" parameters:nil success:^(id responesObject) {
        self.array = [CKDataManager getAllArticleData:responesObject];
//        MYLog(@"%@",responesObject);
        [self.tableView reloadData];
    } failure:^(NSError *error) {
//        MYLog(@"%@",error);
        [MBProgressHUD showError:@"网络错误,请检查网络连接或稍后再试"];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CKArticleDataCell *cell = [tableView dequeueReusableCellWithIdentifier:@"articleCell" forIndexPath:indexPath];
    ArticleModel *articleModel = self.array[indexPath.row];
    cell.articleTitle.text = articleModel.title;
    cell.articleTime.text = articleModel.cTime;
    
    NSURL *url = [NSURL URLWithString:articleModel.pic];
//    MYLog(@"%@",url);
    [cell.articlePic sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"loading"]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    ArticleModel *articleModel = self.array[indexPath.row];
    CKArticleViewController *articleVC = [CKArticleViewController new];
    
    //push动画
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionReveal;
    transition.subtype = kCATransitionFromRight;
    transition.delegate = self;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    self.navigationController.navigationBarHidden = NO;
    
    articleVC.IDStr = articleModel.ID;
    articleVC.titleStr = articleModel.title;
    
    articleVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:articleVC animated:YES];
    articleVC.hidesBottomBarWhenPushed = NO;
}

#pragma mark - 创建刷新列表控件
-(void)createRefreshControl{
    [self tableView];
    WK(weakSelf)
    [self.tableView addHeaderRefresh:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.tableView endHeaderRefresh];
            [weakSelf requestArticleData];
        });
    }];
    [self.tableView beginHeaderRefresh];
}

#pragma mark - show Alert
-(void)showAlert{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"穿越" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self stochasticRequest];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action1];
    [alert addAction:action2];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)stochasticRequest{
    int num = (arc4random() % 10000);
    NSString *rendomNum = [NSString stringWithFormat:@"%.4d",num];
//    MYLog(@"%@",rendomNum);
    NSString *urlStr = [NSString stringWithFormat:@"http://jtbk.vipappsina.com/xingxing/v20/article.php?pad=0&markId=%@",rendomNum];
//    MYLog(@"%@",urlStr);
    [CKNetworkingManager sendRequestWithUrl:urlStr parameters:nil success:^(id responesObject) {
        self.array = [CKDataManager getAllArticleData:responesObject];
//        MYLog(@"%@",responesObject);
        [self.tableView setContentOffset:CGPointMake(0, -64) animated:YES];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
//        MYLog(@"%@",error);
        [MBProgressHUD showError:@"网络错误"];
    }];
}

@end
