//
//  FIHomeManagerCell.m
//  Finance
//
//  Created by wenpeifang on 2018/6/21.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIHomeManagerCell.h"

@implementation FIHomeManagerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)centerClick:(id)sender {
    [_delegate financeCenterClick];
}
- (IBAction)teamClick:(id)sender {
    [_delegate myTeamClick];
}
- (IBAction)buyClick:(id)sender {
    [_delegate buyClick];
}
- (IBAction)soldoutClick:(id)sender {
    [_delegate sellOutClick];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
