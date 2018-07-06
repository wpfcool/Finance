//
//  FIMemberViewController.m
//  Finance
//
//  Created by 海龙 on 2018/6/27.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIMemberViewController.h"
#import <Masonry/Masonry.h>
#import "FIMemberTableViewCell.h"
#import "FIMyTeamViewController.h"
@interface FIMemberViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)  UITableView *tableView;
@property (nonatomic,strong)UIView * headerView;
@property (nonatomic,strong)NSArray * titleArr;
@end

@implementation FIMemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"会员等级";
    _titleArr = @[@"查看我的团队",@"会员级别政策",@"常见问题"];
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);

    }];
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH *653/750.0)];
    UIImageView * _headerBgImageView = [[UIImageView alloc]initWithFrame:_headerView.bounds];
    [_headerView addSubview:_headerBgImageView];
    self.tableView.tableHeaderView = _headerView;
    if([self.member isEqualToString:@"青铜"]){
        _headerBgImageView.image = [UIImage imageNamed:@"member_qingtong"];
    }else if([self.member isEqualToString:@"黄金"]){
        _headerBgImageView.image = [UIImage imageNamed:@"member_huangjin"];

    }else if([self.member isEqualToString:@"白金"]){
        _headerBgImageView.image = [UIImage imageNamed:@"member_baijin"];
    }
    [self.tableView registerNib:[UINib nibWithNibName:@"FIMemberTableViewCell" bundle:nil] forCellReuseIdentifier:@"FIMemberTableViewCell"];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0)
        return 1;
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        
        FIMemberTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FIMemberTableViewCell" forIndexPath:indexPath];
        return cell;
    }else{
        static NSString * otherlIdentifier = @"otherlIdentifier";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:otherlIdentifier];
        if(cell == nil){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:otherlIdentifier];
        }
        cell.textLabel.textColor = HEX_UICOLOR(0x1A1A1A, 1);
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        
        cell.textLabel.text = _titleArr[indexPath.row];
        
        return cell;
    }
    return  nil;

    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 65;
    if(indexPath.section == 0)
        return 182;
    
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 1){
        if(indexPath.row == 0){
            FIMyTeamViewController * team = [[FIMyTeamViewController alloc] init];
            [self.navigationController pushViewController:team animated:YES];
        }
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
