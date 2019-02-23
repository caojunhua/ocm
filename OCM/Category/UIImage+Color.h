//
//  UIImage+Color.h
//  OCM
//
//  Created by 曹均华 on 2017/11/30.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Color)

/**
 根据颜色生成图片

 @param color 颜色
 @return 返回图片
 */
+ (UIImage*)createImageWithColor:(UIColor*)color;


/**
 返回圆形头像

 @param img 图片
 @param borderWidth 边框宽度
 @param borderColor 边框颜色
 @return 头像
 */
+ (UIImage *)circleImageWithImg:(UIImage *)img borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
@end
