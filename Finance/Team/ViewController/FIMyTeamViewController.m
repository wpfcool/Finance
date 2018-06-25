//
//  FIMyTeamViewController.m
//  Finance
//
//  Created by wenpeifang on 2018/6/21.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIMyTeamViewController.h"
#import "FiActiveMemberViewController.h"
#import "FIMyMasterViewController.h"
#import "FITeam.h"
@interface FIMyTeamViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)FITeam * team;
@end

@implementation FIMyTeamViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"我的团队";
    self.tableView.tableFooterView = [UIView new];
    [self loadData];
}

-(void)loadData{
    [self asyncSendRequestWithURL:MY_TEAM_URL param:@{@"user_id":[FIUser shareInstance].user_id} RequestMethod:POST showHUD:YES result:^(id dic, NSError *error) {
        if(!error){
            self.team = [FITeam yy_modelWithJSON:dic];
            [self.tableView reloadData];
        }
    }];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0){
        static NSString * cellIdentifierOne = @"oneCell";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifierOne];
        if(cell == nil){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifierOne];
            
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setBackgroundImage:[UIImage imageNamed:@"team_active"] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(activeClick:) forControlEvents:UIControlEventTouchUpInside];
            button.frame = CGRectMake((SCREEN_WIDTH-150)/2.0, (245-150)/2.0, 150, 150);
            [cell.contentView addSubview:button];
            
        }
        return cell;
    }
    else{
        static NSString * cellIdentifier = @"twoCell";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        }
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = HEX_UICOLOR(0x1A1A1A, 1);
        if(indexPath.row == 0){
            cell.textLabel.text = @"我的领导人";
        }
        else{
            cell.textLabel.text = @"我的团队总人数";
        }
        cell.detailTextLabel.textColor = HEX_UICOLOR(0x999999, 1);
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        if(indexPath.row == 0){
            cell.detailTextLabel.text = self.team.leader;
        }
        else{
            cell.detailTextLabel.text = self.team.teamNum;
        }
        cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"more"]];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        return 245;
    }
    
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(section == 0)
        return 10;
    return 0.01f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 1){
        if(indexPath.row == 0){
            FIMyMasterViewController * masterVC = [[FIMyMasterViewController alloc]init];
            [self.navigationController pushViewController:masterVC animated:YES];
        }
    }
}

-(void)activeClick:(id)sender{
    FiActiveMemberViewController * activeVC = [[FiActiveMemberViewController alloc]init];
    [self.navigationController pushViewController:activeVC animated:YES];
    
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
