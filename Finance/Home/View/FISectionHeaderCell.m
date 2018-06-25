//
//  FIHomeOrderHeaderCell.m
//  Finance
//
//  Created by wenpeifang on 2018/6/21.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FISectionHeaderCell.h"

@implementation FISectionHeaderCell
-(void)hiddenMore:(BOOL)hidden{
    
    UIView * moreLabel = [self.contentView viewWithTag:100];
    UIView * arrowLabel = [self.contentView viewWithTag:101];
    moreLabel.hidden = hidden;
    arrowLabel.hidden = hidden;
    
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
