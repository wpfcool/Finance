//
//  FIResetPassViewController.m
//  Finance
//
//  Created by wenpeifang on 2018/7/9.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIResetPassViewController.h"

@interface FIResetPassViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *password1Field;
@property (weak, nonatomic) IBOutlet UITextField *password2Field;
@property (weak, nonatomic) IBOutlet UIButton *okButton;

@end

@implementation FIResetPassViewController
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];

    self.okButton.layer.cornerRadius = 24;
}
- (IBAction)okClick:(id)sender {
    
    if(_password1Field.text.length == 0 || _password2Field.text.length == 0){
        [self showAlert:@"输入不能为空"];
        return;
    }
    
    if(![_password1Field.text isEqualToString:self.password2Field.text]){
        [self showAlert:@"两次密码输入不同"];
        return;
    }
    [self.view endEditing:YES];

    [self asyncSendRequestWithURL:RESETPASS_URL param:@{@"userName":self.username,@"password":self.password1Field.text,@"conPassword":self.password2Field.text} RequestMethod:POST showHUD:YES result:^(id dic, NSError *error) {
        if(!error){
            [self.view makeToast:@"修改成功" duration:2.0];
        }
    }];
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
