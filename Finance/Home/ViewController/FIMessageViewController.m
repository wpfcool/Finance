//
//  FIMessageViewController.m
//  Finance
//
//  Created by wenpeifang on 2018/7/19.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIMessageViewController.h"

@interface FIMessageViewController ()

@end

@implementation FIMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title  = @"消息";
    
    self.emptyImageView.image = [UIImage imageNamed:@"empty_no_messge"];
    self.emptyLabel.text = @"暂无消息";
    
    [self emptyViewShow];
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
