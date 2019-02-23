//
//  OCMSearchBar.m
//  OCM
//
//  Created by 曹均华 on 2017/12/22.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import "OCMSearchBar.h"

@interface OCMSearchBar ()
@property (nonatomic,assign)BOOL isChangeFrame;
@end

@implementation OCMSearchBar

- (void)layoutSubviews {
    [super layoutSubviews];
    for (UIView *subView in self.subviews[0].subviews) {
        if ([subView isKindOfClass:[UIImageView class]]) {
            [subView removeFromSuperview];
        }
        if ([subView isKindOfClass:[UITextField class]]) {
            CGFloat height = self.bounds.size.height;
            CGFloat width = self.bounds.size.width;
            if (_isChangeFrame) {
                subView.frame = CGRectMake(_contentInset.left, _contentInset.top, width - 2 * _contentInset.left, height - 2 * _contentInset.top);
                subView.layer.cornerRadius = 5;
                subView.layer.masksToBounds = YES;
            } else {
                CGFloat top = (height - 28.0) * 0.5;
                CGFloat bottom = top;
                CGFloat left = 8.0;
                CGFloat right = left;
                _contentInset = UIEdgeInsetsMake(top, left, bottom, right);
            }
            //换蓝色的搜索框
            UITextField *textF = (UITextField *)subView;
            UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 14, 14.5)];
            imageV.image = [UIImage imageNamed:@"icon_home_search"];
            textF.leftView = imageV;
        }
    }
}
- (void)setContentInset:(UIEdgeInsets)contentInset {
    _contentInset.top = contentInset.top;
    _contentInset.left = contentInset.left;
    _contentInset.bottom = contentInset.bottom;
    _contentInset.right = contentInset.right;
    
    self.isChangeFrame = YES;
    [self layoutSubviews];
}
- (void)setIsChangeFrame:(BOOL)isChangeFrame {
    if (_isChangeFrame != isChangeFrame) {
        _isChangeFrame = isChangeFrame;
    }
}
@end
