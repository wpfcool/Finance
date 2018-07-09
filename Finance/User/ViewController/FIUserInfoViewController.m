//
//  FIUserInfoViewController.m
//  Finance
//
//  Created by wenpeifang on 2018/6/27.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIUserInfoViewController.h"
#import "FIUserInfo.h"
#import "FIAccontSettingViewController.h"
#import "FIMemberViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "FIBagViewController.h"
#import "FIPropListViewController.h"
#import "FIScoreViewController.h"
#import "FIActivityCoceViewController.h"
@interface FIUserInfoViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)FIUserInfo * userInfo;
@property (nonatomic,strong)NSArray *titleArr;
@property (nonatomic,strong)NSArray *imageArr;

@end

static NSString * headerIdentifer = @"headerIdentifer";
@implementation FIUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"个人中心";
    self.tableView.tableFooterView = [UIView new];
    
    _titleArr = @[@"会员级别",@"信用评分",@"梦想背包",@"奖金背包",@"激活码",@"生命力",@"道具商城"];
    _imageArr = @[@"setting_huiyuan",@"setting_pingfen",@"setting_dream",@"setting_jiangjin",@"setting_code",@"setting_life",@"setting_shop"];
    [self loadData];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}
-(void)loadData{
    [self asyncSendRequestWithURL:USER_INFO_URL param:@{@"user_id":[FIUser shareInstance].user_id} RequestMethod:POST showHUD:YES result:^(id dic, NSError *error) {
        if(!error){
            self.userInfo = [FIUserInfo yy_modelWithJSON:dic];
            [self.tableView reloadData];
        }else{
        }
    }];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return 7;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        static NSString * cellIdentifier = @"cell";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-70)/2.0, (160-70)/2.0-10, 70, 70)];
            imageView.tag = 100;
            imageView.clipsToBounds = YES;
            imageView.layer.cornerRadius = 35;
            imageView.layer.borderColor = [UIColor colorWithRed:254/255.0 green:222/255.0 blue:181/255.0 alpha:1].CGColor;
            imageView.layer.borderWidth = 2;
            [cell.contentView addSubview:imageView];
            
            UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame)+10, SCREEN_WIDTH, 20)];
            nameLabel.font = [UIFont systemFontOfSize:15];
            nameLabel.textColor = HEX_UICOLOR(0x1A1A1A, 1);
            nameLabel.tag = 101;
            nameLabel.textAlignment = NSTextAlignmentCenter;
            [cell.contentView addSubview:nameLabel];
            
        }
        
        UIImageView * imageView = [cell.contentView viewWithTag:100];
        UILabel * nameLabel  = [cell.contentView viewWithTag:101];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.userInfo.user_image]];
        nameLabel.text = self.userInfo.nickname?self.userInfo.nickname: self.userInfo.username;
        
        return cell;
    }else{
            static NSString * otherlIdentifier = @"otherlIdentifier";
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:otherlIdentifier];
            if(cell == nil){
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:otherlIdentifier];
            }
            cell.textLabel.textColor = HEX_UICOLOR(0x1A1A1A, 1);
            cell.textLabel.font = [UIFont systemFontOfSize:15];
        
        cell.textLabel.text = _titleArr[indexPath.row];
        cell.imageView.image = [UIImage imageNamed:_imageArr[indexPath.row]];
        cell.detailTextLabel.text = @"11";
        cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"more"]];
        
        switch (indexPath.row) {
            case 0:
                cell.detailTextLabel.text = self.userInfo.memberGrade;
                break;
            case 1:
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%@分",self.userInfo.creditScore] ;
                break;
            case 2:
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f PCS",self.userInfo.dramSeed.doubleValue] ;
                break;
            case 3:
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f PCS",self.userInfo.bonusSeed.doubleValue] ;
                break;
            case 4:
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%@个",self.userInfo.code] ;
                break;
            case 5:
                cell.detailTextLabel.text =  [NSString stringWithFormat:@"%@点",self.userInfo.vitality] ;
                break;
            case 6:
                cell.detailTextLabel.text = @"";
                break;
                
            default:
                cell.detailTextLabel.text = @"";

                break;
        }
            return cell;
    }
    
    return nil;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        return 160;
    }else{
        return 50;
    }
    return 0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        FIAccontSettingViewController * vc = [[FIAccontSettingViewController alloc] init];
        vc.userInfo = self.userInfo;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        switch (indexPath.row) {
            case 0:
                {
                    FIMemberViewController * vc = [[FIMemberViewController alloc]init];
                    vc.member = self.userInfo.memberGrade;;
                    [self.navigationController pushViewController:vc animated:YES];
                }
                break;
            case 1:
            {
                FIScoreViewController * vc = [[FIScoreViewController alloc]init];
                vc.score = self.userInfo.creditScore;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 2:
            {
                FIBagViewController  *vc = [[FIBagViewController alloc]init];
                vc.type = 1;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 3:
            {
                FIBagViewController  *vc = [[FIBagViewController alloc]init];
                vc.type = 2;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 4:
            {
                FIActivityCoceViewController  *vc = [[FIActivityCoceViewController alloc]init];
                vc.countString = self.userInfo.code;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
                
            case 6:
            {
                FIPropListViewController  *vc = [[FIPropListViewController alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
                
            default:
                break;
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
