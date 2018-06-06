//
//  FILoginViewController.m
//  Finance
//
//  Created by wenpeifang on 2018/6/6.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FILoginViewController.h"
#import "FIRegisterViewController.h"
#import "SysUtils.h"
#import "FIUser.h"
#import "AppDelegate.h"
@interface FILoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passworldTextField;

@end

@implementation FILoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.edgesForExtendedLayout = UIRectEdgeNone;
}
- (IBAction)loginClick:(id)sender {
    
    
    NSDictionary * dic = @{@"username":_userNameTextField.text,@"password":_passworldTextField.text,@"system_num":[SysUtils uuid],@"version_num":[SysUtils shortVersion],@"source":@"2"};
    [self asyncSendRequestWithURL:Login_URL param:dic RequestMethod:POST showHUD:YES result:^(id dic, NSError *error) {
        if(dic){
            FIUser *user =[FIUser shareInstance];
            user.userName = dic[@"userName"];
            user.user_id = dic[@"user_id"];
            user.token = dic[@"token"];
            
            AppDelegate *delegate =   (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [delegate homeRootViewController];
            
        }
    }];
}

- (IBAction)registerClick:(id)sender {
    FIRegisterViewController * registerVC = [[FIRegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
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
