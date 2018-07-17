//
//  FIBankListViewController.m
//  Finance
//
//  Created by 海龙 on 2018/7/2.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIBankListViewController.h"
#import "FIBankListViewCell.h"
#import "FIBankData.h"
#import "FIAccountCardView.h"
#import "FIBankInfoViewController.h"
@interface FIBankListViewController ()
@property (nonatomic,strong)FIBankData *bankData;

@property (weak, nonatomic) IBOutlet FIAccountCardView *cardView;
@end

@implementation FIBankListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.title = @"银行账户";
    self.emptyLabel.text = @"暂无账号";
    self.emptyImageView.image = [UIImage imageNamed:@"empty_no_account"];
    [self.cardView addTarget:self
                      action:@selector(cardClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self bankListRequest];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self bankListRequest];
}
-(void)addClick:(id)sender{
    FIBankInfoViewController * vc = [[FIBankInfoViewController alloc]init];
    vc.realName = self.realName;
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)cardClick:(id)sender{
    FIBankInfoViewController * vc = [[FIBankInfoViewController alloc]init];
    vc.realName = self.realName;
    vc.bankData = self.bankData;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)bankListRequest{
    [self asyncSendRequestWithURL:BANKLIST_URL param:@{@"user_id":[FIUser shareInstance].user_id} RequestMethod:POST showHUD:YES result:^(NSDictionary * dic, NSError *error) {
        if(!error){
            if(dic.allKeys.count == 0)
            {
                 self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"+" style:UIBarButtonItemStylePlain target:self action:@selector(addClick:)];
                [self emptyViewShow];
                return;
            }
            self.bankData = [FIBankData yy_modelWithJSON:dic];
            self.cardView.nameLabel.text = self.bankData.bankName;
            if(self.bankData.bankCard.length > 4){
                NSString * bankNo = [NSString stringWithFormat:@"****    ****    ****    %@",[self.bankData.bankCard substringWithRange:NSMakeRange(self.bankData.bankCard.length-4, 4)]];
                self.cardView.numberLabel.text = bankNo;
            }else{
                  self.cardView.numberLabel.text = self.bankData.bankCard;
            }
            
            self.navigationItem.rightBarButtonItem =nil;
            [self emptyViewHidden];
        }
    }];
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
