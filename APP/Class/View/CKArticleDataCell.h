//
//  CKArticleDataCell.h
//  APP
//
//  Created by tarena on 16/4/19.
//  Copyright © 2016年 CK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CKArticleDataCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *articleTitle;
@property (weak, nonatomic) IBOutlet UILabel *articleTime;
@property (weak, nonatomic) IBOutlet UIImageView *articlePic;
@property (weak, nonatomic) IBOutlet UIView *otherView;

@end
