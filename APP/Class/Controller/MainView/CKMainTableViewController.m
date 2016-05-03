//
//  CKMainTableViewController.m
//  APP
//
//  Created by tarena on 16/4/14.
//  Copyright © 2016年 CK. All rights reserved.
//

#import "CKMainTableViewController.h"
#import "RESideMenu.h"
#import "SlideHeadView.h"
#import "BlurEffectMenu.h"
#import "CKNetworkingManager.h"
#import "CKDataManager.h"
#import "TodayConstellationModel.h"
#import "CKTodayDataCell.h"
#import "CKWeekDataCell.h"
#import "WeekConstellationModel.h"
#import "MBProgressHUD+KR.h"

@interface CKMainTableViewController ()<BlurEffectMenuDelegate>


/** 获取今天的运程 */
@property (nonatomic,strong)NSArray *allTodayData;
/** 获取本周的运程 */
@property (nonatomic,strong)NSArray *allWeekData;

/** 当天数据的模型类属性*/
@property (nonatomic,strong)TodayConstellationModel *todayData;
/** 本周数据的模型类属性 */
@property (nonatomic,strong)WeekConstellationModel *weekData;
@end

@implementation CKMainTableViewController

#pragma mark -懒加载
//-(TodayConstellationModel *)todayData{
//    if (!_todayData) {
//        _todayData = [TodayConstellationModel new];
//        _todayData = self.allTodayData[0];
//    }
//    return _todayData;
//}
//
//-(WeekConstellationModel *)weekData{
//    if (!_weekData) {
//        _weekData = [WeekConstellationModel new];
//        _weekData = self.allWeekData[0];
//    }
//    return _weekData;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
    UIImage *image = [UIImage imageNamed:@"set"];
    UIImage *image2 = [UIImage imageNamed:@"rightIcon"];
    
    UIImage *leftImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *rightImage = [image2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //左边item
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:leftImage style:UIBarButtonItemStylePlain target:self action:@selector(gotoLeftMenu)];
    
    //右边item
    UIBarButtonItem *rigthItem = [[UIBarButtonItem alloc]initWithImage:rightImage style:UIBarButtonItemStylePlain target:self action:@selector(changeConstellation)];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.rightBarButtonItem = rigthItem;
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    if (![userInfo objectForKey:@"result"]) {
//        MYLog(@"userInfo%@",[userInfo objectForKey:@"result"]);
        self.navigationItem.title = @"白羊座";
    }else{
        self.navigationItem.title = [userInfo objectForKey:@"result"];
    }
    
//    MYLog(@"1%@",self.navigationItem.title);
    self.tableView.backgroundColor = [UIColor clearColor];
    
//    self.tableView.pagingEnabled = YES;
    
    [self listenNotification];

    [self getTodayData];
    [self getWeekData];
}


//解析当日数据
-(void)getTodayData{
    
    [MBProgressHUD showMessage:@"Loding..."];

    NSString *url = REQUEST_URL;
    NSDictionary *params = @{@"consName":self.navigationItem.title,
                             @"type":@"today",
                             @"key":REQUEST_KEY};
    [CKNetworkingManager sendRequestWithUrl:url parameters:params success:^(id responesObject) {
        
//        [self getWeekData];
        
        self.allTodayData = [CKDataManager getAlltodayData:responesObject];
//        MYLog(@"%@",self.allTodayData);
        
        //返回壁纸,并刷新
        UIImageView *imageView = [[UIImageView alloc]init];
        if ([self.navigationItem.title isEqualToString:@"白羊座"]) {
            UIImage *iimage = [UIImage imageNamed:@"baiyangzuo"];
            imageView.image = iimage;
        }else if ([self.navigationItem.title isEqualToString:@"金牛座"]){
            UIImage *iimage = [UIImage imageNamed:@"jinniuzuo"];
            imageView.image = iimage;
        }else if ([self.navigationItem.title isEqualToString:@"双子座"]){
            UIImage *iimage = [UIImage imageNamed:@"shuangzizuo"];
            imageView.image = iimage;
        }else if ([self.navigationItem.title isEqualToString:@"巨蟹座"]){
            UIImage *iimage = [UIImage imageNamed:@"juxiezuo"];
            imageView.image = iimage;
        }else if ([self.navigationItem.title isEqualToString:@"狮子座"]){
            UIImage *iimage = [UIImage imageNamed:@"shizizuo"];
            imageView.image = iimage;
        }else if ([self.navigationItem.title isEqualToString:@"处女座"]){
            UIImage *iimage = [UIImage imageNamed:@"chunvzuo"];
            imageView.image = iimage;
        }else if ([self.navigationItem.title isEqualToString:@"天秤座"]){
            UIImage *iimage = [UIImage imageNamed:@"tianchengzuo"];
            imageView.image = iimage;
        }else if ([self.navigationItem.title isEqualToString:@"天蝎座"]){
            UIImage *iimage = [UIImage imageNamed:@"tianxiezuo"];
            imageView.image = iimage;
        }else if ([self.navigationItem.title isEqualToString:@"射手座"]){
            UIImage *iimage = [UIImage imageNamed:@"sheshouzuo"];
            imageView.image = iimage;
        }else if ([self.navigationItem.title isEqualToString:@"摩羯座"]){
            UIImage *iimage = [UIImage imageNamed:@"mojiezuo"];
            imageView.image = iimage;
        }else if ([self.navigationItem.title isEqualToString:@"水瓶座"]){
            UIImage *iimage = [UIImage imageNamed:@"shuipingzuo"];
            imageView.image = iimage;
        }else if ([self.navigationItem.title isEqualToString:@"双鱼座"]){
            UIImage *iimage = [UIImage imageNamed:@"shuangyuzuo"];
            imageView.image = iimage;
        }
        self.tableView.backgroundView = imageView;
        [MBProgressHUD hideHUD];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
//        MYLog(@"error:%@",error);
        [MBProgressHUD showError:@"网络错误"];
    }];
//    [self.tableView reloadData];
//    self.data = self.allTodayData[0];
//    self.navigationItem.title = self.data.name;
}

-(void)getWeekData{
    NSDictionary *params = @{@"consName":self.navigationItem.title,
                             @"type":@"week",
                             @"key":REQUEST_KEY};
    [CKNetworkingManager sendRequestWithUrl:REQUEST_URL parameters:params success:^(id responesObject) {
        self.allWeekData = [CKDataManager getAllWeekData:responesObject];
//        MYLog(@"%@",self.allWeekData);
        [self.tableView reloadData];
        [MBProgressHUD hideHUD];
    } failure:^(NSError *error) {
//        MYLog(@"error:%@",error);
    }];
    [MBProgressHUD hideHUD];
}



//侧滑菜单方法
-(void)gotoLeftMenu{
    [self.sideMenuViewController presentLeftMenuViewController];
}

#pragma mark -星座菜单方法
-(void)changeConstellation{
    BlurEffectMenuItem *item1 = [[BlurEffectMenuItem alloc]init];
    [item1 setTitle:@"白羊座"];
    [item1 setIcon:[UIImage imageNamed:@"baiyang"]];
    
    BlurEffectMenuItem *item2 = [[BlurEffectMenuItem alloc]init];
    [item2 setTitle:@"金牛座"];
    [item2 setIcon:[UIImage imageNamed:@"jinniu"]];
    
    BlurEffectMenuItem *item3 = [[BlurEffectMenuItem alloc]init];
    [item3 setTitle:@"双子座"];
    [item3 setIcon:[UIImage imageNamed:@"shuangzi"]];
    
    BlurEffectMenuItem *item4 = [[BlurEffectMenuItem alloc]init];
    [item4 setTitle:@"巨蟹座"];
    [item4 setIcon:[UIImage imageNamed:@"juxie"]];
    
    BlurEffectMenuItem *item5 = [[BlurEffectMenuItem alloc]init];
    [item5 setTitle:@"狮子座"];
    [item5 setIcon:[UIImage imageNamed:@"shizi"]];
    
    BlurEffectMenuItem *item6 = [[BlurEffectMenuItem alloc]init];
    [item6 setTitle:@"处女座"];
    [item6 setIcon:[UIImage imageNamed:@"chunv"]];
    
    BlurEffectMenuItem *item7 = [[BlurEffectMenuItem alloc]init];
    [item7 setTitle:@"天秤座"];
    [item7 setIcon:[UIImage imageNamed:@"tiancheng"]];
    
    BlurEffectMenuItem *item8 = [[BlurEffectMenuItem alloc]init];
    [item8 setTitle:@"天蝎座"];
    [item8 setIcon:[UIImage imageNamed:@"tianxie"]];
    
    BlurEffectMenuItem *item9 = [[BlurEffectMenuItem alloc]init];
    [item9 setTitle:@"射手座"];
    [item9 setIcon:[UIImage imageNamed:@"sheshou"]];
    
    BlurEffectMenuItem *item10 = [[BlurEffectMenuItem alloc]init];
    [item10 setTitle:@"摩羯座"];
    [item10 setIcon:[UIImage imageNamed:@"mojie"]];
    
    BlurEffectMenuItem *item11 = [[BlurEffectMenuItem alloc]init];
    [item11 setTitle:@"水瓶座"];
    [item11 setIcon:[UIImage imageNamed:@"shuiping"]];
    
    BlurEffectMenuItem *item12 = [[BlurEffectMenuItem alloc]init];
    [item12 setTitle:@"双鱼座"];
    [item12 setIcon:[UIImage imageNamed:@"shuangyu"]];
    
    BlurEffectMenu *menu = [[BlurEffectMenu alloc]initWithMenus:@[item1,item2,item3,item4,item5,item6,item7,item8,item9,item10,item11,item12]];
    [menu setDelegate:self];
    menu.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [menu setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentViewController:menu animated:YES completion:nil];
}

#pragma mark - BlurEffectMenu Delegate(星座菜单的代理方法)
- (void)blurEffectMenuDidTapOnBackground:(BlurEffectMenu *)menu{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//收回菜单
- (void)blurEffectMenu:(BlurEffectMenu *)menu didTapOnItem:(BlurEffectMenuItem *)item{
    
    [self dismissViewControllerAnimated:YES completion:nil];
//    MYLog(@"item.title:%@",item.title);
    
    self.navigationItem.title = item.title;
    UIImageView *imageView = [[UIImageView alloc]init];
    
    //设置壁纸
    if ([self.navigationItem.title isEqualToString:@"白羊座"]) {
        UIImage *iimage = [UIImage imageNamed:@"baiyangzuo"];
        imageView.image = iimage;
    }else if ([self.navigationItem.title isEqualToString:@"金牛座"]){
        UIImage *iimage = [UIImage imageNamed:@"jinniuzuo"];
        imageView.image = iimage;
    }else if ([self.navigationItem.title isEqualToString:@"双子座"]){
        UIImage *iimage = [UIImage imageNamed:@"shuangzizuo"];
        imageView.image = iimage;
    }else if ([self.navigationItem.title isEqualToString:@"巨蟹座"]){
        UIImage *iimage = [UIImage imageNamed:@"juxiezuo"];
        imageView.image = iimage;
    }else if ([self.navigationItem.title isEqualToString:@"狮子座"]){
        UIImage *iimage = [UIImage imageNamed:@"shizizuo"];
        imageView.image = iimage;
    }else if ([self.navigationItem.title isEqualToString:@"处女座"]){
        UIImage *iimage = [UIImage imageNamed:@"chunvzuo"];
        imageView.image = iimage;
    }else if ([self.navigationItem.title isEqualToString:@"天秤座"]){
        UIImage *iimage = [UIImage imageNamed:@"tianchengzuo"];
        imageView.image = iimage;
    }else if ([self.navigationItem.title isEqualToString:@"天蝎座"]){
        UIImage *iimage = [UIImage imageNamed:@"tianxiezuo"];
        imageView.image = iimage;
    }else if ([self.navigationItem.title isEqualToString:@"射手座"]){
        UIImage *iimage = [UIImage imageNamed:@"sheshouzuo"];
        imageView.image = iimage;
    }else if ([self.navigationItem.title isEqualToString:@"摩羯座"]){
        UIImage *iimage = [UIImage imageNamed:@"mojiezuo"];
        imageView.image = iimage;
    }else if ([self.navigationItem.title isEqualToString:@"水瓶座"]){
        UIImage *iimage = [UIImage imageNamed:@"shuipingzuo"];
        imageView.image = iimage;
    }else if ([self.navigationItem.title isEqualToString:@"双鱼座"]){
        UIImage *iimage = [UIImage imageNamed:@"shuangyuzuo"];
        imageView.image = iimage;
    }
//    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@壁纸",self.navigationItem.title]]];
    self.tableView.backgroundView = imageView;
    self.tableView.backgroundColor = [UIColor clearColor];
//    [self.tableView reloadData];
    [self.tableView setContentOffset:CGPointMake(0, -65) animated:YES];
    [self getTodayData];
    [self getWeekData];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@壁纸",self.navigationItem.title]]];
//    self.tableView.backgroundView = imageView;
//    [self getWeekData];
//    [self getTodayData];
//    [self.tableView reloadData];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        CKTodayDataCell *cell = [tableView dequeueReusableCellWithIdentifier:@"todayDataCell"];
        self.todayData = self.allTodayData[0];
//        cell.nameLabel = nil;
//        cell.QfriendLabel = nil;
//        cell.allLabel = nil;
//        cell.colorLabel = nil;
//        cell.dateTimeLabel = nil;
//        cell.healthLabel = nil;
//        cell.loveLabel = nil;
//        cell.numberLabel = nil;
//        cell.summaryLabel = nil;
//        cell.workLabel = nil;
//        cell.moneyLabel = nil;
        
        cell.nameLabel.text = self.todayData.name;
        cell.QfriendLabel.text = self.todayData.QFriend;
        cell.allLabel.text = self.todayData.all;
        cell.colorLabel.text = self.todayData.color;
        cell.dateTimeLabel.text = self.todayData.datetime;
        cell.healthLabel.text = self.todayData.health;
        cell.loveLabel.text = self.todayData.love;
        cell.moneyLabel.text = self.todayData.money;
        cell.numberLabel.text = [NSString stringWithFormat:@"%ld",self.todayData.number];
        cell.summaryLabel.text = self.todayData.summary;
        cell.workLabel.text = self.todayData.work;
        cell.otherView.layer.cornerRadius = 15;
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }else{
        CKWeekDataCell *cell = [tableView dequeueReusableCellWithIdentifier:@"weekDataCell"];
        self.weekData = self.allWeekData[0];
        cell.healthLabel.text = self.weekData.health;
        cell.jobLabel.text = self.weekData.job;
        cell.loveLabel.text  = self.weekData.love;
        cell.moneyLabel.text = self.weekData.money;
        cell.workLabel.text = self.weekData.work;
//        NSString *date = self.weekData.date;
//        NSString *weekth = [NSString stringWithFormat:@"第%ld周",self.weekData.weekth];
//        cell.timeLabel.text = [NSString stringWithFormat:@"%@  %@",date,weekth];
        cell.backgroundColor = [UIColor clearColor];
        cell.otherView.layer.cornerRadius = 15;
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.tableView.bounds.size.height-88;
}

/**
 *  监听通知,收回菜单
 */
-(void)listenNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tackBackMenu) name:@"tackBackMenu" object:nil];
}

-(void)tackBackMenu{
    //把侧边的控制器收回
    [self.sideMenuViewController hideMenuViewController];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 *  设置状态栏为白色系
 */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
