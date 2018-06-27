//
//  FIMemberViewController.m
//  Finance
//
//  Created by 海龙 on 2018/6/27.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIMemberViewController.h"
#import <Masonry/Masonry.h>
@interface FIMemberViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)  UITableView *tableView;
@property (nonatomic,strong)UIView * headerView;
@end

@implementation FIMemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [self wr_setNavBarBackgroundAlpha:1];
//    [self wr_setNavBarTintColor:[UIColor blackColor]];
//    [self wr_setNavBarTitleColor:[UIColor blackColor]];
//    [self wr_setStatusBarStyle:UIStatusBarStyleDefault];
//
    
    self.navigationItem.title = @"会员等级";

    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);

    }];
    
    //750 / 653 = w/h
    
    
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH *653/750.0)];
    UIImageView * _headerBgImageView = [[UIImageView alloc]initWithFrame:_headerView.bounds];
    [_headerView addSubview:_headerBgImageView];
    self.tableView.tableHeaderView = _headerView;
    switch (self.type) {
        case 1:
            _headerBgImageView.image = [UIImage imageNamed:@"member_qingtong"];
            break;
        case 2:
            _headerBgImageView.image = [UIImage imageNamed:@"member_huangjin"];
            break;
        case 3:
            _headerBgImageView.image = [UIImage imageNamed:@"member_baijin"];
            break;
            
        default:
            _headerBgImageView.image = [UIImage imageNamed:@"member_qingtong"];

            break;
    }
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
    
    static NSString * otherlIdentifier = @"otherlIdentifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:otherlIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:otherlIdentifier];
    }
    cell.textLabel.textColor = HEX_UICOLOR(0x1A1A1A, 1);
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 65;
    if(indexPath.section == 0)
        return 182;
    
    return 50;
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
