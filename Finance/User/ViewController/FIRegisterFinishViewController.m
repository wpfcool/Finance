//
//  FIRegisterFinishViewController.m
//  Finance
//
//  Created by wenpeifang on 2018/6/6.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIRegisterFinishViewController.h"
//#import <YYText/YYText.h>
#import "FIRegisterSuccessViewController.h"
@interface FIRegisterFinishViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *realNameField;
@property (weak, nonatomic) IBOutlet UITextField *bankField;
@property (weak, nonatomic) IBOutlet UITextField *bankNoField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UILabel *agreeLabel;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UIButton *agreeButton;
@property (weak, nonatomic) IBOutlet UITextField *nickNameField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *passwordTopConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nickNameTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *realNameTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bankTopConstaint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bankNoTopConstaint;
@end

@implementation FIRegisterFinishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
       _registerButton.layer.cornerRadius = 24;
    _nickNameTopConstraint.constant = kIphone6Scale(100);
    _realNameTopConstraint.constant = kIphone6Scale(60);
    _bankTopConstaint.constant = kIphone6Scale(60);
    _bankNoTopConstaint.constant = kIphone6Scale(60);
    _passwordTopConstraint.constant = kIphone6Scale(60);

    NSMutableAttributedString * attar = [[NSMutableAttributedString alloc]initWithString:@"我已阅读并同意《用户协议》"];
//    attar.yy_font = [UIFont systemFontOfSize:13];
//    attar.yy_color = HEX_UICOLOR(0x999999, 1);
//    [attar yy_setColor:HEX_UICOLOR(0x3E83FF, 1) range:NSMakeRange(7, 6)];
    self.agreeLabel.attributedText = attar;
    
    self.agreeLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(agreeProtocol:)];
    tap.numberOfTouchesRequired = 1;
    [self.agreeLabel addGestureRecognizer:tap];
    
    
}
- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)agreeProtocol:(UIGestureRecognizer*)tap{
    
}
- (IBAction)registerClick:(id)sender {
    if(_realNameField.text.length == 0 || _bankField.text.length == 0 || _bankNoField.text.length == 0  || _passwordField.text.length == 0 || _nickNameField.text.length == 0){
        [self showAlert:@"输入不能为空"];
        return;
    }
    
    NSMutableDictionary * dic = @{@"nickname":_nickNameField.text,@"real_name":_realNameField.text,@"bankname":_bankField.text,@"bankcard":_bankNoField.text,@"tranpwd":_passwordField.text}.mutableCopy;
    [dic addEntriesFromDictionary:self.preDic];
    [self asyncSendRequestWithURL:REGISTER_URL param:dic RequestMethod:POST showHUD:YES result:^(id dic, NSError *error) {
        if(error){
            
        }
        else{
            FIRegisterSuccessViewController * successV = [[FIRegisterSuccessViewController alloc]init];
            [self.navigationController pushViewController:successV animated:YES];
        }
    }];
    
}
- (IBAction)agreeClick:(id)sender {
    self.agreeButton.selected = !self.agreeButton.selected;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
