//
//  FiActiveMemberViewController.m
//  Finance
//
//  Created by wenpeifang on 2018/6/21.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FiActiveMemberViewController.h"

@interface FiActiveMemberViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UIButton *activieButton;


@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@end

@implementation FiActiveMemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.title = @"激活会员";
    self.activieButton.layer.cornerRadius = 24;
    [self getCodeNum];
}

-(void)getCodeNum{
    [self asyncSendRequestWithURL:ACTIVIE_NUM_URL param:@{@"user_id":[FIUser shareInstance].user_id} RequestMethod:POST showHUD:YES result:^(id dic, NSError *error) {
        if(!error){
            self.countLabel.text = [NSString stringWithFormat:@"您当前的激活码数量是：%@",dic];
        }
    }];
}

- (IBAction)activeClick:(id)sender {
    [self.userNameField resignFirstResponder];
    
    if(_userNameField.text.length == 0){
        [self showAlert:@"输入不能为空"];
        return;
    }
    
    [self asyncSendRequestWithURL:ACTIVIE_URL param:@{@"user_id":[FIUser shareInstance].user_id,@"username":_userNameField.text} RequestMethod:POST showHUD:YES result:^(NSDictionary * dic, NSError *error) {
        if(!error){
            self.userNameField.text = @"";
            self.countLabel.text = [NSString stringWithFormat:@"您当前的激活码数量是：%@",dic[@"grade"]];
        }
    }];
    

}
- (IBAction)howToActive:(id)sender {
    [self.userNameField resignFirstResponder];

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
