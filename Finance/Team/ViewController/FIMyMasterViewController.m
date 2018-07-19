//
//  FIMyMasterViewController.m
//  Finance
//
//  Created by wenpeifang on 2018/6/21.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIMyMasterViewController.h"
#import "FITeam.h"
#import "FISectionHeaderCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface FIMyMasterViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)FILeader * leader;
@end

static NSString * headerIdentifer = @"headerIdentifer";
@implementation FIMyMasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"详细资料";
    self.tableView.tableFooterView = [UIView new];
    _tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    _tableView.separatorColor = HEX_UICOLOR(0xE7E7E7, 1);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"FISectionHeaderCell" bundle:nil] forCellReuseIdentifier:headerIdentifer];
    [self loadData];
}

-(void)loadData{
    [self asyncSendRequestWithURL:MY_LEADER_URL param:@{@"user_id":[FIUser shareInstance].user_id} RequestMethod:POST showHUD:YES result:^(id dic, NSError *error) {
        if(!error){
            self.leader = [FILeader yy_modelWithJSON:dic];
            [self.tableView reloadData];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
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
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        static NSString * cellIdentifier = @"cell";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-70)/2.0, (160-70)/2.0-10, 70, 70)];
            imageView.tag = 100;
            imageView.clipsToBounds = YES;
            imageView.layer.cornerRadius = 35;
            imageView.layer.borderColor = [UIColor colorWithRed:254/255.0 green:222/255.0 blue:181/255.0 alpha:1].CGColor;
            imageView.image = [UIImage imageNamed:@"home_avator_default"];
            imageView.layer.borderWidth = 2;
            [cell.contentView addSubview:imageView];
            
            UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame)+10, SCREEN_WIDTH, 20)];
            nameLabel.font = [UIFont systemFontOfSize:15];
            nameLabel.textColor = HEX_UICOLOR(0x1A1A1A, 1);
            nameLabel.tag = 101;
            nameLabel.textAlignment = NSTextAlignmentCenter;
            [cell.contentView addSubview:nameLabel];
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        UIImageView * imageView = [cell.contentView viewWithTag:100];
        UILabel * nameLabel  = [cell.contentView viewWithTag:101];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.leader.user_image] placeholderImage:[UIImage imageNamed:@"user_image"]];
        nameLabel.text = self.leader.nickName;
        
        return cell;
    }else{
        
        if(indexPath.row == 0){
            FISectionHeaderCell * cell = [tableView dequeueReusableCellWithIdentifier:headerIdentifer forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            cell.nameLabel.text = @"个人信息";
            cell.nameLabel.font = [UIFont systemFontOfSize:15];
            cell.nameLabel.textColor = HEX_UICOLOR(0x1A1A1A, 1);
            [cell hiddenMore:YES];
            cell.lineVew.hidden = YES;
            return cell;
        }else{
            static NSString * otherlIdentifier = @"otherlIdentifier";
            FIBaseTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:otherlIdentifier];
            if(cell == nil){
                cell = [[FIBaseTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:otherlIdentifier];
            }
            cell.lineVew.hidden = NO;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.textColor = HEX_UICOLOR(0x1A1A1A, 1);
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            if(indexPath.row == 1){
                cell.textLabel.text = [NSString stringWithFormat:@"姓名：%@",self.leader.trueName];
            }
            if(indexPath.row == 2){
                cell.textLabel.text = [NSString stringWithFormat:@"联系电话：%@",self.leader.phone];
            }
            return cell;
        }

    }
    
    return nil;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        return 160;
    }else{
        return 50;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(section == 0)
    return 10;
    return 0.01;
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
