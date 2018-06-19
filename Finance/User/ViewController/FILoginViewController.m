//
//  FILoginViewController.m
//  Finance
//
//  Created by wenpeifang on 2018/6/6.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FILoginViewController.h"
#import "FIRegisterViewController.h"
#import "SysUtils.h"
#import "FIUser.h"
#import "AppDelegate.h"
#import "FIFindPasswordViewController.h"
@interface FILoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passworldTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topestConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *distanceConstraint;

@end

@implementation FILoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden = YES;
    self.loginButton.layer.cornerRadius = 24;
    _topestConstraint.constant = kIphone6Scale(122);
    _distanceConstraint.constant = kIphone6Scale(69);
    _userNameTextField.delegate= self;
    _passworldTextField.delegate = self;
    
    NSLog(@"%f",[UIScreen mainScreen].bounds.size.height);
}
- (IBAction)loginClick:(id)sender {
    
    if(_userNameTextField.text.length == 0 || _passworldTextField.text.length == 0){
        [self showAlert:@"输入不能为空"];
        return;
    }
    
    [_passworldTextField resignFirstResponder];
    [_userNameTextField resignFirstResponder];
    
    NSDictionary * dic = @{@"username":_userNameTextField.text,@"password":_passworldTextField.text,@"system_num":[SysUtils uuid],@"version_num":[SysUtils shortVersion],@"source":@"2"};
    [self asyncSendRequestWithURL:Login_URL param:dic RequestMethod:POST showHUD:YES result:^(id dic, NSError *error) {
        if(dic){
            FIUser *user =[FIUser shareInstance];
            user.userName = dic[@"userName"];
            user.user_id = dic[@"user_id"];
            user.token = dic[@"token"];
            
            AppDelegate *delegate =   (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [delegate homeRootViewController];
            
        }
    }];
}

- (IBAction)registerClick:(id)sender {
    FIRegisterViewController * registerVC = [[FIRegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}
- (IBAction)fogetButtonClick:(id)sender {
    FIFindPasswordViewController * findVC = [[FIFindPasswordViewController alloc]init];
    [self.navigationController pushViewController:findVC animated:YES];
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
