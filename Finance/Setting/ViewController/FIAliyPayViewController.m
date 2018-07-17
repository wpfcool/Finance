//
//  FIAliyPayViewController.m
//  Finance
//
//  Created by wenpeifang on 2018/7/3.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIAliyPayViewController.h"
#import "FIAddAliPayViewController.h"
#import "FIAccountCardView.h"
#import "FIAliPayData.h"
@interface FIAliyPayViewController ()

@property (weak, nonatomic) IBOutlet FIAccountCardView *cardView;
@property (nonatomic,strong)FIAliPayData *aliPayData;
@end

@implementation FIAliyPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor= [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.title = @"支付宝账号";

    self.emptyLabel.text = @"暂无账号";
    self.emptyImageView.image = [UIImage imageNamed:@"empty_no_account"];
    
    [self.cardView addTarget:self
                      action:@selector(cardClick:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getAliyPay];
}
-(void)addClick:(id)sender{
    FIAddAliPayViewController * viewController = [[FIAddAliPayViewController alloc]init];
    [self.navigationController pushViewController:viewController animated:YES];
}

-(void)getAliyPay{
    [self asyncSendRequestWithURL:GET_ALIYPAY_URL param:@{@"user_id":[FIUser shareInstance].user_id} RequestMethod:POST showHUD:NO result:^(NSDictionary * dic, NSError *error) {
        if(!error){
            if(dic.allKeys.count == 0){
                [self emptyViewShow];
                    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"+" style:UIBarButtonItemStylePlain target:self action:@selector(addClick:)];
            }else{
                [self emptyViewHidden];
                self.aliPayData = [FIAliPayData yy_modelWithJSON:dic];
                self.cardView.nameLabel.text =  self.aliPayData.alipayName;
                self.cardView.numberLabel.text =self.aliPayData.alipayNum;
//                self.cardView.typeLabel.hidden = YES;
                //去掉+
                self.navigationItem.rightBarButtonItem = nil;
            }
        }
    }];
}

-(void)cardClick:(id)sender{
    
    FIAddAliPayViewController * viewController = [[FIAddAliPayViewController alloc]init];
    viewController.payData = self.aliPayData;
    [self.navigationController pushViewController:viewController animated:YES];
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
