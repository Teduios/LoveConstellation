//
//  CKLeftViewController.m
//  APP
//
//  Created by tarena on 16/3/26.
//  Copyright © 2016年 CK. All rights reserved.
//

#import "CKLeftViewController.h"
#import "CKSetTableViewController.h"
#import "CKMineViewController.h"

#define CELL_HEIGHT 50
#define CELL_COUNT 5

@interface CKLeftViewController ()<UITableViewDataSource,UITableViewDelegate>

/** 储存cell的文字 */
@property (nonatomic,strong)NSArray *CellTextArray;

@property (nonatomic,strong)UIImageView *imageView;

@property (nonatomic,strong)UILabel *userNameLabel;

@end

CGFloat cellHeight = 50;

@implementation CKLeftViewController

#pragma mark -懒加载
-(NSArray *)CellTextArray{
    if (!_CellTextArray) {
        _CellTextArray = @[@"设置",@"版本号",@"关于"];
    }
    return _CellTextArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];
//    [self createMenuView];

}
/*
- (void)createMenuView{
    //创建view
    UIView *menuView = [[UIView alloc]initWithFrame:CGRectMake(0, (SCREEN_HEIGHT-CELL_COUNT*CELL_HEIGHT) * 0.7 - 150,SCREEN_WIDTH*0.6 , 150)];
    menuView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:menuView];
    
    //创建imageView;
    if (!self.imageView) {
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(menuView.bounds.size.width/2-30, 20, 60, 60)];
        self.imageView.image = [UIImage imageNamed:@"user02"];
    }
    self.imageView.layer.cornerRadius = 30;
    [menuView addSubview:self.imageView];
    
    //创建用户名Label
    if (!self.userNameLabel) {
        self.userNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.imageView.frame.origin.y + 80, menuView.bounds.size.width, 30)];
        self.userNameLabel.text = @"猴子家的小逗比";
        self.userNameLabel.textAlignment = NSTextAlignmentCenter;
        self.userNameLabel.font = [UIFont systemFontOfSize:18];
    }
    [menuView addSubview:self.userNameLabel];
}
*/
#pragma mark -创建tableView
- (void)createTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, (SCREEN_HEIGHT-CELL_COUNT*CELL_HEIGHT) * 0.5, SCREEN_WIDTH*0.6, CELL_HEIGHT*CELL_COUNT)];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.CellTextArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.detailTextLabel.textColor = [UIColor grayColor];
//        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.row == 1){
        cell.detailTextLabel.text = @"1.0";
    }
    cell.textLabel.text = self.CellTextArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        return CELL_HEIGHT;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        
//        CKSetTableViewController *setVC = [[CKSetTableViewController alloc]init];
        CKSetTableViewController *setVC = [self.storyboard instantiateViewControllerWithIdentifier:@"setVC"];
        UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:setVC];
        
        //设置present的动画
        CATransition *animation = [CATransition animation];
        animation.duration = 1.0;
        animation.timingFunction = UIViewAnimationCurveEaseInOut;
        animation.type = @"rippleEffect";
        animation.subtype = kCATransitionFromRight;
        [self.view.window.layer addAnimation:animation forKey:nil];
        
        [self presentViewController:navi animated:YES completion:nil];
    }else if (indexPath.row == 2){
        CKMineViewController *mVC = [self.storyboard instantiateViewControllerWithIdentifier:@"mineVC"];
        UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:mVC];
        
        CATransition *animation = [CATransition animation];
        animation.duration = 0.5;
        animation.timingFunction = UIViewAnimationCurveEaseInOut;
        animation.type = kCATransitionReveal;
        animation.subtype = kCATransitionFromTop;
        [self.view.window.layer addAnimation:animation forKey:nil];
        
        [self presentViewController:navi animated:YES completion:nil];
        
    }
}

@end
