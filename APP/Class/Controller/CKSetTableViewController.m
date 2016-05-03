//
//  CKSetTableViewController.m
//  APP
//
//  Created by tarena on 16/4/16.
//  Copyright © 2016年 CK. All rights reserved.
//

#import "CKSetTableViewController.h"
#import "MHDatePicker.h"
#import "CKUserInfo.h"

@interface CKSetTableViewController ()

@property (nonatomic,strong)MHDatePicker *selectTimePicker;
@property (nonatomic,strong)MHDatePicker *selectDatePicker;

/** 月 */
@property (nonatomic,assign)NSInteger month;
/** 日 */
@property (nonatomic,assign)NSInteger day;

@end

@implementation CKSetTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self listenNotification];
    
    self.navigationItem.title = @"设置";
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backMenuView)];
    self.navigationItem.leftBarButtonItem = backItem;
    
}

-(void)backMenuView{
    //设置present的动画
    CATransition *animation = [CATransition animation];
    animation.duration = 1.0;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"rippleEffect";
    animation.subtype = kCATransitionFromRight;
    [self.view.window.layer addAnimation:animation forKey:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    //设置通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"tackBackMenu" object:nil];
}


#pragma mark - UITableView 的代理方法

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *ID = @"cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    
//        if (indexPath.row == 0) {
//            cell.textLabel.text = @"昵称";
         if (indexPath.row == 0){
            cell.textLabel.text = @"生日";
            NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
            cell.detailTextLabel.text = [userInfo objectForKey:@"userData"];
//            MYLog(@"userInfo%@",[CKUserInfo sharedCKUserInfo].userDate);
        }else if (indexPath.row == 1){
            cell.textLabel.text = @"星座";
            NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
            cell.detailTextLabel.text = [userInfo objectForKey:@"result"];
//            cell.detailTextLabel.text = [CKUserInfo sharedCKUserInfo].userConstellation;
        }
    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = NO;
    return cell;
}


#pragma mark 选中某行做某事
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
        if (indexPath.row == 0) {
            [self changedUserCell:tableView IndexPath:indexPath];
        }
}

#pragma mark 时间选择器
//需要传进tableView 和 indexPath
-(void)changedUserCell:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath{
    _selectDatePicker = [[MHDatePicker alloc] init];
    _selectDatePicker.isBeforeTime = YES;
    _selectDatePicker.datePickerMode = UIDatePickerModeDate;
    
    [_selectDatePicker didFinishSelectedDate:^(NSDate *selectedDate) {
        
        /** 把返回的日期存起来 */
        NSString *dateStr = [self dateStringWithDate:selectedDate DateFormat:@"yyyy年MM月dd日"];
        //存入沙箱
        NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
        [userInfo setObject:dateStr forKey:@"userData"];
        
        [CKUserInfo sharedCKUserInfo].userDate = dateStr;
        self.month = [[dateStr substringWithRange:NSMakeRange(5, 2)] integerValue];
        self.day = [[dateStr substringWithRange:NSMakeRange(8, 2)] integerValue];
//        MYLog(@"%ld,%ld",self.month,self.day);
        [self constellationForDate];
    }];
    [self.tableView reloadData];
}

- (NSString *)dateStringWithDate:(NSDate *)date DateFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    NSString *str = [dateFormatter stringFromDate:date];
    return str ? str : @"";
}


#pragma mark -  收到通知后做的事
-(void)listenNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableView) name:@"reloadData" object:nil];
}

//销毁通知
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)reloadTableView{
    [self.tableView reloadData];
}

#pragma mark - 根据生日计算星座
-(void)constellationForDate{
    NSString *astroString = @"魔羯水瓶双鱼白羊金牛双子巨蟹狮子处女天秤天蝎射手魔羯";
    NSString *astroFormat = @"102123444543";
    NSString *result = [NSString stringWithFormat:@"%@座",[astroString substringWithRange:NSMakeRange(self.month*2-(self.day < [[astroFormat substringWithRange:NSMakeRange((self.month-1), 1)] intValue] - (-19))*2,2)]];
    
    NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
    [userInfo setObject:result forKey:@"result"];
    
    [CKUserInfo sharedCKUserInfo].userConstellation = result;
    MYLog(@"%@",result);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
