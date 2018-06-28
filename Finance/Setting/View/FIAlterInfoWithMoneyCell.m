//
//  FIAlterInfoWithMoneyCell.m
//  Finance
//
//  Created by wenpeifang on 2018/6/28.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIAlterInfoWithMoneyCell.h"

@implementation FIAlterInfoWithMoneyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)buttonClick:(id)sender {
    if(_delegate && [_delegate respondsToSelector:@selector(buttonClick:)]){
        [_delegate buttonClick:self];
    }
}
@end
