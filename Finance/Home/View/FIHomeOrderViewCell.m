//
//  FIHomeOrderViewCell.m
//  Finance
//
//  Created by wenpeifang on 2018/6/21.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIHomeOrderViewCell.h"
#import "FIBadgeView.h"
@interface FIHomeOrderViewCell()
@property (weak, nonatomic) IBOutlet FIBadgeView *macthBadge;
@property (weak, nonatomic) IBOutlet FIBadgeView *fukuanBadge;
@property (weak, nonatomic) IBOutlet FIBadgeView *confirmBadge;
@property (weak, nonatomic) IBOutlet FIBadgeView *pingjiaBadge;
@end

@implementation FIHomeOrderViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _macthBadge.hidden = YES;
    _fukuanBadge.hidden = YES;
    _confirmBadge.hidden = YES;
    _pingjiaBadge.hidden = YES;

}
- (IBAction)matchClick:(id)sender {
    [_delegate waitingMatchClick:self];
}
- (IBAction)payClick:(id)sender {
    [_delegate waitingPayClick:self];
}
- (IBAction)confirmCLick:(id)sender {
    [_delegate waitingConfirmClick:self];
}
- (IBAction)pingjiaCLick:(id)sender {
    [_delegate waitingAppraise:self];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
