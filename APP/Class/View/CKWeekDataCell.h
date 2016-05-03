//
//  CKWeekDataCell.h
//  APP
//
//  Created by tarena on 16/4/15.
//  Copyright © 2016年 CK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CKWeekDataCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *healthLabel;
@property (weak, nonatomic) IBOutlet UILabel *jobLabel;
@property (weak, nonatomic) IBOutlet UILabel *loveLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *workLabel;
@property (weak, nonatomic) IBOutlet UIView *otherView;

@end
