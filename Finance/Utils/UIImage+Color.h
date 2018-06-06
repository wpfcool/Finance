//
//  UIImage+Color.h
//  jcloud
//
//  Created by zhuyuhao on 15/6/18.
//  Copyright (c) 2015年 Beijing Jingdong Shangke Information Technology Co., Ltd. All rights reserved.
//
#import <UIKit/UIKit.h>
@interface UIImage (UIColor)

+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color
                       size:(CGSize)size
               cornerRadius:(CGFloat)cornerRadius;

@end
