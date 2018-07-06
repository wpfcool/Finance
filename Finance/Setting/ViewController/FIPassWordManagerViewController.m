//
//  FIPassWordManagerViewController.m
//  Finance
//
//  Created by 海龙 on 2018/7/5.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIPassWordManagerViewController.h"
#import "FIPassworldAlterViewController.h"
@interface FIPassWordManagerViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation FIPassWordManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"密码管理";
    self.tableView.tableFooterView = [UIView new];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"managerIdentifier"];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"managerIdentifier" forIndexPath:indexPath];
    cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"more"]];
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"修改登录密码";
            break;
        case 1:
            cell.textLabel.text = @"修改安全密码";
            break;
        default:
            break;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            FIPassworldAlterViewController * vc = [[FIPassworldAlterViewController alloc] init];
            vc.type = 1;
            vc.phone = self.phone;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            FIPassworldAlterViewController * vc = [[FIPassworldAlterViewController alloc] init];
            vc.type = 2;
            vc.phone = self.phone;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
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
