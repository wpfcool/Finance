//
//  FISellSeedViewController.m
//  Finance
//
//  Created by wenpeifang on 2018/6/25.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FISellSeedViewController.h"
#import "FITextFieldViewCell.h"
@interface FISellSeedViewController ()<UITableViewDelegate,UITableViewDataSource,FITextFieldViewCellDelegate>

@end

@implementation FISellSeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"FITextFieldViewCell" bundle:nil] forCellReuseIdentifier:@"FITextFieldViewCel1l"];
}

-(void)loadData{
    
    NSDictionary * dic = @{@"user_id":[FIUser shareInstance].user_id};
    [self asyncSendRequestWithURL:HOME_URL param:dic RequestMethod:POST showHUD:YES result:^(NSDictionary * dic, NSError *error) {
        if(!error){
//            self.homeData = [FIHomeData yy_modelWithJSON:dic];

        }
    }];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FITextFieldViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FITextFieldViewCel1l" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    
    if(indexPath.row == 0){
        cell.textField.status = TextFieldStatusNum;
    }else if(indexPath.row == 1){
        cell.textField.status = TextFieldStatusMoney;
    }else if(indexPath.row == 2){
        cell.textField.status = TextFieldStatusPassword;
    }
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}

-(void)textFieldDidChanged:(FIStatusTextField *)textField{
    
}
-(NSString *)getTitle{
    return @"卖出种子";
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
