//
//  CKTodayDataCell.m
//  APP
//
//  Created by tarena on 16/4/14.
//  Copyright © 2016年 CK. All rights reserved.
//

#import "CKTodayDataCell.h"

@implementation CKTodayDataCell

-(void)awakeFromNib{
    self.separatorInset = UIEdgeInsetsZero;
    self.layoutMargins = UIEdgeInsetsZero;
    self.preservesSuperviewLayoutMargins = NO;
    
            self.nameLabel.text = nil;
            self.QfriendLabel.text = nil;
            self.allLabel.text = nil;
            self.colorLabel.text = nil;
            self.dateTimeLabel.text = nil;
            self.healthLabel.text = nil;
            self.loveLabel.text = nil;
            self.numberLabel.text = NULL;
            self.summaryLabel.text = nil;
            self.workLabel.text = nil;
            self.moneyLabel.text = nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
