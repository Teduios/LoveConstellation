//
//  CKSecondViewController.m
//  APP
//
//  Created by tarena on 16/3/30.
//  Copyright © 2016年 CK. All rights reserved.
//

#import "CKSecondViewController.h"
#import "SlideHeadView.h"
#import "CKNetworkingManager.h"
#import "CKDataManager.h"
#import "MatchingModel.h"
#import "MBProgressHUD+KR.h"

@interface CKSecondViewController ()<UIPickerViewDataSource,UIPickerViewDelegate,UITextViewDelegate>
/** 我的星座 */
@property (weak, nonatomic) IBOutlet UITextField *myTextField;
/** ta的星座 */
@property (weak, nonatomic) IBOutlet UITextField *youTextField;

@property (weak, nonatomic) IBOutlet UITextView *content2TextView;


/** pickerView 的内容 */
@property (nonatomic,strong)NSArray *dataArray;

/** 获取的配对信息 */
@property(nonatomic,strong)NSArray *allMatchingData;
@property(nonatomic,strong)MatchingModel *model;

@property (nonatomic,strong)UIPickerView *myPickerView;
@property (nonatomic,strong)UIToolbar *myToolbar;
@end

@implementation CKSecondViewController

#pragma mark - 懒加载
-(NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSArray arrayWithObjects:@"白羊座",@"金牛座",@"双子座",@"巨蟹座",@"狮子座",@"处女座",@"天秤座",@"天蝎座",@"射手座",@"摩羯座",@"水瓶座",@"双鱼座", nil];
    }
    return _dataArray;
}

-(MatchingModel *)model{
    if (!_model) {
        _model = [MatchingModel new];
    }
    return _model;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"enableRESideMenu" object:nil];
    
    self.myTextField.text = @"白羊座";
    self.youTextField.text = @"白羊座";
    
    [self createPickerAndToolbar];

}

- (IBAction)clickButton:(id)sender {
    [self requestData];
}

//申请数据
-(void)requestData{

    NSDictionary *pa = @{@"xingzuo1":self.myTextField.text,
                         @"xingzuo2":self.youTextField.text,
                         @"key":MATCHING_KEY};
    [CKNetworkingManager sendRequestWithUrl:MATCHING_URL parameters:pa success:^(id responesObject) {
        [MBProgressHUD showMessage:@"Loding..."];
        self.allMatchingData = [CKDataManager getAllMatchingData:responesObject];
        self.model = self.allMatchingData[0];
        NSString *Str1 = self.model.content1;
        NSString *Str2 = self.model.content2;
        self.content2TextView.text = [NSString stringWithFormat:@"%@\n\n%@",Str1,Str2];
        [MBProgressHUD hideHUD];
    } failure:^(NSError *error) {
//        MYLog(@"%@",error);
        [MBProgressHUD showError:@"网络错误"];
    }];
}

//设置点击事件
- (IBAction)clickMyTextField:(id)sender {
    [self createPickerAndToolbar];
}
- (IBAction)clickYouTextField:(id)sender {
    [self createPickerAndToolbar];
}


-(void)createPickerAndToolbar{
    //创建 UIPickerView
    UIPickerView *pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
    pickerView.delegate = self;
    pickerView.dataSource =self;
    self.myPickerView = pickerView;

    //设置toolbar
    UIToolbar *toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    self.myToolbar = toolbar;
    //设置toolbar的样式
    toolbar.barStyle = UIBarStyleDefault;
    
    //创建toolbar上的按钮
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(doneTouched:)];
    rightItem.tintColor = [UIColor grayColor];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelTouched:)];
    rightItem.tintColor = [UIColor grayColor];
    leftItem.tintColor = [UIColor grayColor];
    
    //设置输入框的附属视图为 UIPickerView
    self.myTextField.inputView = self.myPickerView;
    self.myTextField.inputAccessoryView = self.myToolbar;
    self.youTextField.inputView = self.myPickerView;
    self.youTextField.inputAccessoryView = self.myToolbar;
    
    //放置按钮(中间加上了占位UI)
    [toolbar setItems:[NSArray arrayWithObjects:leftItem,[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],rightItem, nil]];
}


/** 监听输入框 */
- (IBAction)touch:(id)sender {
    [self.myTextField becomeFirstResponder];
    
}
- (IBAction)otherTouch:(id)sender {
    [self.youTextField becomeFirstResponder];
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.myTextField resignFirstResponder];
    [self.youTextField resignFirstResponder];
}


- (void)cancelTouched:(UIBarButtonItem *)sender
{
    [self.myTextField resignFirstResponder];
    [self.youTextField resignFirstResponder];
}

- (void)doneTouched:(UIBarButtonItem *)sender
{
    [self.myTextField resignFirstResponder];
    [self.youTextField resignFirstResponder];
}

#pragma mark - UIPicker的代理方法
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.dataArray.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *title =[self.dataArray objectAtIndex:row];
    return title;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ([self.myTextField isFirstResponder]) {
        self.myTextField.text = [self.dataArray objectAtIndex:row];
    }else if ([self.youTextField isFirstResponder]){
        self.youTextField.text = [self.dataArray objectAtIndex:row];
    }
}

#pragma mark - UITextView 代理方法
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
