//
//  FIBankInfoViewController.m
//  Finance
//
//  Created by 海龙 on 2018/7/5.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIBankInfoViewController.h"
#import "FIHorizontalTextFieldCell.h"
#import <Masonry/Masonry.h>
#import "FIAlterInfoWithMoneyCell.h"
#import "FIPropListViewController.h"
@interface FIBankInfoViewController ()<UITableViewDataSource,UITableViewDelegate,FITextFieldViewCellDelegate,FIAlterInfoWithMoneyCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (nonatomic,strong)NSString * number;

@end

@implementation FIBankInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if(self.bankData){
        self.navigationItem.title = @"修改账号";
    }else{
        self.navigationItem.title = @"添加账号";
        self.bankData = [[FIBankData alloc]init];
    }
    
    self.submitButton.layer.cornerRadius = 24;
    self.tableView.sectionFooterHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedSectionFooterHeight = 100;;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.tableView registerNib:[UINib nibWithNibName:@"FIHorizontalTextFieldCell" bundle:nil] forCellReuseIdentifier:@"FIHorizontalTextFieldCell1"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FIAlterInfoWithMoneyCell" bundle:nil] forCellReuseIdentifier:@"FIAlterInfoWithMoneyCell"];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getPropNum];
}
-(void)getPropNum{
    
    //    1、改银行卡
    [self asyncSendRequestWithURL:PROP_NUM_URL param:@{@"user_id":[FIUser shareInstance].user_id,@"prop_id":@(1)} RequestMethod:POST showHUD:YES result:^(NSString * dic, NSError *error) {
        if(!error){
            self.number = dic;
            [self.tableView reloadData];
        }
    }];
}
- (IBAction)submitClick:(id)sender {

    if(self.bankData.bankCard.length == 0 || self.bankData.bankName.length == 0){
        [self showAlert:@"输入不能为空"];
        return;
    }
    
    [self asyncSendRequestWithURL:ADD_BANK_URL param:@{@"user_id":[FIUser shareInstance].user_id,@"bankname":self.bankData.bankName,@"bankcard":self.bankData.bankCard} RequestMethod:POST showHUD:YES result:^(id dic, NSError *error) {
        if(!error){
            [self.view makeToast:@"成功" duration:2.0];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 3){
        FIAlterInfoWithMoneyCell * cell =[tableView dequeueReusableCellWithIdentifier:@"FIAlterInfoWithMoneyCell" forIndexPath:indexPath];
        cell.titleTextField.textColor = HEX_UICOLOR(0x1A1A1A, 1);
        cell.titleTextField.font = [UIFont systemFontOfSize:14];
        cell.rightButton.titleLabel.font =  [UIFont systemFontOfSize:15];;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        cell.titleTextField.text = [NSString stringWithFormat:@"已有改银行卡:%@张",self.number];
        [cell.rightButton setTitle:@"去购买" forState:UIControlStateNormal];
        [cell.rightButton setTitleColor:HEX_UICOLOR(0xEB5D00, 1) forState:UIControlStateNormal];
        cell.titleTextField.enabled = NO;
        return cell;
    }else{
        FIHorizontalTextFieldCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FIHorizontalTextFieldCell1" forIndexPath:indexPath];
        
        
        cell.delegate = self;
        cell.contentTextField.userInteractionEnabled = YES;
        
        switch (indexPath.row) {
            case 0:
            {
                cell.titleLabel.text = @"持卡人:";
                cell.contentTextField.text = self.realName;
                cell.contentTextField.userInteractionEnabled = NO;
            }
                break;
            case 1:{
                cell.titleLabel.text = @"银行名称:";
                cell.contentTextField.text = self.bankData.bankName;
                cell.contentTextField.placeholder = @"请输入银行名称";
                cell.contentTextField.status =TextFieldStatusTypeBankName;
                
            }
                
                break;
            case 2:{
                cell.titleLabel.text = @"银行账号:";
                cell.contentTextField.text = self.bankData.bankCard;
                cell.contentTextField.placeholder = @"请输入银行账号";
                cell.contentTextField.status =TextFieldStatusTypeBankCard;
                
            }
                
                break;
                
            default:
                break;
        }
        
        return cell;
    }
    return nil;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView * view = [[UIView alloc]init];
    UILabel * label = [[UILabel alloc]init];
    label.attributedText = [SysUtils attributeStringWithRedX:@"*请务必确保银行信息正确，如因错误的银行信息导致收不到款，会员自行承担责任。"] ;
    label.numberOfLines = 0;
    [view addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).offset(15);
        make.right.equalTo(view.mas_right).offset(-15);
        make.top.equalTo(view.mas_top).offset(15);
        make.bottom.equalTo(view.mas_bottom).offset(-15);
        
    }];
    return view;
    
}
-(void)buttonClick:(FIAlterInfoWithMoneyCell *)cell{
    
    FIPropListViewController * VC = [[FIPropListViewController alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
}
-(NSMutableAttributedString *)attributeStringWithRedX:(NSString *)str{
    NSMutableAttributedString * string = [[NSMutableAttributedString alloc]initWithString:str];
      [string addAttribute:NSForegroundColorAttributeName value:HEX_UICOLOR(0x3F3F3F, 1) range:NSMakeRange(0, str.length)];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
    [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, str.length)];
  
    return string;
}
-(void)textFieldDidChanged:(FIStatusTextField * )textField{

    if(textField.status == TextFieldStatusTypeBankName){
        self.bankData.bankName = textField.text;
        
    }else if(textField.status == TextFieldStatusTypeBankCard){
        self.bankData.bankCard = textField.text;
        
    }
//    [self.tableView reloadData];
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
