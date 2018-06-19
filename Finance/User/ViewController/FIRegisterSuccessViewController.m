//
//  FIRegisterSuccessViewController.m
//  Finance
//
//  Created by wenpeifang on 2018/6/19.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIRegisterSuccessViewController.h"

@interface FIRegisterSuccessViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;

@end

@implementation FIRegisterSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _topConstraint.constant = kIphone6Scale(166);
    _bottomConstraint.constant = kIphone6Scale(65);
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
