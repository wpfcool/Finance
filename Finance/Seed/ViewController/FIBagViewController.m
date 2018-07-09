//
//  FIDreamBagViewController.m
//  Finance
//
//  Created by wenpeifang on 2018/6/26.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIBagViewController.h"
#import <Masonry/Masonry.h>
#import "FIHomeData.h"
#import "FISellSeedViewController.h"
@interface FIBagViewController ()
@property (nonatomic,strong)UILabel * numLabel;
@end

@implementation FIBagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self wr_setNavBarBackgroundAlpha:0];
    [self wr_setNavBarTintColor:[UIColor whiteColor]];
    [self wr_setNavBarTitleColor:[UIColor whiteColor]];
    [self wr_setNavBarShadowImageHidden:YES];

    [self wr_setStatusBarStyle:UIStatusBarStyleLightContent];
   UIView *  _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 247)];
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 247)];
    imageView.image = [UIImage imageNamed:@"home_header_bg"];
    [_headerView addSubview:imageView];
    [self.view addSubview:_headerView];
    
    
    UILabel * tmpLabel = [[UILabel alloc]init];
    tmpLabel.text = @"背包种子数量(PCS)";
    tmpLabel.font = [UIFont systemFontOfSize:11];
    tmpLabel.textColor = [UIColor whiteColor];
    [_headerView addSubview:tmpLabel];
    
    
    _numLabel = [[UILabel alloc]init];
    _numLabel.text = @"--";
    _numLabel.font = [UIFont systemFontOfSize:40];
    _numLabel.textColor = [UIColor whiteColor];
    [_headerView addSubview:_numLabel];
    
    
    
    [_numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headerView.mas_top).offset(30+[self navBarBottom]);;
        make.centerX.equalTo(_headerView.mas_centerX);
    }];
    [tmpLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.numLabel.mas_bottom).offset(10);;
        make.centerX.equalTo(_headerView.mas_centerX);
    }];
//
    if(self.type == 1){
        self.navigationItem.title =@"梦想背包";

    }else{
        self.navigationItem.title =@"奖金背包";

    }
    
    
    UIView * bottomView = [[UIView alloc]init];
    [self.view addSubview:bottomView];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(_headerView.mas_bottom);
    }];
    
    UIButton * sellButton  =[UIButton buttonWithType:UIButtonTypeCustom];
    [sellButton setTitle:@"卖出种子" forState:UIControlStateNormal];
    [sellButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sellButton.backgroundColor =HEX_UICOLOR(0x3E83FF, 1);
    sellButton.layer.cornerRadius = 24;
    [sellButton addTarget:self action:@selector(sellClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:sellButton];
    
    [sellButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.height.mas_equalTo(@48);
        make.centerY.equalTo(bottomView);

    }];
    [self loadData];

}
-(void)loadData{
    
    NSDictionary * dic = @{@"user_id":[FIUser shareInstance].user_id};
    [self asyncSendRequestWithURL:HOME_URL param:dic RequestMethod:POST showHUD:YES result:^(NSDictionary * dic, NSError *error) {
        if(!error){
            FIHomeData * home = [FIHomeData yy_modelWithJSON:dic];
            if(self.type == 1){
                self.numLabel.text = [NSString stringWithFormat:@"%.2f",home.dramSeed.doubleValue] ;
            }else{
                self.numLabel.text = [NSString stringWithFormat:@"%.2f",home.bonusSeed.doubleValue];
            }
        }
    }];
    
}
-(void)sellClick:(id)sender{
    
    FISellSeedViewController * vc = [[FISellSeedViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
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
