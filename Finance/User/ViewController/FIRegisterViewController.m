//
//  FIRegisterViewController.m
//  Finance
//
//  Created by wenpeifang on 2018/6/6.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIRegisterViewController.h"
#import "FIRegisterFinishViewController.h"
#import "HttpRequest.h"
#import "SysUtils.h"
@interface FIRegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;

@end

@implementation FIRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.edgesForExtendedLayout  = UIRectEdgeNone;
    
    
    
}
-(void)showAlert:(NSString *)message{
    UIAlertController * controller = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    [controller addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:controller animated:YES completion:nil];
}
- (IBAction)getCodeClick:(id)sender {
    
    if(_phoneTextField.text.length == 0){
        [self showAlert:@"手机号输入不能为空"];
        return;
    }
    
    NSDictionary * dic = @{@"phone":_phoneTextField.text};
    [self asyncSendRequestWithURL:SEND_IPHONE_CODE param:dic RequestMethod:POST showHUD:YES result:^(id dic, NSError *error) {
        if(error){
            
        }
        else{
            
        }
    }];
    
}
- (IBAction)nextClick:(id)sender {

    if(_userNameTextField.text.length == 0 || _passwordTextField.text.length == 0 || _phoneTextField.text.length == 0  || _codeTextField.text.length == 0){
        

        [self showAlert:@"输入不能为空"];
        return;
        
    }
    
    
    NSDictionary * dic = @{@"username":_userNameTextField.text,@"password":_passwordTextField.text,@"phone":_phoneTextField.text,@"code":_codeTextField.text,@"system_num":[SysUtils uuid],@"version_num":[SysUtils shortVersion],@"source":@"2"};
    
    [self asyncSendRequestWithURL:REGISTER_URL param:dic RequestMethod:POST showHUD:YES result:^(id dic, NSError *error) {
        if(error){
            
        }
        else{
            
            FIRegisterFinishViewController * registerNextVC = [[FIRegisterFinishViewController alloc]init];
            registerNextVC.userId = dic;
            [self.navigationController pushViewController:registerNextVC animated:YES];
        }
    }];


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
