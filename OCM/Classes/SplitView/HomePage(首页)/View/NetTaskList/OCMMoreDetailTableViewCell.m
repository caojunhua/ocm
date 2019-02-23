//
//  OCMMoreDetailTableViewCell.m
//  OCM
//
//  Created by 曹均华 on 2018/3/7.
//  Copyright © 2018年 caojunhua. All rights reserved.
//

#import "OCMMoreDetailTableViewCell.h"
#import "OCMNetTaskListModel.h"
@interface OCMMoreDetailTableViewCell()
/** 时间lab*/
@property (weak, nonatomic) IBOutlet UILabel *taskDayLab;
/** 截止时间*/
@property (weak, nonatomic) IBOutlet UILabel *remainDayLab;
/** 是否签到*/
@property (weak, nonatomic) IBOutlet UIButton *isSignButton;
/** 任务类型*/
@property (weak, nonatomic) IBOutlet UILabel *taskTypeLab;
/** 任务主题*/
@property (weak, nonatomic) IBOutlet UILabel *taskThemeLab;
/** 是否需要拍照*/
@property (weak, nonatomic) IBOutlet UIButton *needPhotoButton;
/** 是否需要反馈*/
@property (weak, nonatomic) IBOutlet UIButton *needFeedBackButton;

@property (nonatomic,strong)OCMNetTaskListModel *model;

@property (nonatomic,copy)signInHandle handle;

@end

@implementation OCMMoreDetailTableViewCell

- (void)clickSignButtonWithHandle:(signInHandle)handle{
    self.handle = [handle copy];
}

-(void)setModel:(OCMNetTaskListModel *)model{
    _model = model;
    self.taskDayLab.text = [NSString stringWithFormat:@"%@至%@",model.beginDay,model.endDay];
    self.taskTypeLab.text = model.taskType;
    self.taskThemeLab.text = model.taskName;
    self.needPhotoButton.hidden = ![model.needPhoto boolValue];
    self.needFeedBackButton.hidden = ![model.needFeedback boolValue];
    if ([model.needSign boolValue]) {
        [self.isSignButton setTitle:[model.isSign boolValue]?@"已签到":@"签到" forState:UIControlStateNormal];
        
        [self.isSignButton setBackgroundColor:[model.isSign boolValue]?[UIColor grayColor]:[UIColor blueColor]];
        self.isSignButton.enabled = ![model.isSign boolValue];
    }else{
        self.isSignButton.hidden = YES;
    }
}
- (IBAction)signIn:(UIButton *)sender {
    self.handle();
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
//- (instancetype)initWithFrame:(CGRect)frame {
//    if (self = [super initWithFrame:frame]) {
//        self = [[[NSBundle mainBundle] loadNibNamed:@"OCMMoreDetailTableViewCell" owner:self options:nil] objectAtIndex:0];
//        self.frame = frame;
//    }
//    return self;
//}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

