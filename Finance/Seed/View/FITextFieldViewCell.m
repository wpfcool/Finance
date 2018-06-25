//
//  FITextFieldViewCell.m
//  Finance
//
//  Created by wenpeifang on 2018/6/25.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FITextFieldViewCell.h"

@implementation FITextFieldViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.textField.delegate = self;
    
    [self.textField addTarget:self action:@selector(textFielddidChanged:) forControlEvents:UIControlEventEditingChanged];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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
@end
