//
//  FIAliyPayViewController.m
//  Finance
//
//  Created by wenpeifang on 2018/7/3.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIAliyPayViewController.h"
#import "FIAddAliPayViewController.h"
@interface FIAliyPayViewController ()

@end

@implementation FIAliyPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"支付宝账号";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"+" style:UIBarButtonItemStylePlain target:self action:@selector(addClick:)];
    self.emptyLabel.text = @"暂无账号";
    
    [self getAliyPay];
}

-(void)addClick:(id)sender{
    FIAddAliPayViewController * viewController = [[FIAddAliPayViewController alloc]init];
    [self.navigationController pushViewController:viewController animated:YES];
}
-(void)getAliyPay{
    [self asyncSendRequestWithURL:GET_ALIYPAY_URL param:@{@"user_id":[FIUser shareInstance].user_id} RequestMethod:POST showHUD:YES result:^(NSDictionary * dic, NSError *error) {
        if(!error){
            if(dic.allKeys.count == 0){
                [self emptyViewShow];
            }else{
                [self emptyViewHidden];
                
                
            }
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
