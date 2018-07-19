//
//  FIBaseViewController.m
//  Finance
//
//  Created by wenpeifang on 2018/6/6.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIBaseViewController.h"
#import "HttpRequest.h"
#import <Masonry/Masonry.h>
#import <MBProgressHUD/MBProgressHUD.h>
@interface FIBaseViewController ()
@property (nonatomic,strong)MBProgressHUD * hud;
@property (nonatomic,strong)UIView * emptyView;
@end

@implementation FIBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =  BGCOLOR;
    [self.view addSubview:self.emptyView];
    
    [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.emptyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.emptyView);
        make.centerY.equalTo(self.emptyView);

    }];
    [self.emptyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.emptyImageView.mas_bottom).offset(10);
        make.centerX.equalTo(self.emptyImageView);
    }];
    
    if ([self.navigationController.viewControllers count] > 1 &&
        !self.navigationItem.leftBarButtonItem && !self.navigationController.navigationBarHidden) {
        UIImage *leftButtonIcon = [[UIImage imageNamed:@"white_back"]
                                   imageWithRenderingMode:UIImageRenderingModeAutomatic];
                UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:leftButtonIcon style:UIBarButtonItemStyleDone target:self action:@selector(clickBackButton:)];
        self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    }
}
-(UILabel *)emptyLabel{
    if(!_emptyLabel){
        _emptyLabel = [[UILabel alloc]init];
        _emptyLabel.textAlignment = NSTextAlignmentCenter;
        _emptyLabel.font = [UIFont systemFontOfSize:15];
        _emptyLabel.textColor = HEX_UICOLOR(0x999999, 1);
    }
    return _emptyLabel;
}
-(UIImageView *)emptyImageView{
    if(!_emptyImageView){
        _emptyImageView = [[UIImageView alloc]init];
    }
    return _emptyImageView;
}
-(UIView *)emptyView{
    if(!_emptyView){
        _emptyView = [[UIView alloc]init];
        _emptyView.hidden = YES;
        _emptyView.backgroundColor = [UIColor whiteColor];
        [_emptyView addSubview:self.emptyImageView];
        [_emptyView addSubview:self.emptyLabel];
    }
    return _emptyView;
}
-(void)clickBackButton:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)asyncSendRequestWithURL:(NSString *)url param:(NSDictionary*)param RequestMethod:(RequestMethod)method showHUD:(BOOL)showHUD result:(void(^)(id dic,NSError*error))resultBlock{
    
    
    if(showHUD){
        [self showHUD];
    }
    if(method == GET){
        
        [HttpRequest getWithUrlString:url parameters:param result:^(id dic, NSError *error) {
            if(showHUD){
                [self hiddenHUD];
            }
            if(error){
                resultBlock(nil,error);
                [self.view makeToast:[HttpRequest errorDesc:error] duration:2.0];

            }else{
                resultBlock(dic,nil);
            }
        }];

        
    }else if(method == POST){
        
        [HttpRequest postWithUrlString:url parameters:param result:^(id dic, NSError *error) {
            if(showHUD){
                [self hiddenHUD];
            }
            if(error){
                resultBlock(nil,error);
                [self.view makeToast:[HttpRequest errorDesc:error] duration:2.0];

                
            }else{
                resultBlock(dic,nil);
            }
        }];
 
    }
    
}

-(void)showHUD{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud showAnimated:YES];
    self.hud = hud;
}
-(void)hiddenHUD{
    [self.hud hideAnimated:YES];
}

-(void)showAlert:(NSString *)message{
    UIAlertController * controller = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    [controller addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:controller animated:YES completion:nil];
}

- (int)navBarBottom
{
    if ([WRNavigationBar isIphoneX]) {
        return 88;
    } else {
        return 64;
    }
}


-(void)emptyViewShow{
    self.emptyView.hidden = NO;
    [self.view bringSubviewToFront:self.emptyView];
    
}
-(void)emptyViewHidden{
    self.emptyView.hidden = YES;

}
-(void)emptyViewPositionCenterY:(CGFloat)y{
    [self.emptyImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.emptyView).offset(-y);
    }];
}

//- (void)viewWillLayoutSubviews
//{
//    [super viewWillLayoutSubviews];
//    
//    CGFloat top = self.hasNaviBackgroundView ? 64 : 0;
//    self.emptyView.frame = CGRectMake(0, top, self.view.frame.size.width, self.view.frame.size.height - top);
//
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
