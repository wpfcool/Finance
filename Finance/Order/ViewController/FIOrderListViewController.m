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
#import "FIOrderDetail1ViewController.h"
#import "FIPingjiaViewController.h"
#import "HttpRequest.h"

@interface FIOrderListViewController ()<UITableViewDelegate,UITableViewDataSource,FIOrderDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,assign)NSInteger currentPage;
@property (nonatomic,strong)NSMutableArray * dataList;
@property (nonatomic,strong)NSString * orderId;//上传凭证id
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
        self.tableView.rowHeight =UITableViewAutomaticDimension;
    self.tableView.backgroundColor = HEX_UICOLOR(0xf3f3f3, 1);

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
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];

    }];
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FIOrderListCell * cell  =[tableView dequeueReusableCellWithIdentifier:@"FIOrderListCellidentifier" forIndexPath:indexPath];
    cell.delegate = self;
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
        self.orderType =  OrderTypeSell| indexType;
        cell.orderType =self.orderType;

        
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FIOrderDetail1ViewController * detail = [[FIOrderDetail1ViewController alloc]init];
    detail.orderData = self.dataList[indexPath.row];
    detail.orderType = self.orderType;
    [self.navigationController pushViewController:detail animated:YES];

    
}

-(void)uploadPingzheng:(NSString *)orderId{
    self.orderId = orderId;
    UIImagePickerController * pick = [[UIImagePickerController alloc]init];
    pick.delegate = self;
    pick.allowsEditing = YES;

    UIAlertController * controller = [UIAlertController alertControllerWithTitle:@"选择照片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [controller addAction:[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        pick.sourceType  = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:pick animated:YES completion:nil];

        
    }]];
    
    [controller addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        pick.sourceType  = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:pick animated:YES completion:nil];


    }]];
    [controller addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:controller animated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];

}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage]; //原始图片
    NSData * data =UIImageJPEGRepresentation(image, 0.1);
    [picker dismissViewControllerAnimated:YES completion:nil];

    //上传凭证
    [self showHUD];
        [HttpRequest upLoadWithURL:UPLOADPINGZHENGURL upData:data name:@"file" fileName:@"image.jpg" mimeType:@"mage/jpg" params:@{@"user_id":[FIUser shareInstance].user_id,@"order_id":self.orderId} result:^(id dic, NSError *error) {
            [self hiddenHUD];
            if(!error){
                [self.view makeToast:@"上传成功" duration:2.0];
            }
            
        }];

    
}
-(void)contactMemeber:(NSString *)orderId orderType:(OrderType)type{
    NSString * phontType = @"";
    if(type & OrderTypeBuy){
        phontType = @"2";
        
    }else if(type & OrderTypeSell){
        phontType = @"1";

    }
    [self asyncSendRequestWithURL:ORDERPHONE_URL param:@{@"user_id":[FIUser shareInstance].user_id,@"order_id":orderId,@"type":phontType} RequestMethod:POST showHUD:YES result:^(id dic, NSError *error) {
        if(!error){
            NSString * phone =dic[@"phone"];
            if(phone.length > 0){
                NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",phone];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            }else{
                [self.view makeToast:@"失败 " duration:2.0];
            }
        }
    }];
    
}
-(void)cuiConfirm:(NSString *)orderId{
    
}
-(void)confirmPay:(NSString *)orderId{
    
    UIAlertController * controller = [UIAlertController alertControllerWithTitle:nil message:@"确认已经收到这笔款" preferredStyle:UIAlertControllerStyleAlert];
    [controller addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self asyncSendRequestWithURL:CONFIRMPAY_URL param:@{@"user_id":[FIUser shareInstance].user_id,@"order_id":orderId} RequestMethod:POST showHUD:YES result:^(id dic, NSError *error) {
            if(!error){
                [self.view makeToast:@"成功" duration:2.0];
            }
        }];
    }]];
    
    [controller addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:controller animated:YES completion:nil];

}
-(void)complain:(FIOrderData *)orderData orderType:(OrderType)type{
    NSString * comType = @"1";
    if(type & OrderTypeBuy){
        comType = @"2";
    }else if(type & OrderTypeSell){
        comType = @"1";

    }
    
    UIAlertController * controller = [UIAlertController alertControllerWithTitle:@"确认未收到款，要投诉" message:@"银行转账正常到账时间为24小时之内，因各银行处理系统略有不同，可能会出现延迟，您可与匹配方先沟通处理。如12小时后确实未收到款，系统会要求购买会员在12小时之后提交付款凭证视频，如恶投" preferredStyle:UIAlertControllerStyleAlert];
    [controller addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self asyncSendRequestWithURL:COMPLAIN_URL param:@{@"user_id":[FIUser shareInstance].user_id,@"order_id":orderData.order_id,@"type":comType} RequestMethod:POST showHUD:YES result:^(id dic, NSError *error) {
            if(!error){
                [self.view makeToast:@"投诉成功" duration:2.0];
                orderData.is_lodge  =@"2";
                [self.tableView reloadData];
            }
        }];
        
        
        
    }]];
    
    [controller addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:controller animated:YES completion:nil];
}
-(void)pingjia:(NSString *)orderId orderType:(OrderType)type{
  
    FIPingjiaViewController * vc = [[FIPingjiaViewController alloc]init];
    vc.order_id = orderId;
    if(type & OrderTypeBuy){
        vc.type = 1;
    }else if(type & OrderTypeSell){
        vc.type = 2;

    }
    [self.navigationController pushViewController:vc animated:YES];
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
