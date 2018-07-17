//
//  FICenterRecordCell.m
//  Finance
//
//  Created by wenpeifang on 2018/6/21.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FICenterRecordCell.h"

@implementation FICenterRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)buyClick:(id)sender {
    [_delegate buyOrderList];
}
- (IBAction)selloutClick:(id)sender {
    [_delegate sellOutOrderList];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
