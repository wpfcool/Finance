//
//  FIOrderMemberInfoViewController.m
//  Finance
//
//  Created by wenpeifang on 2018/8/20.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIOrderMemberInfoViewController.h"
#import "FIOrderMemberCell.h"
#import "BCMember.h"
@interface FIOrderMemberInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)BCMember * memeber;
@end

@implementation FIOrderMemberInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"联系会员";
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:@"FIOrderMemberCell" bundle:nil] forCellReuseIdentifier:@"memberindentirer"];
    

    if(self.userid.length == 0){
        return;
    }
    [self asyncSendRequestWithURL:ORDER_MEMBER_INFO_URL param:@{@"user_id":self.userid} RequestMethod:POST showHUD:YES result:^(id dic, NSError *error) {
        if(!error){
            self.memeber = [BCMember yy_modelWithJSON:dic];
            [self.tableView reloadData];
        }
    }];

    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FIOrderMemberCell * cell = [tableView dequeueReusableCellWithIdentifier:@"memberindentirer" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.rightButton setTitle:@"复制" forState:UIControlStateNormal];
    switch (indexPath.row) {
        case 0:
        {
            cell.titleLabel.text = @"用  户  名:";
            cell.contentLabel.text = self.memeber.username;
            cell.rightButton.hidden = YES;
        }
            break;
        case 1:
        {
            cell.titleLabel.text = @"真实姓名:";
            cell.contentLabel.text = self.memeber.trueName;
            cell.rightButton.hidden = YES;

        }
            break;
        case 2:
        {
            cell.titleLabel.text = @"开户银行:";
            cell.contentLabel.text = self.memeber.bankName;
            cell.rightButton.hidden = YES;
            
        }
            break;
        case 3:
        {
            cell.titleLabel.text = @"银行卡号";
            cell.contentLabel.text = self.memeber.bankCard;
            cell.rightButton.hidden = NO;


        }
            break;
        case 4:
        {
            cell.titleLabel.text = @"支付宝账号";
            cell.contentLabel.text = self.memeber.alipayNum;
            cell.rightButton.hidden = NO;

        }
            break;
        case 5:
        {
            cell.titleLabel.text = @"手机号";
            cell.contentLabel.text = self.memeber.phone;
            cell.rightButton.hidden = NO;
            [cell.rightButton setTitle:@"拨打" forState:UIControlStateNormal];



        }
            break;
        default:
            break;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
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
