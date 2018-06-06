//
//  UIView+Toast.m
//  jcloud
//
//  Created by wenpeifang on 2017/11/10.
//  Copyright © 2017年 Beijing Jingdong Shangke Information Technology Co., Ltd. All rights reserved.
//

#import "UIView+Toast.h"
#import <MBProgressHUD/MBProgressHUD.h>

@implementation UIView (Toast)
//TODO:  实现
-(void)makeToast:(NSString *)toast duration:(NSTimeInterval)duration{
    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].delegate.window animated:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].delegate.window animated:YES];
    hud.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.text =toast;
    hud.detailsLabel.font = [UIFont boldSystemFontOfSize:16];
    hud.margin = 10;

    hud.offset = CGPointMake(0.f, self.frame.size.height/2.0-150);
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor blackColor];
    hud.contentColor = [UIColor whiteColor];
    [hud hideAnimated:YES afterDelay:duration];
}
@end
