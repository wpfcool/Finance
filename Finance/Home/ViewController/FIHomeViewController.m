//
//  FIHomeViewController.m
//  Finance
//
//  Created by wenpeifang on 2018/6/6.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIHomeViewController.h"
#import <WRNavigationBar/WRNavigationBar.h>
#import <Masonry/Masonry.h>
#import "FIHomeHeaderView.h"
#import "FIHomeManagerCell.h"
#import "FIHomeOrderHeaderCell.h"
#import "FIHomeOrderViewCell.h"
#import "FIUser.h"
#import "FIHomeData.h"
#import <YYModel/YYModel.h>
#import "FIMyTeamViewController.h"
#import "FInanceCenterViewController.h"


@interface FIHomeViewController ()<UITableViewDelegate,UITableViewDataSource,FIHomeManagerCellDelegate,FIHomeOrderViewCellDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)FIHomeHeaderView * headerView;
@property (nonatomic,strong)FIHomeData * homeData;
@end
static NSString * managerIdeintifier = @"managerCellIdeintifier";
static NSString * orderHeaderIdeintifier = @"orederHeaderIdeintifier";
static NSString * orderIdeintifier = @"orederIdeintifier";


@implementation FIHomeViewController

-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor =[UIColor colorWithRed:233/255.0 green:233/255.0  blue:233/255.0  alpha:1];
        _tableView.contentInset = UIEdgeInsetsMake(-[self navBarBottom], 0, 0, 0);
    }
    return _tableView;
}

-(FIHomeHeaderView *)headerView{
    if(!_headerView){
        _headerView = [[NSBundle mainBundle] loadNibNamed:@"FIHomeHeaderView" owner:self options:nil][0];
        _headerView.frame = CGRectMake( 0, 0, SCREEN_WIDTH, 247);
    }
    return _headerView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self wr_setNavBarShadowImageHidden:YES];
    [self.view addSubview:self.tableView];
    [self wr_setNavBarBarTintColor:[UIColor whiteColor]];
    [self wr_setNavBarBackgroundAlpha:0];
    [self wr_setNavBarTintColor:[UIColor whiteColor]];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"home_message"] style:UIBarButtonItemStyleDone target:self action:@selector(messageClick:)];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    UIView * header = [[UIView alloc] initWithFrame:CGRectMake( 0, 0, SCREEN_WIDTH, 247)];
    [header addSubview:self.headerView];
    self.tableView.tableHeaderView =header;
    
    
    [_tableView registerNib:[UINib nibWithNibName:@"FIHomeManagerCell" bundle:nil] forCellReuseIdentifier:managerIdeintifier];
    [_tableView registerNib:[UINib nibWithNibName:@"FIHomeOrderHeaderCell" bundle:nil] forCellReuseIdentifier:orderHeaderIdeintifier];
    [_tableView registerNib:[UINib nibWithNibName:@"FIHomeOrderViewCell" bundle:nil] forCellReuseIdentifier:orderIdeintifier];
    
    [self loadData];
}

-(void)loadData{
    
    NSDictionary * dic = @{@"user_id":[FIUser shareInstance].user_id};
    [self asyncSendRequestWithURL:HOME_URL param:dic RequestMethod:POST showHUD:NO result:^(NSDictionary * dic, NSError *error) {
        if(!error){
            self.homeData = [FIHomeData yy_modelWithJSON:dic];
            self.headerView.totalMoneyLabel.text = self.homeData.sum;
            self.headerView.dreamMoneyLabel.text = self.homeData.dramSeed;
            self.headerView.bonusMoneyLabel.text = self.homeData.bonusSeed;
            self.headerView.timeLabel.text = self.homeData.time;
        }
    }];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return 1;
    }
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return  175;
    }else{
        if(indexPath.row == 0){
            return 50;
        }
        return 92;
    }
    
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        FIHomeManagerCell * cell = [tableView dequeueReusableCellWithIdentifier:managerIdeintifier forIndexPath:indexPath];
        cell.delegate = self;
        return cell;
    }else{
        if(indexPath.row == 0){
            FIHomeOrderHeaderCell * cell = [tableView dequeueReusableCellWithIdentifier:orderHeaderIdeintifier forIndexPath:indexPath];
            if(indexPath.section == 1){
                cell.nameLabel.text = @"买入订单";
                
            }else if(indexPath.section == 2){
                cell.nameLabel.text = @"卖出订单";
                
            }
            return cell;
        }else{
            FIHomeOrderViewCell * cell = [tableView dequeueReusableCellWithIdentifier:orderIdeintifier forIndexPath:indexPath];
            cell.delegate = self;
            return cell;
        }
    }
    
    return nil;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}


-(void)financeCenterClick{
    FInanceCenterViewController * center = [[FInanceCenterViewController alloc]init];
    center.homeData = self.homeData;
    [self.navigationController pushViewController:center animated:YES];
    
}
-(void)myTeamClick{
    FIMyTeamViewController * teamVC = [[FIMyTeamViewController alloc]init];
    [self.navigationController pushViewController:teamVC animated:YES];
}
-(void)buyClick{
    
}
-(void)sellOutClick{
    
}

-(void)waitingAppraise:(FIHomeOrderViewCell *)cell{
    
}
-(void)waitingConfirmClick:(FIHomeOrderViewCell *)cell{
    
}
-(void)waitingPayClick:(FIHomeOrderViewCell *)cell{
    
}
-(void)waitingMatchClick:(FIHomeOrderViewCell *)cell{
    
}


-(void)messageClick:(id)sender{
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_COLORCHANGE_POINT)
    {
        CGFloat alpha = (offsetY - NAVBAR_COLORCHANGE_POINT) / NAV_HEIGHT;
        [self wr_setNavBarBackgroundAlpha:alpha];
        [self wr_setNavBarTintColor:[[UIColor blackColor] colorWithAlphaComponent:alpha]];
        [self wr_setNavBarTitleColor:[[UIColor blackColor] colorWithAlphaComponent:alpha]];
        [self wr_setStatusBarStyle:UIStatusBarStyleDefault];
        self.title = @"";
    }
    else
    {
        [self wr_setNavBarBackgroundAlpha:0];
        [self wr_setNavBarTintColor:[UIColor whiteColor]];
        [self wr_setNavBarTitleColor:[UIColor whiteColor]];
        [self wr_setStatusBarStyle:UIStatusBarStyleLightContent];
        self.title = @"";
    }
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
