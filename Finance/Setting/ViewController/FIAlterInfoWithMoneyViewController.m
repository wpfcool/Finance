//
//  FIRealNameViewController.m
//  Finance
//
//  Created by wenpeifang on 2018/6/28.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIAlterInfoWithMoneyViewController.h"
#import "FIAlterInfoWithMoneyCell.h"
#import "FIPropListViewController.h"
@interface FIAlterInfoWithMoneyViewController ()<FIAlterInfoWithMoneyCellDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)  NSString  *number;

@end

@implementation FIAlterInfoWithMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if(self.alterType == PropTypeRealName){
        self.navigationItem.title = @"真实姓名";
        
        
    }else if(self.alterType == PropTypePhone){
        self.navigationItem.title = @"手机号码";
        
    }
    self.tableView.tableFooterView =[UIView new];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FIAlterInfoWithMoneyCell" bundle:nil] forCellReuseIdentifier:@"FIAlterInfoWithMoneyCell"];
    
    [self getPropNum];
}

-(void)getPropNum{
    
//    1、改银行卡 2、改名卡
    [self asyncSendRequestWithURL:PROP_NUM_URL param:@{@"user_id":[FIUser shareInstance].user_id,@"prop_id":@(self.alterType)} RequestMethod:POST showHUD:YES result:^(NSString * dic, NSError *error) {
        if(!error){
            self.number = dic;
            [self.tableView reloadData];
        }
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    FIAlterInfoWithMoneyCell * cell =[tableView dequeueReusableCellWithIdentifier:@"FIAlterInfoWithMoneyCell" forIndexPath:indexPath];
    cell.titleTextField.textColor = HEX_UICOLOR(0x1A1A1A, 1);
    cell.titleTextField.font = [UIFont systemFontOfSize:15];
    cell.rightButton.titleLabel.font =  [UIFont systemFontOfSize:15];;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    if(indexPath.row == 0){
        if(self.alterType == PropTypeRealName){
            cell.titleTextField.text = self.userInfo.trueName;
            cell.titleTextField.placeholder = @"请输入真实姓名";
        }
        
        else if(self.alterType == PropTypePhone){
            cell.titleTextField.text = self.userInfo.phone;
            cell.titleTextField.placeholder = @"请输入手机号码";

        }
        
        [cell.rightButton setTitle:@"修改" forState:UIControlStateNormal];
        [cell.rightButton setTitleColor:HEX_UICOLOR(0x999999, 1) forState:UIControlStateNormal];
        cell.titleTextField.enabled = YES;
    }else{
        if(self.alterType == PropTypeRealName)
            cell.titleTextField.text = [NSString stringWithFormat:@"已有改姓名卡:%@张",self.number];
        else if(self.alterType == PropTypePhone)
            cell.titleTextField.text = [NSString stringWithFormat:@"已有改手机号卡:%@张",self.number];
        
        [cell.rightButton setTitle:@"去购买" forState:UIControlStateNormal];
        [cell.rightButton setTitleColor:HEX_UICOLOR(0xEB5D00, 1) forState:UIControlStateNormal];
        cell.titleTextField.enabled = NO;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(void)buttonClick:(FIAlterInfoWithMoneyCell *)cell{
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    if(indexPath.row == 0){
        NSString * text = cell.titleTextField.text;
        
        NSLog(@"-===%@",text);
        if(self.alterType == PropTypeRealName){
            //修改真实姓名
            [self alertRealName:text];
            
        }else if(self.alterType == PropTypePhone){
            [self alertPhone:text];
        }

        
    }else if(indexPath.row == 1){
        NSLog(@"???");

        
        FIPropListViewController * VC = [[FIPropListViewController alloc]init];
        [self.navigationController pushViewController:VC animated:YES];
        
    }
}
-(void)alertRealName:(NSString *)realName{
    if(realName.length==0){
        [self showAlert:@"请输入姓名"];
        return;
    }
    if([realName isEqualToString:self.userInfo.trueName]){
        [self showAlert:@"不能和旧手机号相同"];
        return;
    }
    
    [self asyncSendRequestWithURL:ALTER_REALNAME_URL param:@{@"user_id":[FIUser shareInstance].user_id,@"username":realName} RequestMethod:POST showHUD:YES result:^(id dic, NSError *error) {
        
    }];
}
-(void)alertPhone:(NSString *)phone{
    
    if(phone.length==0 || phone.length!=11){
        [self showAlert:@"手机号输入不正确"];
        return;
    }
    if([phone isEqualToString:self.userInfo.phone]){
        [self showAlert:@"不能和旧手机号相同"];
        return;
    }
         
    [self asyncSendRequestWithURL:ALTERPHONE_URL param:@{@"user_id":[FIUser shareInstance].user_id,@"phone":phone} RequestMethod:POST showHUD:YES result:^(id dic, NSError *error) {
        if(!error){
            [self.view makeToast:dic[@"msg"] duration:2.0];
        }
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 30;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(14, 0, SCREEN_WIDTH-28, 30)];
    if(self.alterType == PropTypeRealName){
        label.attributedText = [SysUtils attributeStringWithRedX:@"*如需更改手机号，请先到道具商城购买改手机号卡。"];

    }else if(self.alterType == PropTypePhone){
        label.attributedText = [SysUtils attributeStringWithRedX:@"*如需更改账号姓名，请先到道具商城购买改姓名卡。"];

    }
    [view addSubview:label];
    return view;
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
