//
//  FIAddAliPayViewController.m
//  Finance
//
//  Created by wenpeifang on 2018/7/3.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIAddAliPayViewController.h"
#import "FIPropListViewController.h"
@interface FIAddAliPayViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *aliPayTextField;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

@end

@implementation FIAddAliPayViewController
- (IBAction)goShopClick:(id)sender {
    FIPropListViewController * VC = [[FIPropListViewController alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.submitButton.layer.cornerRadius = 24;
    
    if(self.payData){
           self.navigationItem.title = @"修改账户";
        self.userNameTextField.text = self.payData.alipayName;
        self.aliPayTextField.text = self.payData.alipayNum;
    }else{
        self.navigationItem.title = @"添加账户";
        self.payData = [[FIAliPayData alloc]init];
    }
 
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getPropNum];
}
-(void)getPropNum{
    
    //    1、改银行卡
    [self asyncSendRequestWithURL:PROP_NUM_URL param:@{@"user_id":[FIUser shareInstance].user_id,@"prop_id":@(1)} RequestMethod:POST showHUD:YES result:^(NSString * dic, NSError *error) {
        if(!error){
//            self.number = dic;
            self.numberLabel.text = [NSString stringWithFormat:@"%@张",dic];
        }
    }];
}
- (IBAction)submitClick:(id)sender {
    
    if(_aliPayTextField.text.length == 0 || _userNameTextField.text.length == 0){
        [self showAlert:@"输入不能为空"];
        return;
    }
    [self asyncSendRequestWithURL:ADD_ALIYPAY_URL param:@{@"user_id":[FIUser shareInstance].user_id,@"real_name":_userNameTextField.text,@"alipay":_aliPayTextField.text} RequestMethod:POST showHUD:YES result:^(id dic, NSError *error) {
        if(!error){
            [self.view makeToast:@"成功" duration:2.0];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
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
