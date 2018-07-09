//
//  FIOrderListViewController.m
//  Finance
//
//  Created by wenpeifang on 2018/7/9.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIOrderListViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "FIOrderListCell.h"
#import "FIOrderData.h"
#import "FIOrderDetailViewController.h"
@interface FIOrderListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,assign)NSInteger currentPage;
@property (nonatomic,strong)NSMutableArray * dataList;

@property (nonatomic,assign)OrderType orderType;
@end

@implementation FIOrderListViewController
-(NSMutableArray *)dataList{
    if(!_dataList){
        _dataList = [[NSMutableArray alloc]init];
    }
    return _dataList;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.currentPage = 1;
    self.view.backgroundColor = HEX_UICOLOR(0xf3f3f3, 1);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 155;
    self.tableView.backgroundColor = HEX_UICOLOR(0xf3f3f3, 1);
    self.tableView.rowHeight =UITableViewAutomaticDimension;
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FIOrderListCell" bundle:nil] forCellReuseIdentifier:@"FIOrderListCellidentifier"];
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
-(void)getListRequest{
    
    NSString * index = @"1";
    if(self.type == 0){
        index = @"1";
    }else if(self.type == 1){
        index = @"2";
    }else if(self.type == 2){
        index = @"3";
    }else if(self.type ==3){
        index = @"7";
    }
    
    [self asyncSendRequestWithURL:ORDERLIST_URL param:@{@"user_id":[FIUser shareInstance].user_id,@"buyType":@(self.orderCataory),@"type":index,@"pageNo":@(self.currentPage),@"pageSize":@20} RequestMethod:POST showHUD:NO result:^(NSArray * arr, NSError *error) {
        if(!error){
            if(arr.count != 20){
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            if(self.currentPage == 1){
                [self.dataList removeAllObjects];
            }
            for (NSDictionary * dic in arr) {
                FIOrderData * data = [FIOrderData yy_modelWithJSON:dic];
                [self.dataList addObject:data];
            }
            [self.tableView reloadData];
        }
    }];
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FIOrderListCell * cell  =[tableView dequeueReusableCellWithIdentifier:@"FIOrderListCellidentifier" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    OrderType indexType = OrderTypeNone;
    if(self.type == 0){
        indexType =OrderTypeWaitingMatch;
    }else   if(self.type == 1){
        indexType =OrderTypeWaitingPay;
    }else  if(self.type == 2){
        indexType =OrderTypeWaitingConfirm;
    }else if(self.type == 3){
        indexType =OrderTypeWaitingPingjia;

    }

    cell.orderData = self.dataList[indexPath.row];
    
    if(self.orderCataory == 1){
        //买入
        self.orderType =  OrderTypeBuy | indexType;
        cell.orderType =self.orderType;
   
    }else if(self.orderCataory == 2){
        self.orderType =  OrderTypeBuy | indexType;
        cell.orderType =self.orderType;

        
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FIOrderDetailViewController * detail = [[FIOrderDetailViewController alloc]init];
    detail.orderData = self.dataList[indexPath.row];
    detail.orderType = self.orderType;
    [self.navigationController pushViewController:detail animated:YES];

    
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
