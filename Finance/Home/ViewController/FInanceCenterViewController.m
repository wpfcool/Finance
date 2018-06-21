//
//  FInanceCenterViewController.m
//  Finance
//
//  Created by wenpeifang on 2018/6/21.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FInanceCenterViewController.h"
#import "FIHomeHeaderView.h"
#import <Masonry/Masonry.h>
#import "FICenterRecordCell.h"
#import "FIPictureTableViewCell.h"
#import "FISectionHeaderCell.h"
#import "FICenterGainCell.h"
@interface FInanceCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)FIHomeHeaderView * headerView;
@end

static NSString * recordIdentifer = @"recordIdentifer";
static NSString * pictureIdentifer = @"pictureIdentifer";
static NSString * sectionIdentifire = @"FISectionHeaderCell";
static NSString * centerGainIdentifier = @"centerGainIdentifier";
@implementation FInanceCenterViewController
-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor =[UIColor colorWithRed:233/255.0 green:233/255.0  blue:233/255.0  alpha:1];
        _tableView.contentInset = UIEdgeInsetsMake(-[self navBarBottom], 0, 0, 0);
    }
    return _tableView;
}

-(FIHomeHeaderView *)headerView{
    if(!_headerView){
        _headerView = [[NSBundle mainBundle] loadNibNamed:@"FIHomeHeaderView" owner:self options:nil][0];
        _headerView.frame = CGRectMake( 0, 0, SCREEN_WIDTH, 247);
    }
    return _headerView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self wr_setNavBarBarTintColor:[UIColor whiteColor]];
    [self wr_setNavBarBackgroundAlpha:0];
    [self wr_setNavBarTintColor:[UIColor whiteColor]];
    [self wr_setNavBarShadowImageHidden:YES];
    
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    UIView * header = [[UIView alloc] initWithFrame:CGRectMake( 0, 0, SCREEN_WIDTH, 247)];
    [header addSubview:self.headerView];
    self.tableView.tableHeaderView =header;
    
    
    self.headerView.totalMoneyLabel.text = self.homeData.sum;
    self.headerView.dreamMoneyLabel.text = self.homeData.dramSeed;
    self.headerView.bonusMoneyLabel.text = self.homeData.bonusSeed;
    self.headerView.thirdTitleLabel.text = @"激活码";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FICenterRecordCell" bundle:nil] forCellReuseIdentifier:recordIdentifer];
    [self.tableView registerNib:[UINib nibWithNibName:@"FIPictureTableViewCell" bundle:nil] forCellReuseIdentifier:pictureIdentifer];
    [self.tableView registerNib:[UINib nibWithNibName:@"FISectionHeaderCell" bundle:nil] forCellReuseIdentifier:sectionIdentifire];
    [self.tableView registerNib:[UINib nibWithNibName:@"FICenterGainCell" bundle:nil] forCellReuseIdentifier:centerGainIdentifier];


    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0 || section == 1){
        return 1;
    }
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return  117;
    }else if(indexPath.section == 1){
        return 120;
    }else{
        if(indexPath.row == 0){
            return 50;
        }
        return 115;
    }
    
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        FICenterRecordCell * cell = [tableView dequeueReusableCellWithIdentifier:recordIdentifer forIndexPath:indexPath];
        return cell;
    }else if(indexPath.section == 1){
        FIPictureTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:pictureIdentifer forIndexPath:indexPath];
        return cell;
    }else if(indexPath.section == 2){
        if(indexPath.row == 0){
            FISectionHeaderCell * cell = [tableView dequeueReusableCellWithIdentifier:sectionIdentifire forIndexPath:indexPath];
            cell.nameLabel.text = @"收益专区";
            return cell;
        }else{
            FICenterGainCell * cell = [tableView dequeueReusableCellWithIdentifier:centerGainIdentifier forIndexPath:indexPath];
            return cell;
        }

    }

    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_COLORCHANGE_POINT)
    {
        CGFloat alpha = (offsetY - NAVBAR_COLORCHANGE_POINT) / NAV_HEIGHT;
        [self wr_setNavBarBackgroundAlpha:alpha];
        [self wr_setNavBarTintColor:[[UIColor blackColor] colorWithAlphaComponent:alpha]];
        [self wr_setNavBarTitleColor:[[UIColor blackColor] colorWithAlphaComponent:alpha]];
        [self wr_setStatusBarStyle:UIStatusBarStyleDefault];
        self.title = @"财务中心";
    }
    else
    {
        [self wr_setNavBarBackgroundAlpha:0];
        [self wr_setNavBarTintColor:[UIColor whiteColor]];
        [self wr_setNavBarTitleColor:[UIColor whiteColor]];
        [self wr_setStatusBarStyle:UIStatusBarStyleLightContent];
        self.title = @"";
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
