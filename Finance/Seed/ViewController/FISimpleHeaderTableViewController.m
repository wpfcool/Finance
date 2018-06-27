//
//  FISeedViewController.m
//  Finance
//
//  Created by wenpeifang on 2018/6/24.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FISimpleHeaderTableViewController.h"
#import <Masonry/Masonry.h>
@interface FISimpleHeaderTableViewController ()

@end

@implementation FISimpleHeaderTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
    
    _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_submitButton addTarget:self action:@selector(submitClick:) forControlEvents:UIControlEventTouchUpInside];
    [_submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [_submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _submitButton.backgroundColor =HEX_UICOLOR(0x3E83FF, 1);
    _submitButton.layer.cornerRadius = 24;
    [self.view addSubview:_submitButton];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
    }];
    
    
    [_submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);

        make.top.equalTo(self.tableView.mas_bottom).offset(20);
        make.bottom.equalTo(self.view.mas_bottom).offset(-20);
        make.height.mas_equalTo(@48);
        

    }];
    [self wr_setNavBarShadowImageHidden:YES];
    [self wr_setNavBarBarTintColor:[UIColor whiteColor]];
    [self wr_setNavBarBackgroundAlpha:0];
    [self wr_setNavBarTintColor:[UIColor whiteColor]];
    self.tableView.contentInset = UIEdgeInsetsMake(-[self navBarBottom], 0, 0, 0);
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 247)];
    _headerBgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 247)];
    _headerBgImageView.image = [UIImage imageNamed:@"home_header_bg"];
    [_headerView addSubview:_headerBgImageView];
    
    self.tableView.tableHeaderView = _headerView;
    
}


- (IBAction)submitClick:(id)sender {
}
-(NSString *)getTitle{
    return @"";
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_COLORCHANGE_POINT)
    {
        CGFloat alpha = (offsetY - NAVBAR_COLORCHANGE_POINT) / NAV_HEIGHT;
        [self wr_setNavBarBackgroundAlpha:alpha];
        [self wr_setNavBarTintColor:[[self scrollNavigationBarColor] colorWithAlphaComponent:alpha]];
        [self wr_setNavBarTitleColor:[[self  scrollNavigationBarColor] colorWithAlphaComponent:alpha]];
//        [self wr_setStatusBarStyle:UIStatusBarStyleDefault];
        [self scrollStatusBarStyle];
        self.title = [self getTitle];
    }
    else
    {
        [self wr_setNavBarBackgroundAlpha:0];
        [self wr_setNavBarTintColor:[self  normalNavigationBarColor]];
        [self wr_setNavBarTitleColor:[self  normalNavigationBarColor]];
//        [self wr_setStatusBarStyle:UIStatusBarStyleLightContent];
        [self normalStatusBarStyle];
        self.title = [self getTitle];
    }
}

-(void)scrollStatusBarStyle{
    
    [self wr_setStatusBarStyle:UIStatusBarStyleDefault];
}
-(void)normalStatusBarStyle{
    [self wr_setStatusBarStyle:UIStatusBarStyleLightContent];
}

-(UIColor *)scrollNavigationBarColor{

    return [UIColor blackColor];
}
-(UIColor *)normalNavigationBarColor{
    return [UIColor whiteColor];
}
-(void)dealloc{
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
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
