//
//  FIScoreViewController.m
//  Finance
//
//  Created by wenpeifang on 2018/7/6.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIScoreListViewController.h"
#import "FIScoreTableViewCell.h"
#import <MJRefresh/MJRefresh.h>
#import "FIScoreData.h"
@interface FIScoreListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableArray * dataList;
@property (nonatomic,assign)NSInteger currentPage;
@end

@implementation FIScoreListViewController

-(NSMutableArray *)dataList{
    if(!_dataList){
        _dataList = [[NSMutableArray alloc]init];
    }
    return _dataList;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.emptyLabel.text = @"暂无数据";
    self.emptyImageView.image = [UIImage imageNamed:@"empty_no_data"];
    [self emptyViewPositionCenterY:100];
    self.view.backgroundColor = HEX_UICOLOR(0xf3f3f3, 1);
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.currentPage = 1;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.backgroundColor = HEX_UICOLOR(0xf3f3f3, 1);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"FIScoreTableViewCell" bundle:nil] forCellReuseIdentifier:@"FIScoreTableViewCell"];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerFresh)];

    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerFresh)];
    
    [self getListRequest];
}
-(void)headerFresh{
    self.currentPage = 1;

    [self getListRequest];
}
-(void)footerFresh{
    self.currentPage++;
    [self getListRequest];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc] init];
    view.backgroundColor =HEX_UICOLOR(0xf3f3f3, 1);
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(void)getListRequest{
    
    NSString * scoreType = self.type == 0?@"1":@"2";
    
    NSDictionary * dic = @{@"user_id":[FIUser shareInstance].user_id,@"pageNo":@(self.currentPage),@"pageSize":@20,@"type":scoreType};
    [self asyncSendRequestWithURL:SCORELIST_URL param:dic RequestMethod:POST showHUD:NO result:^(NSArray *arr, NSError *error) {
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        if(!error){
            if(arr.count != 20){
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            if(self.currentPage == 1){
                [self.dataList removeAllObjects];
            }
            for (NSDictionary * dic in arr) {
                FIScoreData * data = [FIScoreData yy_modelWithJSON:dic];
                [self.dataList addObject:data];
            }
            
            if(self.dataList.count == 0){
                [self emptyViewShow];
            }else{
                [self emptyViewHidden];
            }
            [self.tableView reloadData];
        }
    }];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FIScoreTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FIScoreTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    FIScoreData * item = self.dataList[indexPath.row];
    
    cell.nameLabel.text = item.username;
    cell.orderNo.text = item.orderNo;
    if(self.type == 0){
        cell.scoreLabel.text = [NSString stringWithFormat:@"%.1f",item.sell_score.doubleValue] ;
        cell.timeLabel.text = [SysUtils getDate:item.sell_evaluate_time];
    }else{
        cell.scoreLabel.text = [NSString stringWithFormat:@"%.1f",item.score.doubleValue] ;
        cell.timeLabel.text = [SysUtils getDate:item.time];

    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 125;
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
