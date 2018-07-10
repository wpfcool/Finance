//
//  FIOrderDetail1ViewController.m
//  Finance
//
//  Created by wenpeifang on 2018/7/10.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIOrderDetail1ViewController.h"
#import "FIOrderDetailTimeViewCell.h"
#import "FIOrderDetailOrderCell.h"
@interface FIOrderDetail1ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableVIew;
@property (weak, nonatomic) IBOutlet UIButton *complainButton;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomHeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation FIOrderDetail1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"订单详情";
    if((self.orderType & OrderTypeSell) &&( self.orderType & OrderTypeWaitingConfirm) ){
        self.bottomHeightConstraint.constant = 50;
        self.bottomView.hidden = NO;
    }else{
        self.bottomHeightConstraint.constant = 0;
        self.bottomView.hidden = YES;
    }
    self.tableVIew.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableVIew.backgroundColor = HEX_UICOLOR(0xf3f3f3, 1);
    self.tableVIew.tableFooterView = [UIView new];
//    [self.tableVIew registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellidentifer"];
    [self.tableVIew registerNib:[UINib nibWithNibName:@"FIOrderDetailTimeViewCell" bundle:nil] forCellReuseIdentifier:@"cellidentifer"];
    
    [self.tableVIew registerNib:[UINib nibWithNibName:@"FIOrderDetailOrderCell" bundle:nil] forCellReuseIdentifier:@"FIOrderDetailOrderCellidentifer"];

}
- (IBAction)complainClick:(id)sender {
}
- (IBAction)confirmClick:(id)sender {
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        FIOrderDetailTimeViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cellidentifer" forIndexPath:indexPath];
        cell.timeLabel.text = [self getTime:self.orderData.pay_time];
        return cell;
        
    }else if(indexPath.section == 1){
        
        FIOrderDetailOrderCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FIOrderDetailOrderCellidentifer" forIndexPath:indexPath];
        cell.orderType = self.orderType;
        cell.orderData = self.orderData;
        return cell;
    }
    
    return nil;

}
-(NSString *)getTime:(NSString *)time{
    
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:time.integerValue];
    NSDateFormatter * fommate = [[NSDateFormatter alloc]init];
    [fommate setDateFormat:@"hh:mm:ss"];
    return [fommate stringFromDate:date];
}

-(void)confirmPay:(NSString *)orderId{
    
    UIAlertController * controller = [UIAlertController alertControllerWithTitle:nil message:@"确认已经收到这笔款" preferredStyle:UIAlertControllerStyleAlert];
    [controller addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self asyncSendRequestWithURL:CONFIRMPAY_URL param:@{@"user_id":[FIUser shareInstance].user_id,@"order_id":orderId} RequestMethod:POST showHUD:YES result:^(id dic, NSError *error) {
            if(!error){
                
            }
        }];
    }]];
    
    [controller addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:controller animated:YES completion:nil];
    
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
