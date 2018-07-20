//
//  FIPassworldAlterViewController.m
//  Finance
//
//  Created by 海龙 on 2018/7/6.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIPassworldAlterViewController.h"
#import "FIHorizontalTextFieldCell.h"
#import "AppDelegate.h"
#import "FISettingPasswordCodeCell.h"
@interface FIPassworldAlterViewController ()<UITableViewDelegate,UITableViewDataSource,FITextFieldViewCellDelegate,FISettingPasswordCodeCellDelegate>
@property (nonatomic,strong)NSArray * titleArr;
@property (nonatomic,strong)NSArray * placeHoldertitleArr;
@property (nonatomic,strong)dispatch_source_t timer;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@property (nonatomic,copy)NSString * passwordOld;
@property (nonatomic,copy)NSString * passwordNew;
@property (nonatomic,copy)NSString * passwordNew2;
@property (nonatomic,copy)NSString * codeString;


@end

@implementation FIPassworldAlterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.submitButton.layer.cornerRadius = 24;
    self.tableView.tableFooterView = [UIView new];
    _tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    _tableView.separatorColor = HEX_UICOLOR(0xE7E7E7, 1);
    if(self.type == 1){
        self.navigationItem.title = @"修改登录密码";
        self.titleArr = @[@"原密码:",@"新密码:",@"确认密码:"];
        self.placeHoldertitleArr = @[@"输入原密码",@"不少于8位数，包含至少1位数字和字母",@"再次输入新密码"];
    }else if(self.type == 2){
        self.navigationItem.title = @"修改安全密码";
        self.titleArr = @[@"新密码:",@"确认密码:"];
        self.placeHoldertitleArr = @[@"请输入6位数字 ",@"请输入6位数字 "];

    }
    [self.tableView registerNib:[UINib nibWithNibName:@"FIHorizontalTextFieldCell" bundle:nil] forCellReuseIdentifier:@"alterPassword"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FISettingPasswordCodeCell" bundle:nil] forCellReuseIdentifier:@"FISettingPasswordCodeCell"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0)
        return self.titleArr.count;
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        FIHorizontalTextFieldCell * cell  = [tableView dequeueReusableCellWithIdentifier:@"alterPassword" forIndexPath:indexPath];;
        cell.titleLabel.text = _titleArr[indexPath.row];
        cell.contentTextField.placeholder = _placeHoldertitleArr[indexPath.row];
        cell.delegate = self;
        cell.contentTextField.secureTextEntry = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if(self.type == 1){
            switch (indexPath.row) {
                case 0:
                    cell.contentTextField.status = TextFieldStatusTypePasswordOld;
                    cell.contentTextField.text = self.passwordOld;
                    break;
                case 1:
                    cell.contentTextField.status = TextFieldStatusTypePasswordNew;
                    cell.contentTextField.text = self.passwordNew;

                    break;
                case 2:
                    cell.contentTextField.status = TextFieldStatusTypePasswordNew2;
                    cell.contentTextField.text = self.passwordNew2;

                    break;
                default:
                    break;
            }
        }else if(self.type == 2){
            switch (indexPath.row) {
                case 0:
                    cell.contentTextField.status = TextFieldStatusTypePasswordNew;
                    cell.contentTextField.text = self.passwordNew;

                    break;
                case 1:
                    cell.contentTextField.status = TextFieldStatusTypePasswordNew2;
                    cell.contentTextField.text = self.passwordNew2;

                    break;

                default:
                    break;
            }
        }
        return cell;
    }
    else{
        FISettingPasswordCodeCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FISettingPasswordCodeCell" forIndexPath:indexPath];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.codeTextField.status = TextFieldStatusTypePasswordYanzhengMa;
        cell.codeTextField.text = self.codeString;
        return cell;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(void)textFieldDidChanged:(FIStatusTextField *)textField{
    
    if(textField.status == TextFieldStatusTypePasswordOld){
        self.passwordOld = textField.text;
    }else if(textField.status == TextFieldStatusTypePasswordNew){
        self.passwordNew = textField.text;
    }else if(textField.status == TextFieldStatusTypePasswordNew2){
        self.passwordNew2 = textField.text;
    }else if(textField.status == TextFieldStatusTypePasswordYanzhengMa){
        self.codeString = textField.text;
    }
}

-(void)countDown:(UIButton *)button{
    __block int count = 120;
    dispatch_queue_t queue = dispatch_get_main_queue();
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(self.timer, dispatch_time(DISPATCH_TIME_NOW, 0*NSEC_PER_SEC), 1*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(self.timer, ^{
        [button setTitle:[NSString stringWithFormat:@"%@s",@(count)] forState:UIControlStateNormal];
        if(count <=0){
            [button setTitle:[NSString stringWithFormat:@"获得验证码"] forState:UIControlStateNormal];
            dispatch_cancel(self.timer);
            self.timer = nil;
            button.userInteractionEnabled = YES;

        }
        count--;
    });
    dispatch_resume(self.timer);
}
-(void)codeButtonClick:(UIButton *)button{
 
    if(self.phone.length == 0){
        return;
    }

    NSDictionary * dic = @{@"phone":self.phone};
    [self asyncSendRequestWithURL:SEND_IPHONE_CODE param:dic RequestMethod:POST showHUD:YES result:^(id dic, NSError *error) {
        if(error){
            ;
        }
        else{
            [self countDown:button];
            button.userInteractionEnabled = NO;

        }
    }];
}
- (IBAction)submitClick:(id)sender {
    
    if(self.type == 1){
        
        if(self.passwordOld.length == 0 || self.passwordNew2.length == 0 || self.passwordNew.length == 0||self.codeString.length == 0){
            [self showAlert:@"输入不能为空"];
            return;
        }
        if(![self.passwordNew2 isEqualToString:self.passwordNew]){
            [self showAlert:@"两次密码输入不一致"];
            return;
        }
        
        if(![SysUtils isPasswordNumber:self.passwordNew]){
            [self showAlert:@"密码格式不正确"];
            return;
        }
        
        [self asyncSendRequestWithURL:ALTER_LOGINPASS_URL param:@{@"user_id": [FIUser shareInstance].user_id,@"password":self.passwordNew,@"repwd":self.passwordNew2,@"oldpwd":self.passwordOld,@"phone":self.phone,@"code":self.codeString} RequestMethod:POST showHUD:YES result:^(id dic, NSError *error) {
            if(!error){
                [self.view makeToast:@"修改成功,请重新登录" duration:1.0];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    AppDelegate * delegate =(AppDelegate *) [UIApplication sharedApplication].delegate;
                    [delegate loginRootViewController];
                });
           
                }
        }];
        
    }else if(self.type == 2){
        if(self.passwordNew2.length == 0 || self.passwordNew.length == 0||self.codeString.length == 0){
            [self showAlert:@"输入不能为空"];
            return;
        }
        
        if(![self.passwordNew2 isEqualToString:self.passwordNew]){
            [self showAlert:@"两次密码输入不一致"];
            return;
        }
        
        if(![SysUtils isSafePasswordNumber:self.passwordNew]){
            [self showAlert:@"安全密码应为6位数字"];
            return;
            
        }
        
        [self asyncSendRequestWithURL:ALTER_SAFEPASS_URL param:@{@"user_id": [FIUser shareInstance].user_id,@"password":self.passwordNew,@"repwd":self.passwordNew2,@"phone":self.phone,@"code":self.codeString} RequestMethod:POST showHUD:YES result:^(id dic, NSError *error) {
            if(!error){
                [self.view makeToast:@"修改成功" duration:2.0];
                [self.navigationController popViewControllerAnimated:YES];

            }
        }];
        
    }
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]init];
    view.backgroundColor = BGCOLOR;
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
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
