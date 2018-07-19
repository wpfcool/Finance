//
//  FIActivityCoceViewController.m
//  Finance
//
//  Created by wenpeifang on 2018/7/9.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIActivityCoceViewController.h"
#import <Masonry/Masonry.h>
#import "FIHorizontalTextFieldCell.h"
@interface FIActivityCoceViewController ()<UITableViewDataSource,UITableViewDelegate,FITextFieldViewCellDelegate>
@property (nonatomic,strong)UILabel * countLabel;
@property(nonatomic,strong)NSArray * titleArr;
@property (nonatomic,strong)NSString * userName;
@property (nonatomic,strong)NSString * codeCount;
@property (nonatomic,strong)NSString * safeCode;




@end

@implementation FIActivityCoceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _titleArr = @[@"会员用户名：",@"转码个数：",@"安全密码："];
    self.headerBgImageView.image = [UIImage imageNamed:@"account_score_bg"];
    self.countLabel = [[UILabel alloc]init];
    self.countLabel.font = [UIFont systemFontOfSize:45];
    self.countLabel.text = self.countString;
    self.countLabel.textColor = [UIColor whiteColor];
    [self.headerView addSubview:self.countLabel];
    
    UILabel * tmp = [[UILabel alloc]init];
    tmp.font = [UIFont systemFontOfSize:14];
    tmp.textColor = [UIColor whiteColor];
    tmp.text = @"当前激活码数量（个）";
    [self.headerView addSubview:tmp];
    
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.headerView);
    }];
    [tmp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.countLabel.mas_bottom).offset(14);
        make.centerX.equalTo(self.headerView);
    }];
    
    [self.submitButton setTitle:@"转码" forState:UIControlStateNormal];
    
    self.tableView.delegate = self;
    self.tableView.dataSource =self;
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"FIHorizontalTextFieldCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}

- (IBAction)submitClick:(id)sender {
    if(self.userName.length == 0 || self.codeCount.length == 0 || self.safeCode.length == 0){
        [self showAlert:@"输入不能为空"];
        return;
    }
    [self asyncSendRequestWithURL:GAVECODE_URL param:@{@"user_id":[FIUser shareInstance].user_id,@"username":self.userName,@"num":self.codeCount,@"password":self.safeCode} RequestMethod:POST showHUD:YES result:^(id dic, NSError *error) {
        if(!error){
            [self.view makeToast:@"成功" duration:2.0];
        }
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_titleArr count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FIHorizontalTextFieldCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLabel.text = self.titleArr[indexPath.row];
    cell.delegate = self;
    cell.contentTextField.secureTextEntry = NO;

    switch (indexPath.row) {
        case 0:
        {
            cell.contentTextField.placeholder = @"请输入会员用户名";
            cell.contentTextField.text = self.userName;
            cell.contentTextField.status = TextFieldStatusTypeCodeUserName;
        }
            break;
        case 1:
        {
            cell.contentTextField.placeholder = @"请输入转码个数";
            cell.contentTextField.text = self.codeCount;
            cell.contentTextField.status = TextFieldStatustypeCodeCount;
        }
            break;
        case 2:
        {
            cell.contentTextField.placeholder = @"请输入安全密码";
            cell.contentTextField.text = self.safeCode;
            cell.contentTextField.status = TextFieldStatustypeCodeSafeCode;
            cell.contentTextField.secureTextEntry = YES;
        }
            break;
            
        default:
            break;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(void)textFieldDidChanged:(FIStatusTextField *)textField{
    if(textField.status == TextFieldStatusTypeCodeUserName){
        self.userName  = textField.text;
    }else if(textField.status == TextFieldStatustypeCodeCount){
        self.codeCount = textField.text;
    }else if(textField.status == TextFieldStatustypeCodeSafeCode){
        self.safeCode = textField.text;
    }
}
-(NSString *)getTitle{
    return @"激活码";
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
