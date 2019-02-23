//
//  WBPopOverView.m
//  pop_test
//
//  Created by tuhui－03 on 16/5/19.
//  Copyright © 2016年 tuhui－03. All rights reserved.
//

#import "WBPopOverView.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


@interface WBPopOverView ()


@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) WBArrowDirection direction;

@end

@implementation WBPopOverView

-(instancetype)initWithOrigin:(CGPoint)origin Width:(CGFloat)width Height:(float)height Direction:(WBArrowDirection)direction onView:(UIView *)view{
    if (self = [super initWithFrame:view.bounds])
    {
        //背景颜色为无色
        self.backgroundColor=[UIColor clearColor];
        self.canHidden = NO;
        //定义显示视图的参数
        CGPoint point = CGPointMake(origin.x, origin.y - 5);
        self.origin = point;
        self.height = height;
        self.width = width;
        self.direction = direction;
        
        self.backView=[[UIView alloc]initWithFrame:CGRectMake(origin.x, origin.y, width, height)];
        self.backView.backgroundColor=[UIColor colorWithWhite:0.2 alpha:1];
        [self addSubview:self.backView];
      
    
    }

    return self;
}


-(void)drawRect:(CGRect)rect
{
    CGContextRef context=UIGraphicsGetCurrentContext();
    
    if (_direction==WBArrowDirectionLeft1) {
        
        
        CGFloat startX = self.origin.x;
        CGFloat startY = self.origin.y;
        CGContextMoveToPoint(context, startX, startY);//设置起点
        CGContextAddLineToPoint(context, startX+5, startY-5);
        CGContextAddLineToPoint(context, startX+5, startY+5);
    }
    else if (_direction==WBArrowDirectionLeft2)
    {
    
        
        CGFloat startX = self.origin.x;
        CGFloat startY = self.origin.y;
        CGContextMoveToPoint(context, startX, startY);//设置起点
        CGContextAddLineToPoint(context, startX+5, startY-5);
        CGContextAddLineToPoint(context, startX+5, startY+5);
    
    }
    else if (_direction==WBArrowDirectionLeft3)
    {

        
        CGFloat startX = self.origin.x;
        CGFloat startY = self.origin.y;
        CGContextMoveToPoint(context, startX, startY);//设置起点
        CGContextAddLineToPoint(context, startX+5, startY-5);
        CGContextAddLineToPoint(context, startX+5, startY+5);
        
    }
    else if (_direction==WBArrowDirectionRight1)
    {
        CGFloat startX = self.origin.x;
        CGFloat startY = self.origin.y;
        CGContextMoveToPoint(context, startX, startY);//设置起点
        CGContextAddLineToPoint(context, startX-5, startY-5);
        CGContextAddLineToPoint(context, startX-5, startY+5);
        
    }
    else if (_direction==WBArrowDirectionRight2)
    {
        CGFloat startX = self.origin.x;
        CGFloat startY = self.origin.y;
        CGContextMoveToPoint(context, startX, startY);//设置起点
        CGContextAddLineToPoint(context, startX-5, startY-5);
        CGContextAddLineToPoint(context, startX-5, startY+5);
        
    }
    else if (_direction==WBArrowDirectionRight3)
    {
        CGFloat startX = self.origin.x;
        CGFloat startY = self.origin.y;
        CGContextMoveToPoint(context, startX, startY);//设置起点
        CGContextAddLineToPoint(context, startX-5, startY-5);
        CGContextAddLineToPoint(context, startX-5, startY+5);
        
    }
    else if (_direction==WBArrowDirectionUp1)
    {
        CGFloat startX = self.origin.x;
        CGFloat startY = self.origin.y;
        CGContextMoveToPoint(context, startX, startY);//设置起点
        CGContextAddLineToPoint(context, startX + 5, startY +5);
        CGContextAddLineToPoint(context, startX -5, startY+5);
        
    }
    else if (_direction==WBArrowDirectionUp2)
    {
        CGFloat startX = self.origin.x;
        CGFloat startY = self.origin.y;
        CGContextMoveToPoint(context, startX, startY);//设置起点
        CGContextAddLineToPoint(context, startX + 5, startY +5);
        CGContextAddLineToPoint(context, startX -5, startY+5);
    }
    else if (_direction==WBArrowDirectionUp3)
    {
        CGFloat startX = self.origin.x;
        CGFloat startY = self.origin.y + 1;
        CGContextMoveToPoint(context, startX, startY);//设置起点
        CGContextAddLineToPoint(context, startX + 5, startY +5);
        CGContextAddLineToPoint(context, startX -5, startY+5);
        
    }
#warning 添加的
    else if (_direction==WBArrowDirectionUp4)
    {
        CGFloat startX = self.origin.x;
        CGFloat startY = self.origin.y + 1;
        CGContextMoveToPoint(context, startX, startY);//设置起点
        CGContextAddLineToPoint(context, startX + 5, startY +5);
        CGContextAddLineToPoint(context, startX -5, startY+5);
        
    }
    else if (_direction==WBArrowDirectionDown1)
    {
        CGFloat startX = self.origin.x;
        CGFloat startY = self.origin.y;
        CGContextMoveToPoint(context, startX, startY);//设置起点
        CGContextAddLineToPoint(context, startX - 5, startY -5);
        CGContextAddLineToPoint(context, startX +5, startY-5);
        
    }
    else if (_direction==WBArrowDirectionDown2)
    {
        CGFloat startX = self.origin.x;
        CGFloat startY = self.origin.y - 1;
        CGContextMoveToPoint(context, startX, startY);//设置起点
        CGContextAddLineToPoint(context, startX - 5, startY -5);
        CGContextAddLineToPoint(context, startX +5, startY-5);
        
    }
    else if (_direction==WBArrowDirectionDown3)
    {
        CGFloat startX = self.origin.x;
        CGFloat startY = self.origin.y;
        CGContextMoveToPoint(context, startX, startY);//设置起点
        CGContextAddLineToPoint(context, startX - 5, startY -5);
        CGContextAddLineToPoint(context, startX +5, startY-5);
        
    }
   
    CGContextClosePath(context);
    [self.backView.backgroundColor setFill];
    [self.backgroundColor setStroke];
    CGContextDrawPath(context, kCGPathFillStroke);
    
 

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.canHidden == NO) {
        return;
    }
    UITouch *touch = [touches anyObject];
    if (![touch.view isEqual:self.backView]) {
        [self dismiss];
    }
}

-(void)popViewToView:(UIView *)view
{
    NSArray *result=[self.backView subviews];
    for (UIView *view in result) {
        
        view.hidden=YES;
        
    }
    
//    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
//    [keyWindow addSubview:self];
    [view addSubview:self];
    //动画效果弹出
    self.alpha = 0;
    
    
    if (_direction==WBArrowDirectionLeft1) {
        self.backView.frame = CGRectMake(self.origin.x+5, self.origin.y, 0, 0);
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 1;
            self.backView.frame = CGRectMake(self.origin.x+5, self.origin.y-20, self.width,self. height);
        }completion:^(BOOL finished) {
            NSArray *result=[self.backView subviews];
            for (UIView *view in result) {
                
                view.hidden=NO;
                
            }
        }];
        
        
    }
    else if (_direction==WBArrowDirectionLeft2)
    {
        self.backView.frame = CGRectMake(self.origin.x+5, self.origin.y, 0, 0);
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 1;
            self.backView.frame = CGRectMake(self.origin.x+5, self.origin.y-self.height/2, self.width,self. height);

        }completion:^(BOOL finished) {
            NSArray *result=[self.backView subviews];
            for (UIView *view in result) {
                
                view.hidden=NO;
                
            }
        }];
    }
    else if (_direction==WBArrowDirectionLeft3)
    {
        self.backView.frame = CGRectMake(self.origin.x+5, self.origin.y, 0, 0);
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 1;
            self.backView.frame = CGRectMake(self.origin.x+5, self.origin.y-self.height+20, self.width,self. height);
        }completion:^(BOOL finished) {
            NSArray *result=[self.backView subviews];
            for (UIView *view in result) {
                
                view.hidden=NO;
                
            }
        }];
        
    }
    else if (_direction==WBArrowDirectionRight1)
    {
        self.backView.frame = CGRectMake(self.origin.x-5, self.origin.y, 0, 0);
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 1;
            self.backView.frame = CGRectMake(self.origin.x-5, self.origin.y-20, -self.width,self. height);
        }completion:^(BOOL finished) {
            
            NSArray *result=[self.backView subviews];
            for (UIView *view in result) {
                
                view.hidden=NO;
                
            }
            
        }];
        
    }
    else if (_direction==WBArrowDirectionRight2)
    {
        self.backView.frame = CGRectMake(self.origin.x-5, self.origin.y, 0, 0);
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 1;
            self.backView.frame = CGRectMake(self.origin.x-5, self.origin.y-self.height/2, -self.width,self. height);
        }completion:^(BOOL finished) {
            
            NSArray *result=[self.backView subviews];
            for (UIView *view in result) {
                
                view.hidden=NO;
                
            }
            
        }];
        
    }
    else if (_direction==WBArrowDirectionRight3)
    {
        self.backView.frame = CGRectMake(self.origin.x-5, self.origin.y, 0, 0);
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 1;
            self.backView.frame = CGRectMake(self.origin.x-5, self.origin.y-self.height+20, -self.width,self. height);
        }completion:^(BOOL finished) {
            
            NSArray *result=[self.backView subviews];
            for (UIView *view in result) {
                
                view.hidden=NO;
                
            }
            
        }];
        
    }
    else if (_direction==WBArrowDirectionUp1)
    {
        self.backView.frame = CGRectMake(self.origin.x, self.origin.y+5, 0, 0);
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 1;
            self.backView.frame = CGRectMake(self.origin.x-20, self.origin.y+5, self.width,self. height);
        }completion:^(BOOL finished) {
            
            NSArray *result=[self.backView subviews];
            for (UIView *view in result) {
                
                view.hidden=NO;
                
            }
            
        }];
        
    }
    else if (_direction==WBArrowDirectionUp2)
    {
        self.backView.frame = CGRectMake(self.origin.x, self.origin.y+5, 0, 0);
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 1;
            self.backView.frame = CGRectMake(self.origin.x-self.width/2, self.origin.y+5, self.width,self. height);
        }completion:^(BOOL finished) {
            
            NSArray *result=[self.backView subviews];
            for (UIView *view in result) {
                
                view.hidden=NO;
                
            }
            
        }];
        
    }
    else if (_direction==WBArrowDirectionUp3)
    {
        self.backView.frame = CGRectMake(self.origin.x, self.origin.y+5, 0, 0);
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 1;
            self.backView.frame = CGRectMake(self.origin.x+20, self.origin.y+5, -self.width,self. height);
        }completion:^(BOOL finished) {
            
            NSArray *result=[self.backView subviews];
            for (UIView *view in result) {
                
                view.hidden=NO;
                
            }
            
        }];
        
    }
#warning 我添加的
    else if (_direction==WBArrowDirectionUp4)
    {
        self.backView.frame = CGRectMake(self.origin.x, self.origin.y+5, 0, 0);
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 1;
            self.backView.frame = CGRectMake(self.origin.x+12, self.origin.y+5, -self.width,self. height);
        }completion:^(BOOL finished) {
            
            NSArray *result=[self.backView subviews];
            for (UIView *view in result) {
                
                view.hidden=NO;
                
            }
            
        }];
        
    }
    else if (_direction==WBArrowDirectionDown1)
    {
        self.backView.frame = CGRectMake(self.origin.x, self.origin.y-5, 0, 0);
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 1;
            self.backView.frame = CGRectMake(self.origin.x-20, self.origin.y-5, self.width,-self. height);
        }completion:^(BOOL finished) {
            
            NSArray *result=[self.backView subviews];
            for (UIView *view in result) {
                
                view.hidden=NO;
                
            }
            
        }];
        
    }
    else if (_direction==WBArrowDirectionDown2)
    {
        self.backView.frame = CGRectMake(self.origin.x, self.origin.y-5, 0, 0);
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 1;
            self.backView.frame = CGRectMake(self.origin.x-self.width/2, self.origin.y-5, self.width,-self. height);
        }completion:^(BOOL finished) {
            
            NSArray *result=[self.backView subviews];
            for (UIView *view in result) {
                
                view.hidden=NO;
                
            }
            
        }];
        
    }
    else if (_direction==WBArrowDirectionDown3)
    {
        self.backView.frame = CGRectMake(self.origin.x, self.origin.y-5, 0, 0);
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 1;
            self.backView.frame = CGRectMake(self.origin.x-self.width+20, self.origin.y-5, self.width,-self. height);
        }completion:^(BOOL finished) {
            
            NSArray *result=[self.backView subviews];
            for (UIView *view in result) {
                
                view.hidden=NO;
                
            }
            
        }];
        
    }

}

-(void)dismiss{
    
    NSArray *result=[self.backView subviews];
    for (UIView *view in result) {
        
        [view removeFromSuperview];

    }
    
         //动画效果淡出
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
        self.backView.frame = CGRectMake(self.origin.x, self.origin.y, 0, 0);
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
                 
        }
    }];
}
- (void)addTableView:(UITableView *)tableView {
//    UITableView *tableViews= tableView;
    [self addSubview:tableView];
    tableView.frame = self.bounds;
}

@end

