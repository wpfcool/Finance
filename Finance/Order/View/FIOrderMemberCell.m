//
//  FIOrderMemberCell.m
//  Finance
//
//  Created by wenpeifang on 2018/8/20.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIOrderMemberCell.h"

@implementation FIOrderMemberCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.rightButton.layer.cornerRadius = 10;
    self.rightButton.layer.borderWidth = 1;
    self.rightButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.rightButton.backgroundColor = [UIColor whiteColor];
    [self.rightButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
}
- (IBAction)buttonClick:(UIButton *)btn {
  
    if([btn.titleLabel.text isEqualToString:@"复制"]){
        NSLog(@"=====");
        
        UIPasteboard * paste = [UIPasteboard generalPasteboard];
        [paste setString:self.contentLabel.text];
        
    }else if([btn.titleLabel.text isEqualToString:@"拨打"]){
        NSLog(@"xxxxxx");
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",self.contentLabel.text];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
