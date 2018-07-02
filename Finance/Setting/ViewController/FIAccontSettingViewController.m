//
//  FIAccontSettingViewController.m
//  Finance
//
//  Created by wenpeifang on 2018/6/27.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIAccontSettingViewController.h"
#import "FIAlterInfoWithMoneyViewController.h"
#import "FIMemberViewController.h"
#import "FINickNameViewController.h"
#import "FIBankListViewController.h"
@interface FIAccontSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSArray * titleArr;
@property (nonatomic,strong)NSArray * imageArr;
@end

@implementation FIAccontSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"账户设置";
    self.tableView.tableFooterView = [UIView new];
    _titleArr = @[@"头像",@"用户名",@"真实姓名",@"手机号码",@"会员级别",@"昵称",@"我的银行账户",@"支付宝账户",@"密码管理"];
    _imageArr=@[@"setting_avator",@"setting_username",@"seting_realname",@"setting_phone",@"setting_member_grade",@"setting_nickname",@"setting_bank",@"setting_alipay",@"setting_password"];
}
-(NSString *)memeber:(NSInteger)me{
    switch (me) {
        case 1:
            return @"青铜";
            break;
        case 2:
            return @"黄金";
            break;
        case 3:
            return @"白金";
            break;
            
        default:
            break;
    }
    return @"青铜";
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _titleArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * otherlIdentifier = @"otherlIdentifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:otherlIdentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:otherlIdentifier];
        
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-30-34, 8, 34, 34)];
        imageView.tag = 100;
        imageView.layer.cornerRadius = 17;
        imageView.clipsToBounds = YES;
        [cell.contentView addSubview:imageView];
    }
    
    UIImageView * photoImageView = [cell.contentView viewWithTag:100];
    photoImageView.hidden = YES;
    cell.textLabel.textColor = HEX_UICOLOR(0x1A1A1A, 1);
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.text = _titleArr[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:_imageArr[indexPath.row]];
    cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"more"]];
    cell.detailTextLabel.hidden = NO;
    switch (indexPath.row) {
        case 0:
            photoImageView.hidden = NO;
            cell.detailTextLabel.hidden = YES;
            cell.accessoryView = nil;

            break;
        case 1:
            cell.detailTextLabel.text = self.userInfo.username;
            cell.accessoryView = nil;
            break;
            
        case 2:
            cell.detailTextLabel.text = self.userInfo.trueName;
            break;
        case 3:
            cell.detailTextLabel.text = self.userInfo.phone;
            break;
        case 4:
            cell.detailTextLabel.text =[self memeber:self.userInfo.memberGrade.integerValue] ;
            break;
        case 5:
            cell.detailTextLabel.text = self.userInfo.nickname;
            break;
            
        default:
            break;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            
            break;
            
        case 1:
            
            break;
        case 2:{
            FIAlterInfoWithMoneyViewController * realVC = [[FIAlterInfoWithMoneyViewController alloc] init];
            realVC.userInfo = self.userInfo;
            realVC.alterType = PropTypeRealName; //真实姓名
            [self.navigationController pushViewController:realVC animated:YES];
        }
            break;
        case 3:
        {
            FIAlterInfoWithMoneyViewController * realVC = [[FIAlterInfoWithMoneyViewController alloc] init];
            realVC.userInfo = self.userInfo;
            realVC.alterType = PropTypePhone;//手机号
            [self.navigationController pushViewController:realVC animated:YES];
        }
            break;
        case 4:
        {
            FIMemberViewController * vc = [[FIMemberViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];

        }
            break;
        case 5:
        {
            FINickNameViewController * vc = [[FINickNameViewController alloc] init];
            vc.userinfo = self.userInfo;
            [self.navigationController pushViewController:vc animated:YES];
        }
            
            break;
        case 6:
        {
            FIBankListViewController * vc = [[FIBankListViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];

        }
            break;
        case 7:
            
            break;
        case 8:
            
            break;
        case 9:
            
            break;
        default:
            break;
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
