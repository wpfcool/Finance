//
//  FISettingPasswordCodeCell.m
//  Finance
//
//  Created by wenpeifang on 2018/7/6.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FISettingPasswordCodeCell.h"

@implementation FISettingPasswordCodeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.codeButton.layer.cornerRadius =  15;
    self.codeButton.layer.borderColor = HEX_UICOLOR(0x979797, 1).CGColor;
    self.codeButton.layer.borderWidth = 0.5;
    self.codeTextField.delegate = self;
    [self.codeTextField addTarget:self action:@selector(textFielddidChanged:) forControlEvents:UIControlEventEditingChanged];
}
- (IBAction)codeButtonClick:(id)sender {
    if(_delegate && [_delegate respondsToSelector:@selector(codeButtonClick:)]){
        [_delegate codeButtonClick:self.codeButton];
    }
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
