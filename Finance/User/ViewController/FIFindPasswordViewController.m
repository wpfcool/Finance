//
//  FIFindPasswordViewController.m
//  Finance
//
//  Created by wenpeifang on 2018/6/19.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIFindPasswordViewController.h"
#import "FIResetPassViewController.h"
@interface FIFindPasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *codeField;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *codeButton;
@property (nonatomic,strong)dispatch_source_t timer;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *usernameTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *phoneTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *codeTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nextButtonTop;

@end

@implementation FIFindPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _usernameTopConstraint.constant = kIphone6Scale(122);
    _phoneTopConstraint.constant = kIphone6Scale(69);
    _codeTopConstraint.constant = kIphone6Scale(69);
    _nextButtonTop.constant = kIphone6Scale(50);
    
    
    _codeButton.layer.cornerRadius =  15;
    _codeButton.layer.borderWidth = 0.5;
    _codeButton.layer.borderColor =  HEX_UICOLOR(0x979797, 1).CGColor;
    _nextButton.layer.cornerRadius = 24;
}
- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
        }
        count--;
    });
    dispatch_resume(self.timer);
    
}

- (IBAction)codeButtonClick:(id)sender {
    if(_phoneField.text.length == 0){
        [self showAlert:@"手机号输入不能为空"];
        return;
    }
    [self.view endEditing:YES];
    NSDictionary * dic = @{@"phone":_phoneField.text};
    [self asyncSendRequestWithURL:SEND_IPHONE_CODE param:dic RequestMethod:POST showHUD:YES result:^(id dic, NSError *error) {
        if(error){
            
        }
        else{
            [self countDown];
        }
    }];
    
}
- (IBAction)nextButtonClick:(id)sender {
    if(_userNameField.text.length == 0 || _phoneField.text.length == 0 || _codeField.text.length == 0){
        [self showAlert:@"输入不能为空"];
        return;
    }
    
    
    NSDictionary * dic = @{@"userName":_userNameField.text,@"code":_codeField.text,@"phone":_phoneField.text};;
    
    [self asyncSendRequestWithURL:FORGETPASS_URL param:dic RequestMethod:POST showHUD:YES result:^(id dic, NSError *error) {
        if(!error){
            
            FIResetPassViewController * pass = [[FIResetPassViewController alloc]init];
            pass.username = self.userNameField.text;
            [self.navigationController pushViewController:pass animated:YES];
            
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
