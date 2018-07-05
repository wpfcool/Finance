//
//  FIPassworldAlterViewController.m
//  Finance
//
//  Created by 海龙 on 2018/7/6.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIPassworldAlterViewController.h"

@interface FIPassworldAlterViewController ()

@end

@implementation FIPassworldAlterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if(self.type == 1){
        self.navigationItem.title = @"修改登录密码";
    }else if(self.type == 2){
        self.navigationItem.title = @"修改安全密码";

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
