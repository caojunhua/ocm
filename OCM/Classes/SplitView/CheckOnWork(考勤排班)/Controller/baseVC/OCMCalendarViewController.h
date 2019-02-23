//
//  OCMCalendarViewController.h
//  OCM
//
//  Created by 曹均华 on 2018/4/12.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OCMCalendarCollectionViewCell,OCMCalendarHeaderView;
@interface OCMCalendarViewController : UIViewController
@property (nonatomic, strong) OCMCalendarHeaderView          *headerV;                                //头部view
@property (nonatomic, strong) UICollectionView               *collectionView;                         //collectionView
@property (nonatomic, assign) CGFloat                        offSetY;                                 //默认Y的位置;
@property (nonatomic, strong) NSIndexPath                    *todayIndexPath;                         //今天的下标
@property (nonatomic, assign) CGFloat                        todayFrameY;

@property (nonatomic, strong) OCMCalendarCollectionViewCell  *selectedItem;                           //当前选中项
@property (nonatomic, strong) NSIndexPath                    *selectedIndexPath;                      //选中的下标
/**
 根据当前宽度加载view

 @param currentW 当前宽度
 */
- (void)loadSubView:(CGFloat)currentW;

/**
 设置子类的item样式

 @param item 子类item
 */
- (void)setItemStyle:(OCMCalendarCollectionViewCell *)item indexP:(NSIndexPath *)indexPath;

/**
 添加样式进来

 @param item item
 @param indexPath 下标
 */
- (void)setOtherStyle:(OCMCalendarCollectionViewCell *)item indexP:(NSIndexPath *)indexPath;

/**
 设置子类头部subview隐藏或显示状态
 */
- (void)setHeadSubviewHidden;

/**
 点击了某一天

 @param item item
 */
- (void)clickItem:(OCMCalendarCollectionViewCell *)item;
@end
