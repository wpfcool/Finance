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
@interface FIRegisterViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UIButton *codeButton;
@property (weak, nonatomic) IBOutlet UIButton *nextStepButton;
@property (nonatomic,strong)dispatch_source_t timer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topestonstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *passwordTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *codeTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *codeBottonConstraint;
@end

@implementation FIRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.topestonstraint.constant = kIphone6Scale(122);
    self.passwordTopConstraint.constant = kIphone6Scale(69);
    self.codeTopConstraint.constant = kIphone6Scale(69);
    self.codeBottonConstraint.constant = kIphone6Scale(69);
    self.navigationController.navigationBarHidden = YES;
    _codeButton.layer.cornerRadius =  15;
    _codeButton.layer.borderWidth = 0.5;
    _codeButton.layer.borderColor =  HEX_UICOLOR(0x979797, 1).CGColor;
    _nextStepButton.layer.cornerRadius = 24;
    
}


-(void)countDown{
    __block int count = 120;
    dispatch_queue_t queue = dispatch_get_main_queue();
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(self.timer, dispatch_time(DISPATCH_TIME_NOW, 0*NSEC_PER_SEC), 1*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(self.timer, ^{
        [self.codeButton setTitle:[NSString stringWithFormat:@"%@s",@(count)] forState:UIControlStateNormal];
        if(count <=0){
            [self.codeButton setTitle:[NSString stringWithFormat:@"获得验证码"] forState:UIControlStateNormal];
            dispatch_cancel(self.timer);
            self.timer = nil;
            self.codeButton.userInteractionEnabled = YES;

        }
        count--;
    });
    dispatch_resume(self.timer);
    
}
- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
            [self countDown];
            self.codeButton.userInteractionEnabled = NO;
        }
    }];
    
}
- (IBAction)nextClick:(id)sender {
    if(_userNameTextField.text.length == 0 || _passwordTextField.text.length == 0 || _phoneTextField.text.length == 0  || _codeTextField.text.length == 0){
        [self showAlert:@"输入不能为空"];
        return;
    }
    
    NSDictionary * dic = @{@"userName":_userNameTextField.text,@"password":_passwordTextField.text,@"phone":_phoneTextField.text,@"code":_codeTextField.text,@"system_num":[SysUtils uuid],@"version_num":[SysUtils shortVersion],@"source":@"2"};
    
    FIRegisterFinishViewController * registerNextVC = [[FIRegisterFinishViewController alloc]init];
    registerNextVC.preDic = dic;
    [self.navigationController pushViewController:registerNextVC animated:YES];

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
