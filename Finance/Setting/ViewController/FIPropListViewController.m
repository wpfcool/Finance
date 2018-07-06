//
//  FIPropListViewController.m
//  Finance
//
//  Created by wenpeifang on 2018/6/28.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIPropListViewController.h"
#import "FIPropData.h"
#import <YYModel/YYModel.h>
#import "FIPropDetailViewController.h"
#import "FIPropListCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface FIPropListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableArray * propList;
@end

@implementation FIPropListViewController
-(NSMutableArray *)propList{
    if(!_propList){
        _propList = [[NSMutableArray alloc]init];
    }
    return _propList;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title  =@"道具商城";
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:@"FIPropListCell" bundle:nil] forCellReuseIdentifier:@"FIPropListCell"];
    [self getPropList];
}


-(void)getPropList{
    [self asyncSendRequestWithURL:PROPList_URL param:@{@"user_id":[FIUser shareInstance].user_id} RequestMethod:POST showHUD:NO result:^(NSArray * dic, NSError *error) {
        if(!error){
            [self.propList removeAllObjects];
            for (NSDictionary *tmp in dic) {
                [self.propList addObject:[FIPropData yy_modelWithJSON:tmp]];
            }
            
        
            [self.tableView reloadData];
        }
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [self.propList count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    FIPropListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FIPropListCell" forIndexPath:indexPath];
    FIPropData * item = self.propList[indexPath.row];
    cell.nameLabel.text = item.name;
    [cell.bgImageView sd_setImageWithURL:[NSURL URLWithString:item.img]];
    cell.priceLabel.text = [NSString stringWithFormat:@"%@ pcs",item.price];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (SCREEN_WIDTH - 28) * 350 / 730.0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FIPropData * item = self.propList[indexPath.row];
    FIPropDetailViewController * detailVC = [[FIPropDetailViewController alloc]init];
    detailVC.alterType =  item.propId.integerValue;
    [self.navigationController pushViewController:detailVC animated:YES];

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
