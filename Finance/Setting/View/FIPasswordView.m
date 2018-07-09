//
//  FIPasswordView.m
//  Finance
//
//  Created by wenpeifang on 2018/7/9.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIPasswordView.h"

@implementation FIPasswordView
-(void)awakeFromNib{
    [super awakeFromNib];
    [self.hiddenTextField addTarget:self action:@selector(textFielddidChanged:) forControlEvents:UIControlEventEditingChanged];
    self.hiddenTextField.keyboardType = UIKeyboardTypeNumberPad;
    CGColorRef color =HEX_UICOLOR(0x999999, 1).CGColor;
    self.password1.layer.cornerRadius = 5;
    self.password1.layer.borderWidth = 1;
    self.password1.layer.borderColor = color;
    
    self.password2.layer.cornerRadius = 5;
    self.password2.layer.borderWidth = 1;
    self.password2.layer.borderColor =color;
    
    self.password3.layer.cornerRadius = 5;
    self.password3.layer.borderWidth = 1;
    self.password3.layer.borderColor =color;
    
    self.password4.layer.cornerRadius = 5;;
    self.password4.layer.borderWidth = 1;
    self.password4.layer.borderColor =color;
    
    self.password5.layer.cornerRadius = 5;
    self.password5.layer.borderWidth = 1;
    self.password5.layer.borderColor = color;
    
    self.password6.layer.cornerRadius = 5;
    self.password6.layer.borderWidth = 1;
    self.password6.layer.borderColor =color;
    
    self.okButton.layer.cornerRadius = 20;
    self.okButton.backgroundColor =HEX_UICOLOR(0x3E83FF, 1);
    
    self.cancelButton.layer.cornerRadius = 20;
    self.cancelButton.backgroundColor =HEX_UICOLOR(0xD8D8D8, 1);
    self.password1.text = @"";
    self.password2.text = @"";
    self.password3.text = @"";
    self.password4.text = @"";
    self.password5.text = @"";
    self.password6.text = @"";
}
-(void)textFielddidChanged:(UITextField *)textField{
    NSString * password =self.hiddenTextField.text;

    self.password1.text = @"";
    self.password2.text = @"";
    self.password3.text = @"";
    self.password4.text = @"";
    self.password5.text = @"";
    self.password6.text = @"";
    if(password.length == 1){
        NSString * one = [password substringWithRange:NSMakeRange(0, 1)];
        self.password1.text = one;
    }
    else if(password.length == 2){
        NSString * one = [password substringWithRange:NSMakeRange(0, 1)];
        NSString * two = [password substringWithRange:NSMakeRange(1, 1)];
        self.password1.text = one;
        self.password2.text = two;
        
    }else if(password.length == 3){
        NSString * one = [password substringWithRange:NSMakeRange(0, 1)];
        NSString * two = [password substringWithRange:NSMakeRange(1, 1)];
        NSString * three = [password substringWithRange:NSMakeRange(2, 1)];

        self.password1.text = one;
        self.password2.text = two;
        self.password3.text = three;
    }else if(password.length == 4){
        NSString * one = [password substringWithRange:NSMakeRange(0, 1)];
        NSString * two = [password substringWithRange:NSMakeRange(1, 1)];
        NSString * three = [password substringWithRange:NSMakeRange(2, 1)];
        NSString * four = [password substringWithRange:NSMakeRange(3, 1)];

        self.password1.text = one;
        self.password2.text = two;
        self.password3.text = three;
        self.password4.text = four;
    }else if(password.length == 5){
        NSString * one = [password substringWithRange:NSMakeRange(0, 1)];
        NSString * two = [password substringWithRange:NSMakeRange(1, 1)];
        NSString * three = [password substringWithRange:NSMakeRange(2, 1)];
        NSString * four = [password substringWithRange:NSMakeRange(3, 1)];
        NSString * five = [password substringWithRange:NSMakeRange(4, 1)];

        self.password1.text = one;
        self.password2.text = two;
        self.password3.text = three;
        self.password4.text = four;
        self.password5.text = five;
    }else if(password.length == 6){
        NSString * one = [password substringWithRange:NSMakeRange(0, 1)];
        NSString * two = [password substringWithRange:NSMakeRange(1, 1)];
        NSString * three = [password substringWithRange:NSMakeRange(2, 1)];
        NSString * four = [password substringWithRange:NSMakeRange(3, 1)];
        NSString * five = [password substringWithRange:NSMakeRange(4, 1)];
        NSString * six = [password substringWithRange:NSMakeRange(5, 1)];

        self.password1.text = one;
        self.password2.text = two;
        self.password3.text = three;
        self.password4.text = four;
        self.password5.text = five;
        self.password6.text = six;
        
        if(_delegate && [_delegate respondsToSelector:@selector(safePassword:)]){
                [_delegate safePassword:[_hiddenTextField.text substringToIndex:6]];
            }
    }

    
}
- (IBAction)cancelClick:(id)sender {
    if(_delegate && [_delegate respondsToSelector:@selector(hiddenPasswordView)]){
        [_delegate hiddenPasswordView];
    }
}
- (IBAction)okClick:(id)sender {
    if(_delegate && [_delegate respondsToSelector:@selector(safePassword:)]){
//        [_delegate ]
        if(_hiddenTextField.text.length>6){
            [_delegate safePassword:[_hiddenTextField.text substringToIndex:6]];
        }else{
            [_delegate safePassword:_hiddenTextField.text];

        }
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
