//
//  FIPropDetailViewController.m
//  Finance
//
//  Created by wenpeifang on 2018/6/28.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIPropDetailViewController.h"
#import "FIPropData.h"
#import <Masonry/Masonry.h>
#import "FIPasswordView.h"
@interface FIPropDetailViewController ()<UITableViewDelegate,UITableViewDataSource,FIPasswordViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *footerView;
@property (nonatomic,strong)FIPropData * propItem;;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (nonatomic,strong)FIPasswordView * safePasswordView;;
@property (nonatomic,strong)UIView * alertBgView;;


@end

@implementation FIPropDetailViewController
- (IBAction)submitClick:(id)sender {
    
    [self showPassWordView];
    

}


-(void)showPassWordView{
    self.safePasswordView = [[NSBundle mainBundle] loadNibNamed:@"FIPasswordView" owner:nil options:nil][0];
    self.safePasswordView.frame = CGRectMake((SCREEN_WIDTH-300)/2.0 ,(SCREEN_HEIGHT -215)/2.0-100, 300, 215);
    UIWindow * window = [UIApplication sharedApplication].delegate.window;
    
    _alertBgView = [[UIView alloc]initWithFrame:window.bounds];
    _alertBgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    [window addSubview:_alertBgView];;
    
    [self.alertBgView addSubview:self.safePasswordView];
    self.safePasswordView.delegate = self;
    [self.safePasswordView.hiddenTextField becomeFirstResponder];
}
-(void)hiddenPasswordView{
    [self.alertBgView removeFromSuperview];
    [self.safePasswordView removeFromSuperview];
    self.alertBgView = nil;
    self.safePasswordView = nil;
}
-(void)safePassword:(NSString *)password{
    
    if(password.length <6){
        [self showAlert:@"密码不能小于6位"];
        return;
    }
    [self hiddenPasswordView];
    [self asyncSendRequestWithURL:BUY_PROP_URL param:@{@"prop_id":self.propItem.propId,@"user_id":[FIUser shareInstance].user_id,@"password":password} RequestMethod:POST showHUD:YES result:^(id dic, NSError *error) {
        if(!error){
            [self.view makeToast:@"购买成功" duration:2.0];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"确认购买";
//    self.tableView.estimatedSectionFooterHeight =UITableViewAutomaticDimension;
    

    
    
    self.tableView.sectionFooterHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedSectionFooterHeight = 100;;
    if(self.propItem==nil){
        [self getPropList];
    }
}


-(void)getPropList{
    [self asyncSendRequestWithURL:PROPList_URL param:@{@"user_id":[FIUser shareInstance].user_id} RequestMethod:POST showHUD:NO result:^(NSArray * dic, NSError *error) {
        if(!error){
            for (NSDictionary *tmp in dic) {
                NSString * propID = [NSString stringWithFormat:@"%@",tmp[@"id"]];
                if(self.alterType == [propID integerValue]){
                    self.propItem = [FIPropData yy_modelWithJSON:tmp];
                    break;
                }
            }
            
            if(self.propItem == nil){
                [self.view makeToast:@"暂不支持" duration:2.0];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                           //设置tableview
                self.priceLabel.text = self.propItem.price;
                [self.tableView reloadData];
            }
 
            
        }
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * lIdentifier = @"otherlIdentifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:lIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:lIdentifier];
    }
    cell.textLabel.textColor = HEX_UICOLOR(0x1A1A1A, 1);
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = [NSString stringWithFormat:@"道具: %@",self.propItem.name];
            break;
        case 1:
            cell.textLabel.text = [NSString stringWithFormat:@"售价: %@",self.propItem.price];

            break;
        case 2:
            cell.textLabel.text =@"购买数量:1张";

            break;
            
        default:
            break;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView * view = [[UIView alloc]init];
    UILabel * label = [[UILabel alloc]init];
    NSString * str  = @"*使用说明\n 1.只是适用于本账号\n 2.账号如果有待匹配或未完成的卖出订单时，不能使用；\n 3.使用后，银行账号和支付宝会被清空，需要完善后才可以卖出云矿机。";
    label.attributedText = [SysUtils attributeStringWithRedX:str];
    label.numberOfLines = 0;
    [view addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).offset(15);
        make.right.equalTo(view.mas_right).offset(-15);
        make.top.equalTo(view.mas_top).offset(15);
        make.bottom.equalTo(view.mas_bottom).offset(-15);

    }];
    return view;
    
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
