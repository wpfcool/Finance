//
//  FIBuySeedViewController.m
//  Finance
//
//  Created by wenpeifang on 2018/6/24.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIBuySeedViewController.h"
#import <Masonry/Masonry.h>
#import "FITextFieldViewCell.h"
#import "FIBusinessSeed.h"
#import "SysUtils.h"
@interface FIBuySeedViewController ()<UITableViewDelegate,UITableViewDataSource,FITextFieldViewCellDelegate>
@property (nonatomic,strong)UILabel * timeLabel;
@property (nonatomic,strong)UILabel * countLabel;
@property (nonatomic,strong)NSArray * titleArr;
@property (nonatomic,strong)NSArray * placeHolderTitleArr;
@property (nonatomic,strong)FIStatusTextField * mondyTextField;
@property (nonatomic,strong)FIBusinessSeed * seed;
@end

@implementation FIBuySeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    _seed = [[FIBusinessSeed alloc]init];
    _titleArr = @[@"购买云矿机数量",@"对应支付金额",@"输入安全密码"];
    _placeHolderTitleArr = @[@"当前等级可购买1-20颗云矿机",@"5000",@"请输入安全密码"];

    UILabel * timeTmp = [[UILabel alloc]init];
    timeTmp.font = [UIFont systemFontOfSize:11];
    timeTmp.text = @"剩余时间";
    timeTmp.textColor = [UIColor whiteColor];
    [self.headerView addSubview:timeTmp];
    
    [timeTmp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_top).offset(28+[self navBarBottom]);
        make.centerX.equalTo(self.headerView);
    }];
    
    
   _timeLabel = [[UILabel alloc]init];
    _timeLabel.font = [UIFont systemFontOfSize:35];
    _timeLabel.text  = @"-------";
    _timeLabel.textColor = [UIColor whiteColor];
    [self.headerView addSubview:_timeLabel];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(timeTmp.mas_bottom).offset(18);
        make.centerX.equalTo(self.headerView);
    }];
    
    
    _countLabel = [[UILabel alloc]init];
    _countLabel.font = [UIFont systemFontOfSize:19];
    _countLabel.text  = @"5";
    _countLabel.textColor = [UIColor whiteColor];
    [self.headerView addSubview:_countLabel];
    
    [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.headerView.mas_bottom).offset(-20);
        make.centerX.equalTo(self.headerView);
    }];
    
    UILabel * countTmpLabel = [[UILabel alloc]init];
    countTmpLabel.font = [UIFont systemFontOfSize:11];
    countTmpLabel.text  = @"播种次数(次)";
    countTmpLabel.textColor = [UIColor whiteColor];
    [self.headerView addSubview:countTmpLabel];
    
    [countTmpLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.countLabel.mas_top).offset(-3);
        make.centerX.equalTo(self.headerView);
    }];
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"FITextFieldViewCell" bundle:nil] forCellReuseIdentifier:@"FITextFieldViewCell"];
    self.tableView.keyboardDismissMode =UIScrollViewKeyboardDismissModeOnDrag;
    [self getCOunt];

}

-(void)getCOunt{
    [self asyncSendRequestWithURL:TIME_SEED_COUNT_URL param:@{@"user_id":[FIUser shareInstance].user_id} RequestMethod:POST showHUD:YES result:^(NSDictionary * dic, NSError *error) {
        if(!error){
            self.timeLabel.text =[SysUtils getTime: [NSString stringWithFormat:@"%@",dic[@"time"]] ];
            self.countLabel.text = [NSString stringWithFormat:@"%@",dic[@"num"]];
        }
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FITextFieldViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FITextFieldViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    
    cell.titleLabel.text = _titleArr[indexPath.row];
    cell.textField.placeholder = _placeHolderTitleArr[indexPath.row];
    cell.textField.secureTextEntry = NO;
    if(indexPath.row == 0){
        cell.textField.status = TextFieldStatusNum;
        cell.textField.keyboardType = UIKeyboardTypeDecimalPad;
        cell.textField.text = self.seed.seedNum;
    }else if(indexPath.row == 1){
        cell.textField.status = TextFieldStatusMoney;
        cell.textField.enabled = NO;
        self.mondyTextField = cell.textField;
        cell.textField.text = self.seed.seedPay;


    }else if(indexPath.row == 2){
        cell.textField.status = TextFieldStatusPassword;
        cell.textField.text =self.seed.seedPassword;
        cell.textField.secureTextEntry = YES;

    }
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}
-(NSString *)getTitle{
    return @"买入云矿机";
}

-(void)textFieldDidChanged:(FIStatusTextField *)textField{
    if(textField.status == TextFieldStatusMoney){
        
    }else if(textField.status == TextFieldStatusPassword){

        self.seed.seedPassword = textField.text;
        
    }else if(textField.status == TextFieldStatusNum){
        self.seed.seedNum = textField.text;
        self.seed.seedPay = [NSString stringWithFormat:@"%@",@([self.seed.seedNum floatValue] * 2000)] ;
        self.mondyTextField.text = self.seed.seedPay;
        
    }
}
- (IBAction)submitClick:(id)sender {
    
    if(self.seed.seedNum.length == 0 || self.seed.seedPassword.length == 0 ){
        [self showAlert:@"输入不能为空"];
        return;
    }
    
    [self asyncSendRequestWithURL:BUY_SEED_URL param:@{@"user_id":[FIUser shareInstance].user_id,@"password":self.seed.seedPassword,@"num":self.seed.seedNum} RequestMethod:POST showHUD:YES result:^(NSDictionary * dic, NSError *error) {
        if(!error){
            [self.view makeToast:dic[@"msg"] duration:2.0];
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
