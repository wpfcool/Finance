//
//  FIOrderMemberCell.h
//  Finance
//
//  Created by wenpeifang on 2018/8/20.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FIOrderMemberCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;

@end
