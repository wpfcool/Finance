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
#import "FISectionHeaderCell.h"
#import "FIHomeOrderViewCell.h"
#import "FIHomeData.h"
#import "FIMyTeamViewController.h"
#import "FInanceCenterViewController.h"
#import "FIBuySeedViewController.h"
#import "FISellSeedViewController.h"
#import "FIBagViewController.h"
#import "FIUserInfoViewController.h"
#import "FIOrderPageViewController.h"
@interface FIHomeViewController ()<UITableViewDelegate,UITableViewDataSource,FIHomeManagerCellDelegate,FIHomeOrderViewCellDelegate,FIHomeHeaderViewDelegate>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)FIHomeHeaderView * headerView;
@property (nonatomic,strong)FIHomeData * homeData;
@property (nonatomic,strong)  UIButton * leftButton ;
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
        _headerView.delegate = self;
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
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"home_message"] style:UIBarButtonItemStyleDone target:self action:@selector(messageClick:)];
    
    
    self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftButton .frame = CGRectMake(0, 0, 20, 20);
    [self.leftButton setBackgroundImage:[UIImage imageNamed:@"setting_avator"] forState:UIControlStateNormal];
//     self.leftButton .backgroundColor = [UIColor redColor];
    [self.leftButton  addTarget:self
                   action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
   self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.leftButton ];
    
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    UIView * header = [[UIView alloc] initWithFrame:CGRectMake( 0, 0, SCREEN_WIDTH, 247)];
    [header addSubview:self.headerView];
    self.tableView.tableHeaderView =header;
    
    
    [_tableView registerNib:[UINib nibWithNibName:@"FIHomeManagerCell" bundle:nil] forCellReuseIdentifier:managerIdeintifier];
    [_tableView registerNib:[UINib nibWithNibName:@"FISectionHeaderCell" bundle:nil] forCellReuseIdentifier:orderHeaderIdeintifier];
    [_tableView registerNib:[UINib nibWithNibName:@"FIHomeOrderViewCell" bundle:nil] forCellReuseIdentifier:orderIdeintifier];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self loadData];

}

-(void)loadData{
    
    NSDictionary * dic = @{@"user_id":[FIUser shareInstance].user_id};
    [self asyncSendRequestWithURL:HOME_URL param:dic RequestMethod:POST showHUD:YES result:^(NSDictionary * dic, NSError *error) {
        if(!error){
            self.homeData = [FIHomeData yy_modelWithJSON:dic];
            self.headerView.totalMoneyLabel.text = self.homeData.sum;
            self.headerView.dreamMoneyLabel.text = [NSString stringWithFormat:@"%.2f",self.homeData.dramSeed.doubleValue]  ;
            self.headerView.bonusMoneyLabel.text = [NSString stringWithFormat:@"%.2f",self.homeData.bonusSeed.doubleValue]  ;
//            self.headerView.timeLabel.text = self.homeData.time;
            self.headerView.timeLabel.text = [SysUtils getTime:self.homeData.time];
        }
    }];
    
}
-(void)headerOneClick{
    FIBagViewController * VC = [[FIBagViewController alloc]init];
    VC.type = 1;
    [self.navigationController pushViewController:VC animated:YES];
    
}
-(void)headerTwoClick{
    FIBagViewController * VC = [[FIBagViewController alloc]init];
    VC.type = 2;
    [self.navigationController pushViewController:VC animated:YES];
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
            FISectionHeaderCell * cell = [tableView dequeueReusableCellWithIdentifier:orderHeaderIdeintifier forIndexPath:indexPath];
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section ==1){
        if(indexPath.row == 0){
            [self jumpOrderListViewControllerWithCataory:1 index:0];
        }
    }else if(indexPath.section == 2){
        if(indexPath.row == 0){
            [self jumpOrderListViewControllerWithCataory:2 index:0];
        }
    }
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
    FIBuySeedViewController * seedVC = [[FIBuySeedViewController alloc]init];
    [self.navigationController pushViewController:seedVC animated:YES];
    
}
-(void)sellOutClick{
    FISellSeedViewController * seedVC = [[FISellSeedViewController alloc]init];
    [self.navigationController pushViewController:seedVC animated:YES];
    
}

-(void)waitingAppraise:(FIHomeOrderViewCell *)cell{
    NSIndexPath *indexpath = [self.tableView indexPathForCell:cell];
    if(indexpath.section == 1){
        [self jumpOrderListViewControllerWithCataory:1 index:3];
    }else{
        [self jumpOrderListViewControllerWithCataory:2 index:3];

    }
}
-(void)waitingConfirmClick:(FIHomeOrderViewCell *)cell{
    NSIndexPath *indexpath = [self.tableView indexPathForCell:cell];
    if(indexpath.section == 1){
        [self jumpOrderListViewControllerWithCataory:1 index:2];
    }else{
        [self jumpOrderListViewControllerWithCataory:2 index:2];
        
    }

}
-(void)waitingPayClick:(FIHomeOrderViewCell *)cell{
    NSIndexPath *indexpath = [self.tableView indexPathForCell:cell];
    if(indexpath.section == 1){
        [self jumpOrderListViewControllerWithCataory:1 index:1];
    }else{
        [self jumpOrderListViewControllerWithCataory:2 index:1];
        
    }

}
-(void)waitingMatchClick:(FIHomeOrderViewCell *)cell{
    NSIndexPath *indexpath = [self.tableView indexPathForCell:cell];
    if(indexpath.section == 1){
        [self jumpOrderListViewControllerWithCataory:1 index:0];
    }else{
        [self jumpOrderListViewControllerWithCataory:2 index:0];
        
    }

}

-(void)jumpOrderListViewControllerWithCataory:(NSInteger)type index:(NSInteger)inedex{
    FIOrderPageViewController * page = [[FIOrderPageViewController alloc]init];
    page.index = inedex;////0位待匹配1为待付款 2 待确认 3待评价
    page.orderCataory = type;//1买入2卖出
    [self.navigationController pushViewController:page animated:YES];
}
-(void)messageClick:(id)sender{
    
}

-(void)leftButtonClick:(id)sender{
    FIUserInfoViewController * VC = [[FIUserInfoViewController alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
    
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
