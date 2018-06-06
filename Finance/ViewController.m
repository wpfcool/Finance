//
//  ViewController.m
//  Finance
//
//  Created by wenpeifang on 2018/6/4.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "ViewController.h"
#import "HttpRequest.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [HttpRequest postWithUrlString:SEND_IPHONE_CODE parameters:@{@"phone":@"15652376054"} result:^(NSDictionary *dic, NSError *error) {
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
