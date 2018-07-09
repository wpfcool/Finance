//
//  FIScoreViewController.m
//  Finance
//
//  Created by wenpeifang on 2018/7/9.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIScoreViewController.h"
#import <Masonry/Masonry.h>
#import "FIScoreListViewController.h"
@interface FIScoreViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UILabel * scoreLabel;
@property(nonatomic,strong)NSArray * titleArr;
@end

@implementation FIScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _titleArr = @[@"我的信用评分记录",@"信用评分制度",@"常见问题"];
    self.submitButton.hidden = YES;
    self.headerBgImageView.image = [UIImage imageNamed:@"account_score_bg"];
    
    self.scoreLabel = [[UILabel alloc]init];
    self.scoreLabel.font = [UIFont systemFontOfSize:45];
    self.scoreLabel.text = self.score;
    self.scoreLabel.textColor = [UIColor whiteColor];
    [self.headerView addSubview:self.scoreLabel];
    
    UILabel * tmp = [[UILabel alloc]init];
    tmp.font = [UIFont systemFontOfSize:14];
    tmp.textColor = [UIColor whiteColor];
    tmp.text = @"当前信用评分";
    [self.headerView addSubview:tmp];
    
    
    [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.headerView);
    }];
    [tmp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scoreLabel.mas_bottom).offset(14);
        make.centerX.equalTo(self.headerView);
    }];
    self.tableView.delegate = self;
    self.tableView.dataSource =self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_titleArr count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = _titleArr[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor = HEX_UICOLOR(0x1a1a1a, 1);
    cell.accessoryView =[[ UIImageView alloc]initWithImage:[UIImage imageNamed:@"more"]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        FIScoreListViewController * vc = [[FIScoreListViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(NSString *)getTitle{
    return @"信用评分";
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
