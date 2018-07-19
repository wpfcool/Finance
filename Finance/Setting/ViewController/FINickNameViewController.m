//
//  FINickNameViewController.m
//  Finance
//
//  Created by wenpeifang on 2018/6/28.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FINickNameViewController.h"

@interface FINickNameViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nickNameTextTield;

@end

@implementation FINickNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.title = @"昵称";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveClick:)];
    self.nickNameTextTield.placeholder = @"请输入昵称";
    self.nickNameTextTield.text = self.userinfo.nickName;
    
    

}
-(void)saveClick:(id)seneer{
    
    if(_nickNameTextTield.text.length == 0){
        [self showAlert:@"请输入昵称"];
        return;
    }
    
    [self asyncSendRequestWithURL:ALTER_NICKNAME_URL param:@{@"user_id":[FIUser shareInstance].user_id,@"nickname":self.nickNameTextTield.text} RequestMethod:POST showHUD:YES result:^(id dic, NSError *error) {
        if(!error){
            [self.view makeToast:@"修改成功" duration:2.0];
            self.userinfo.nickName = self.nickNameTextTield.text;
            [self.navigationController popViewControllerAnimated:YES];
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
