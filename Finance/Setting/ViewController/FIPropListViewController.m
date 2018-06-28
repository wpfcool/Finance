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
    [self getPropList];
}


-(void)getPropList{
    [self asyncSendRequestWithURL:PROPList_URL param:@{@"user_id":[FIUser shareInstance].user_id} RequestMethod:POST showHUD:NO result:^(NSArray * dic, NSError *error) {
        if(!error){
            [self.propList removeAllObjects];
            for (NSDictionary *tmp in dic) {
                [self.propList addObject:[FIPropData yy_modelWithJSON:tmp]];
            }
            
        
            
        }
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0)
        return 1;
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdentifier = @"otherlIdentifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.textColor = HEX_UICOLOR(0x1A1A1A, 1);
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        return 65;
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
