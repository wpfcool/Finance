//
//  FIOrderDetail1ViewController.m
//  Finance
//
//  Created by wenpeifang on 2018/7/10.
//  Copyright © 2018年 wenpeifang. All rights reserved.
//

#import "FIOrderDetail1ViewController.h"
#import "FIOrderDetailTimeViewCell.h"
#import "FIOrderDetailOrderCell.h"
#import "HttpRequest.h"
#import <Masonry/Masonry.h>
#import "GKPhotoBrowser.h"
@interface FIOrderDetail1ViewController ()<UITableViewDataSource,UITableViewDelegate,FIOrderDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableVIew;
@property (weak, nonatomic) IBOutlet UIButton *complainButton;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomHeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (nonatomic,strong)UIView * bgView ;//凭证弹窗
@end


@implementation FIOrderDetail1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"订单详情";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    if((self.orderType & OrderTypeSell) &&( self.orderType & OrderTypeWaitingConfirm) ){
        self.bottomHeightConstraint.constant = 50;
        self.bottomView.hidden = NO;
    }else{
        self.bottomHeightConstraint.constant = 0;
        self.bottomView.hidden = YES;
    }
    self.tableVIew.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableVIew.backgroundColor = HEX_UICOLOR(0xf3f3f3, 1);
    self.tableVIew.tableFooterView = [UIView new];
//    [self.tableVIew registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellidentifer"];
    [self.tableVIew registerNib:[UINib nibWithNibName:@"FIOrderDetailTimeViewCell" bundle:nil] forCellReuseIdentifier:@"cellidentifer"];
    
    [self.tableVIew registerNib:[UINib nibWithNibName:@"FIOrderDetailOrderCell" bundle:nil] forCellReuseIdentifier:@"FIOrderDetailOrderCellidentifer"];

}
-(void)cuiConfirm:(NSString *)orderId{
    
}
- (IBAction)complainClick:(id)sender {
    NSString * comType = @"1";
    if(self.orderType & OrderTypeBuy){
        comType = @"2";
    }else if(self.orderType & OrderTypeSell){
        comType = @"1";
        
    }
    UIAlertController * controller = [UIAlertController alertControllerWithTitle:@"确认未收到款，要投诉" message:@"银行转账正常到账时间为24小时之内，因各银行处理系统略有不同，可能会出现延迟，您可与匹配方先沟通处理。如12小时后确实未收到款，系统会要求购买会员在12小时之后提交付款凭证视频，如恶投" preferredStyle:UIAlertControllerStyleAlert];
    [controller addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self asyncSendRequestWithURL:COMPLAIN_URL param:@{@"user_id":[FIUser shareInstance].user_id,@"order_id":self.orderData.order_id,@"type":comType} RequestMethod:POST showHUD:YES result:^(id dic, NSError *error) {
            if(!error){
                [self.view makeToast:@"投诉成功" duration:2.0];
                self.orderData.is_lodge  =@"2";
            }
        }];
    }]];
    
    [controller addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:controller animated:YES completion:nil];
}
- (IBAction)confirmClick:(id)sender {
    UIAlertController * controller = [UIAlertController alertControllerWithTitle:nil message:@"确认已经收到这笔款" preferredStyle:UIAlertControllerStyleAlert];
    [controller addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self asyncSendRequestWithURL:CONFIRMPAY_URL param:@{@"user_id":[FIUser shareInstance].user_id,@"order_id":self.orderData.order_id} RequestMethod:POST showHUD:YES result:^(id dic, NSError *error) {
            if(!error){
                
            }
        }];
    }]];
    
    [controller addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:controller animated:YES completion:nil];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        FIOrderDetailTimeViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cellidentifer" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if(self.orderType & OrderTypeWaitingMatch){
            cell.timeLabel.text = @"未匹配";

        }else{
            NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
            NSInteger time = currentTime - self.orderData.app_time.integerValue;
            cell.timeLabel.text = [SysUtils getTime:time];
        }

        return cell;
        
    }else if(indexPath.section == 1){
        
        FIOrderDetailOrderCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FIOrderDetailOrderCellidentifer" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        cell.orderData = self.orderData;
        cell.orderType = self.orderType;
        return cell;
    }
    
    return nil;

}

-(void)uploadPingzheng:(NSString *)orderId{
    UIImagePickerController * pick = [[UIImagePickerController alloc]init];
    pick.delegate = self;
    pick.allowsEditing = YES;
    UIAlertController * controller = [UIAlertController alertControllerWithTitle:@"选择照片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [controller addAction:[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        pick.sourceType  = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:pick animated:YES completion:nil];
        
    }]];
    
    [controller addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        pick.sourceType  = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:pick animated:YES completion:nil];
    }]];
    [controller addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:controller animated:YES completion:nil];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage]; //原始图片
    NSData * data =UIImageJPEGRepresentation(image, 0.1);
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    //上传凭证
    [self showHUD];
    [HttpRequest upLoadWithURL:UPLOADPINGZHENGURL upData:data name:@"file" fileName:@"image.jpg" mimeType:@"mage/jpg" params:@{@"user_id":[FIUser shareInstance].user_id,@"order_id":self.orderData.order_id} result:^(id dic, NSError *error) {
        [self hiddenHUD];
        if(!error){
            [self.view makeToast:@"上传成功" duration:2.0];
        }
        
    }];
    
    
}

-(void)getPingzheng:(NSString *)image{
    if(self.orderData.image.length == 0){
        [self showAlert:@"无转账凭证"];
        return;
    }
    
    NSMutableArray *photos = [NSMutableArray new];
    GKPhoto *photo = [GKPhoto new];
    photo.url = [NSURL URLWithString:self.orderData.image];
    [photos addObject:photo];
    GKPhotoBrowser *browser = [GKPhotoBrowser photoBrowserWithPhotos:photos currentIndex:0];
    browser.showStyle = GKPhotoBrowserShowStyleNone;
    [browser showFromVC:self];

}
-(void)tapClick:(id)sender{
    [self.bgView removeFromSuperview];
    self.bgView = nil;
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
