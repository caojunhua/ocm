//
//  UIImageView+Circle.m
//  OCM
//
//  Created by 曹均华 on 2017/12/15.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import "UIImageView+Circle.h"

@implementation UIImageView (Circle)
+ (UIImageView *)createWithImageView:(UIImageView *)imageView width:(CGFloat)width height:(CGFloat)height BorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)color {
    UIImageView *imageV = imageView;
    imageV.frame = CGRectMake(0, 0, width, height);
    imageV.layer.masksToBounds = YES;
    imageV.layer.cornerRadius = imageV.frame.size.width * 0.5;
    imageV.layer.borderWidth = borderWidth;
    imageV.layer.borderColor = color.CGColor;
    return imageV;
}
+ (UIImageView *)createWithImageView:(UIImageView *)imageView x:(CGFloat) x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height BorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)color {
    UIImageView *imageV = imageView;
    imageV.frame = CGRectMake(x, y, width, height);
    imageV.layer.masksToBounds = YES;
    imageV.layer.cornerRadius = imageV.frame.size.width * 0.5;
    imageV.layer.borderWidth = borderWidth;
    imageV.layer.borderColor = color.CGColor;
    return imageV;
}
@end
