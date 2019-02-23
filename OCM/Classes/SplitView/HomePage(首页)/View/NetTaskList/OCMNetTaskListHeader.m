//
//  OCMNetTaskListHeader.m
//  OCM
//
//  Created by JianFeng_Ma on 2018/4/13.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "OCMNetTaskListHeader.h"

@interface OCMNetTaskListHeader()

@property (nonatomic,copy)ocmNetTaskListHeaderClickHandle handle;

@property (nonatomic,strong)NSArray *titles;

@property (nonatomic,assign)NSInteger currentIndex;

@property (nonatomic,assign)NSInteger onceIndex;

@end

@implementation OCMNetTaskListHeader

- (void)setCurrentIndex:(NSInteger)currentIndex{
    _currentIndex = currentIndex;
    if (_currentIndex == _onceIndex) {
        return;
    }
    //底标动画
    UIView *bottomView = [self viewWithTag:10086];
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        bottomView.frame = CGRectMake(5+currentIndex*((screenWidth - kLeftBigWidth)/(weakSelf.titles.count)), 35, (screenWidth - kLeftBigWidth)/(weakSelf.titles.count)-10, 4);
        weakSelf.onceIndex = currentIndex;
    } completion:^(BOOL finished) {
    }];
    
}

- (void)buttonClick:(UIButton *)sender{
    for (int i = 0;i<_titles.count;i++) {
        UIButton *button = (UIButton *)[self viewWithTag:i+1000];
        button.selected = NO;
    }
    sender.selected = YES;
    self.currentIndex = sender.tag-1000;
    
    if (self.handle) {
        self.handle(self.currentIndex);
    }
}

- (void)setTitles:(NSArray *)titles{
    _titles = titles;
    CGFloat viewWidth = screenWidth - kLeftBigWidth;
    CGFloat itemWidth = viewWidth/[titles count];
    for (int i = 0; i<titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        //配置button属性
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        button.frame = CGRectMake(0+i*itemWidth, 0, itemWidth, 35);
        [button setTitle:titles[i] forState:0];
        button.tag = i+1000;
        if (i == 0) {
            button.selected = YES;
        }
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(5, 35, itemWidth-10, 4)];
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.tag = 10086;
    [self addSubview:bottomView];
}

- (instancetype)init{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, screenWidth - kLeftBigWidth, 40);
        self.backgroundColor = [UIColor grayColor];
    }
    return self;
}

+ (instancetype)createHeaderWithDataSource:(NSArray *)titles clickButtonWithHandle:(ocmNetTaskListHeaderClickHandle)handle{
    OCMNetTaskListHeader *header = [OCMNetTaskListHeader new];
    header.titles = titles;
    header.handle = [handle copy];
    header.onceIndex = 0;
    header.currentIndex = 0;
    return header;
}

@end
