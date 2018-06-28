//
//  FIMemberTableViewCell.m
//  Finance
//
//  Created by wenpeifang on 2018/6/28.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIMemberTableViewCell.h"

@implementation FIMemberTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    CGFloat padding = (SCREEN_WIDTH - 3 *98) / 4.0;
    self.huanginLeftConstraint.constant = padding;
    self.huangjinRightConstraint.constant = padding;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
