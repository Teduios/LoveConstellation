//
//  CKDEMORootViewController.m
//  APP
//
//  Created by tarena on 16/3/28.
//  Copyright © 2016年 CK. All rights reserved.
//

#import "CKDEMORootViewController.h"
#import "RESideMenu.h"
#import "CKLeftViewController.h"

@interface CKDEMORootViewController ()<RESideMenuDelegate>

//@property (nonatomic,strong) CKFirstViewController *fvc;
//@property (nonatomic,strong) CKLeftViewController *lvc;

@end

@implementation CKDEMORootViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
}

//- (void)enableRESideMenu {
//    self.panGestureEnabled = YES;
//}
//
//- (void)disableRESideMenu {
//    self.panGestureEnabled = NO;
//}

- (void)awakeFromNib
{
    self.menuPreferredStatusBarStyle = UIStatusBarStyleLightContent;
    self.contentViewShadowColor = [UIColor blackColor];
    self.contentViewShadowOffset = CGSizeMake(0, 0);
    self.contentViewShadowOpacity = 0.6;
    self.contentViewShadowRadius = 12;
    self.contentViewShadowEnabled = YES;
    self.contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"asd"];
    self.leftMenuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"leftVC"];
    
    self.delegate = self;
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(disableRESideMenu) name:@"disableRESideMenu" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enableRESideMenu) name:@"enableRESideMenu" object:nil];
}


#pragma mark - RESideMenu Delegate
- (void)sideMenu:(RESideMenu *)sideMenu willShowMenuViewController:(UIViewController *)menuViewController {
}

- (void)sideMenu:(RESideMenu *)sideMenu didShowMenuViewController:(UIViewController *)menuViewController {
}

- (void)sideMenu:(RESideMenu *)sideMenu willHideMenuViewController:(UIViewController *)menuViewController {
}

- (void)sideMenu:(RESideMenu *)sideMenu didHideMenuViewController:(UIViewController *)menuViewController {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
