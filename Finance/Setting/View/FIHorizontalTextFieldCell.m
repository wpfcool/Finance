//
//  FIHorizontalTextFieldCell.m
//  Finance
//
//  Created by 海龙 on 2018/7/5.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIHorizontalTextFieldCell.h"

@implementation FIHorizontalTextFieldCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentTextField.delegate = self;
    
    [self.contentTextField addTarget:self action:@selector(textFielddidChanged:) forControlEvents:UIControlEventEditingChanged];
}
-(void)textFielddidChanged:(FIStatusTextField *)text{
    
    if(_delegate && [_delegate respondsToSelector:@selector(textFieldDidChanged:)]){
        [_delegate textFieldDidChanged:text];
    }
}
-(BOOL)textFieldShouldReturn:(FIStatusTextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
