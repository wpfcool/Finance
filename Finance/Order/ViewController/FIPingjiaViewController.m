//
//  FIPingjiaViewController.m
//  Finance
//
//  Created by wenpeifang on 2018/7/10.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIPingjiaViewController.h"

@interface FIPingjiaViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *pingfenView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (nonatomic,assign)NSInteger score;

@end

@implementation FIPingjiaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title  =@"评价";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.submitButton.layer.cornerRadius = 24;
    self.textView.layer.borderWidth = 1;
    self.textView.layer.borderColor = HEX_UICOLOR(0xE7E7E7, 1).CGColor;
    self.textView.layer.cornerRadius = 10;
    self.textView.textColor = HEX_UICOLOR(0x999999, 1);
    self.textView.text = @"请输入文字评论";
    self.score = 5;

}

- (IBAction)submitClick:(id)sender {
    NSString * content = self.textView.text;
    if([self.textView.text isEqualToString:@"请输入文字评论"]){
        content = @"";
    }
    [self asyncSendRequestWithURL:PingjaURL param:@{@"user_id":[FIUser shareInstance].user_id,@"order_id":self.order_id,@"score":@(self.score),@"content":content,@"type":@(self.type)} RequestMethod:POST showHUD:YES result:^(id dic, NSError *error) {
        if(!error){
            [self.view makeToast:@"评价成功" duration:2.0];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}
- (IBAction)pingfenClick:(UIButton *)btn {
    NSInteger tag = btn.tag -1;
    self.score = tag + 1;
    for (int i = 0; i<5; i++) {
        if(i<=tag){
            //选中
            UIButton * btn = [self.pingfenView viewWithTag:i+1];
            [btn setImage:[UIImage imageNamed:@"order_pingjia_select"] forState:UIControlStateNormal];
        }else{
            UIButton * btn = [self.pingfenView viewWithTag:i+1];
            [btn setImage:[UIImage imageNamed:@"order_pingjia_unselect"] forState:UIControlStateNormal];
        }
    }
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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
