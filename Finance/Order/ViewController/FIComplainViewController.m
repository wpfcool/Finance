//
//  FIComplainViewController.m
//  Finance
//
//  Created by wenpeifang on 2018/7/10.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIComplainViewController.h"

@interface FIComplainViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation FIComplainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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
