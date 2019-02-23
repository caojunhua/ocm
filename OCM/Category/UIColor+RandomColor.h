//
//  UIColor+RandomColor.h
//  OCM
//
//  Created by 曹均华 on 2017/11/29.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (RandomColor)

+ (UIColor *)RGBColorWithRed:(CGFloat)red withGreen:(CGFloat)green withBlue:(CGFloat)blue withAlpha:(CGFloat)alpha;

+ (UIColor *)randomColor;

+ (UIColor *) colorWithHexString: (NSString *)color;
@end
