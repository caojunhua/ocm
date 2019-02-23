//
//  OCMNetTaskDetailEditView.m
//  OCM
//
//  Created by JianFeng_Ma on 2018/4/17.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "OCMNetTaskDetailEditView.h"
#import "OCMNetTaskDetailModel.h"
@interface OCMNetTaskDetailEditView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong)UITextView *editView;

@property (nonatomic,strong)UILabel *placeHolderLab;

@property (nonatomic,strong)UICollectionView *imageCollectionView;

@property (nonatomic,strong)UILabel *locationLab;

@property (nonatomic,strong)OCMNetTaskDetailModel *model;

@property (nonatomic,copy)editViewCompleteHandler handler;

@end


@implementation OCMNetTaskDetailEditView

- (void)getLocation:(NSString *)location{
    self.locationLab.text = location;
}

- (void)setModel:(OCMNetTaskDetailModel *)model{
    _model = model;
    /** 底部预留定位栏 50*/
    if ([model.needFeedback boolValue] && [model.needPhoto boolValue]) {
    /** 两种 305高度*/
        [self setUpAll];
    }else if([model.needFeedback boolValue]){
    /** 只需要反馈 200高度*/
        [self setUpF];
    }else if([model.needPhoto boolValue]){
    /** 只需要拍照 120高度*/
        [self setUpP];
    }else{
        /** 只需要定位 100高度*/
        [self setUpL];
    }
    
}

- (void)setUpAll{
    __weak typeof(self) weakSelf = self;
    
    UIView *line_1 = [UIView new];
    [self addSubview:line_1];
    line_1.backgroundColor = UIColorFromRGB(0xdddddd);
    [line_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.offset(0);
        make.right.offset(0);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.editView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(15);
        make.left.offset(25);
        make.height.mas_equalTo(150);
        make.right.offset(-80);
    }];
    
    [self.imageCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.editView.mas_bottom).offset(35);
        make.left.offset(25);
        make.height.mas_equalTo(90);
    }];
    
    UIView *line_2 = [UIView new];
    [self addSubview:line_2];
    line_2.backgroundColor = UIColorFromRGB(0xdddddd);
    [line_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.imageCollectionView.mas_bottom).offset(15);
        make.left.offset(0);
        make.right.offset(0);
        make.height.mas_equalTo(0.5);
    }];
    
    UIImageView *locationImageView = [UIImageView new];
    
    [locationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(25);
        make.top.equalTo(weakSelf.imageCollectionView.mas_bottom).offset(29.5);
        make.size.mas_equalTo(CGSizeMake(15, 21));
    }];
    
    [self.locationLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(locationImageView.mas_right).offset(10);
        make.height.mas_equalTo(48);
        make.centerY.mas_equalTo(locationImageView);
    }];
}

- (void)setUpF{
    __weak typeof(self) weakSelf = self;
    [self.editView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(15);
        make.left.offset(25);
        make.height.mas_equalTo(150);
        make.right.offset(-80);
    }];
    UIView *line_2 = [UIView new];
    [self addSubview:line_2];
    line_2.backgroundColor = UIColorFromRGB(0xdddddd);
    [line_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.editView.mas_bottom).offset(50);
        make.left.offset(0);
        make.right.offset(0);
        make.height.mas_equalTo(0.5);
    }];
    
    UIImageView *locationImageView = [UIImageView new];
    
    [locationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(25);
        make.top.equalTo(weakSelf.editView.mas_bottom).offset(49.5);
        make.size.mas_equalTo(CGSizeMake(15, 21));
    }];
    
    [self.locationLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(locationImageView.mas_right).offset(10);
        make.height.mas_equalTo(48);
        make.centerY.mas_equalTo(locationImageView);
    }];
}

- (void)setUpP{
    
    __weak typeof(self) weakSelf = self;
    [self.imageCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(15);
        make.left.offset(25);
        make.height.mas_equalTo(90);
    }];
    
    UIView *line_2 = [UIView new];
    [self addSubview:line_2];
    line_2.backgroundColor = UIColorFromRGB(0xdddddd);
    [line_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.imageCollectionView.mas_bottom).offset(15);
        make.left.offset(0);
        make.right.offset(0);
        make.height.mas_equalTo(0.5);
    }];
    
    UIImageView *locationImageView = [UIImageView new];
    
    [locationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(25);
        make.top.equalTo(weakSelf.imageCollectionView.mas_bottom).offset(29.5);
        make.size.mas_equalTo(CGSizeMake(15, 21));
    }];
    
    [self.locationLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(locationImageView.mas_right).offset(10);
        make.height.mas_equalTo(48);
        make.centerY.mas_equalTo(locationImageView);
    }];
   
}

- (void)setUpL{
    __weak typeof(self) weakSelf = self;
    UIView *line_2 = [UIView new];
    [self addSubview:line_2];
    line_2.backgroundColor = UIColorFromRGB(0xdddddd);
    [line_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.offset(0);
        make.right.offset(0);
        make.height.mas_equalTo(0.5);
    }];
    
    UIImageView *locationImageView = [UIImageView new];
    
    [locationImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(25);
        make.top.offset(14.5);
        make.size.mas_equalTo(CGSizeMake(15, 21));
    }];
    
    [self.locationLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(locationImageView.mas_right).offset(10);
        make.height.mas_equalTo(48);
        make.centerY.mas_equalTo(locationImageView);
    }];
}


#pragma mark -- mark
#pragma mark

- (UITextView *)editView{
    if (!_editView) {
        _editView = [UITextView new];
        _editView.font = [UIFont systemFontOfSize:17];
        [self addSubview:_editView];
    }
    return _editView;
}

- (UILabel *)placeHolderLab{
    if (!_placeHolderLab) {
        _placeHolderLab = [UILabel new];
        [self addSubview:_placeHolderLab];
    }
    return _placeHolderLab;
}

- (UICollectionView *)imageCollectionView{
    if (!_imageCollectionView) {
        _imageCollectionView = [UICollectionView new];
        _imageCollectionView.delegate = self;
        _imageCollectionView.dataSource = self;
        [self addSubview:_imageCollectionView];
    }
    return _imageCollectionView;
}

- (UILabel *)locationLab{
    if (!_locationLab) {
        _locationLab = [UILabel new];
        [self addSubview:_locationLab];
    }
    return _locationLab;
}

@end
