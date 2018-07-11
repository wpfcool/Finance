//
//  FISellSeedViewController.m
//  Finance
//
//  Created by wenpeifang on 2018/6/25.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FISellSeedViewController.h"
#import "FITextFieldViewCell.h"
#import <Masonry/Masonry.h>
#import "FIHomeData.h"
#import "FIBusinessSeed.h"

@interface FISellSeedViewController ()<UITableViewDelegate,UITableViewDataSource,FITextFieldViewCellDelegate>
@property (nonatomic,strong)UILabel * dreamBagLabel;
@property (nonatomic,strong)UILabel * priceBagLabel;

@property (nonatomic,strong)NSArray * titleArr;
@property (nonatomic,strong)NSArray * placeHolderTitleArr;
@property (nonatomic,strong)FIStatusTextField * mondyTextField;
@property (nonatomic,strong)FIStatusTextField * typeTextField;

@property (nonatomic,strong)FIBusinessSeed * seed;

@end

@implementation FISellSeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _seed = [[FIBusinessSeed alloc]init];
    _titleArr = @[@"卖出云矿机",@"卖出云矿机数量",@"对应支付金额",@"输入安全密码"];
    _placeHolderTitleArr = @[@"请选择背包类型",@"请输入云矿机数量",@"1000",@"请输入安全密码"];

    UILabel * tmpDreamBag = [[UILabel alloc]init];
    tmpDreamBag.text = @"梦想背包(PCS)";
    tmpDreamBag.font = [UIFont systemFontOfSize:12];
    tmpDreamBag.textColor = HEX_UICOLOR(0xeeeeee, 1);
    [self.headerView addSubview:tmpDreamBag];

    [tmpDreamBag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_top).offset(60+[self navBarBottom]);
        make.centerX.equalTo(self.headerView.mas_centerX).offset(-SCREEN_WIDTH/4.0);
    }];
    
    UILabel * tmpPriceBag = [[UILabel alloc]init];
    tmpPriceBag.text = @"奖金背包(PCS)";
    tmpPriceBag.font = [UIFont systemFontOfSize:12];
    tmpPriceBag.textColor = HEX_UICOLOR(0xeeeeee, 1);
    [self.headerView addSubview:tmpPriceBag];
    
    [tmpPriceBag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_top).offset(60+[self navBarBottom]);
        make.centerX.equalTo(self.headerView.mas_centerX).offset(SCREEN_WIDTH/4.0);
    }];
    
    
    
    
    _dreamBagLabel = [[UILabel alloc]init];
    _dreamBagLabel.text = @"--";
    _dreamBagLabel.font = [UIFont systemFontOfSize:25];
    _dreamBagLabel.textColor = HEX_UICOLOR(0xffffff, 1);
    [self.headerView addSubview:_dreamBagLabel];
    
    [_dreamBagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tmpDreamBag.mas_bottom).offset(5);
        make.centerX.equalTo(tmpDreamBag.mas_centerX);
    }];
    
    _priceBagLabel = [[UILabel alloc]init];
    _priceBagLabel.text = @"--";
    _priceBagLabel.font = [UIFont systemFontOfSize:25];
    _priceBagLabel.textColor = HEX_UICOLOR(0xffffff, 1);
    [self.headerView addSubview:_priceBagLabel];
    
    [_priceBagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tmpPriceBag.mas_bottom).offset(5);
        make.centerX.equalTo(tmpPriceBag.mas_centerX);
    }];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"FITextFieldViewCell" bundle:nil] forCellReuseIdentifier:@"FITextFieldViewCel1l"];
    self.tableView.keyboardDismissMode =UIScrollViewKeyboardDismissModeOnDrag;

    [self loadData];
}

-(void)loadData{
    
    NSDictionary * dic = @{@"user_id":[FIUser shareInstance].user_id};
    [self asyncSendRequestWithURL:HOME_URL param:dic RequestMethod:POST showHUD:YES result:^(NSDictionary * dic, NSError *error) {
        if(!error){
           FIHomeData * home = [FIHomeData yy_modelWithJSON:dic];
            
            self.dreamBagLabel.text = home.dramSeed;
            self.priceBagLabel.text = home.bonusSeed;
            

        }
    }];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FITextFieldViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FITextFieldViewCel1l" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    cell.textField.secureTextEntry = NO;

    if(indexPath.row == 0){
        cell.textField.status = TextFieldStatusType;
        cell.textField.enabled = NO;
        self.typeTextField = cell.textField;
    }else if(indexPath.row == 1){
        cell.textField.status = TextFieldStatusNum;
        cell.textField.keyboardType = UIKeyboardTypeDecimalPad;

    }else if(indexPath.row == 2){
        cell.textField.status = TextFieldStatusMoney;
        self.mondyTextField = cell.textField;
        cell.textField.enabled = NO;
    }
    else if(indexPath.row == 3){
        cell.textField.status = TextFieldStatusPassword;
        cell.textField.secureTextEntry = YES;

    }

    cell.titleLabel.text = _titleArr[indexPath.row];
    cell.textField.placeholder = _placeHolderTitleArr[indexPath.row];
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        
        UIAlertController * controller = [UIAlertController alertControllerWithTitle:nil     message:@"选择背包类型" preferredStyle:UIAlertControllerStyleActionSheet];
        
        [controller addAction:[UIAlertAction actionWithTitle:@"梦想背包" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.typeTextField.text =@"梦想背包";
            self.seed.type = @"1";
            
        }]];
        [controller addAction:[UIAlertAction actionWithTitle:@"奖金背包" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.typeTextField.text =@"奖金背包";
            self.seed.type = @"2";


        }]];
        
        [controller addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        [self presentViewController:controller animated:YES completion:nil];
        
    }
    
}

-(void)textFieldDidChanged:(FIStatusTextField *)textField{
    if(textField.status == TextFieldStatusMoney){
    }else if(textField.status == TextFieldStatusPassword){
        
        self.seed.seedPassword = textField.text;
        
    }else if(textField.status == TextFieldStatusNum){
        self.seed.seedNum = textField.text;
        self.mondyTextField.text = [NSString stringWithFormat:@"%@",@([self.seed.seedNum floatValue] * 2000)] ;
        
    }
}

- (IBAction)submitClick:(id)sender {
    
    if(self.seed.seedNum.length == 0 || self.seed.seedPassword.length == 0){
        [self showAlert:@"输入不能为空"];
        return;
    }
    if(self.seed.type.length == 0){
        [self showAlert:@"请选择背包类型"];
        return;
    }
    [self asyncSendRequestWithURL:SELL_SEED_URL param:@{@"user_id":[FIUser shareInstance].user_id,@"password":self.seed.seedPassword,@"num":self.seed.seedNum,@"type":self.seed.type} RequestMethod:POST showHUD:YES result:^(NSDictionary * dic, NSError *error) {
        if(!error){
//            [self showAlert:];
            [self.view makeToast:dic[@"msg"] duration:2.0];
        }
    }];
    
}
-(NSString *)getTitle{
    return @"卖出云矿机";
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
