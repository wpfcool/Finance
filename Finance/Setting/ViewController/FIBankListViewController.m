//
//  FIBankListViewController.m
//  Finance
//
//  Created by 海龙 on 2018/7/2.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIBankListViewController.h"
#import "FIBankListViewCell.h"
@interface FIBankListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation FIBankListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"银行账户";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"+" style:UIBarButtonItemStylePlain target:self action:@selector(addClick:)];
    [self.tableView registerNib:[UINib nibWithNibName:@"FIBankListViewCell" bundle:nil] forCellReuseIdentifier:@"FIBankListViewCell"];
    self.tableView.tableFooterView = [UIView new];
    [self bankListRequest];
}
-(void)addClick:(id)sender{
    
}

-(void)bankListRequest{
    [self asyncSendRequestWithURL:BANKLIST_URL param:@{@"user_id":[FIUser shareInstance].user_id} RequestMethod:POST showHUD:YES result:^(id dic, NSError *error) {
        if(!error){
            
        }
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FIBankListViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FIBankListViewCell" forIndexPath:indexPath];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 155;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
