//
//  UIImageView+Circle.h
//  OCM
//
//  Created by 曹均华 on 2017/12/15.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Circle)
+ (UIImageView *)createWithImageView:(UIImageView *)imageView width:(CGFloat)width height:(CGFloat)height BorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)color;
+ (UIImageView *)createWithImageView:(UIImageView *)imageView x:(CGFloat) x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height BorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)color;
@end
