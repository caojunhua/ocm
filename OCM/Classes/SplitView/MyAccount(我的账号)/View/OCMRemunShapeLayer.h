//
//  OCMRemunShapeLayer.h
//  OCM
//
//  Created by 曹均华 on 2017/12/29.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface OCMRemunShapeLayer : CAShapeLayer
//{
//    CAShapeLayer *_animLayer;
//}
@property (nonatomic,strong)CAShapeLayer *animLayer;
@property (nonatomic,strong)CAShapeLayer *animLayer0;
@property (nonatomic,strong)CAShapeLayer *animLayer1;
@property (nonatomic,strong)CAShapeLayer *animLayer2;
@property (nonatomic,strong)CAShapeLayer *animLayer3;
@property (nonatomic,strong)CAShapeLayer *animLayer4;
@property (nonatomic,strong)CAShapeLayer *animLayer5;
@property (nonatomic,strong)CAShapeLayer *animLayer6;
@property (nonatomic,strong)NSMutableArray *pointArr;
@property (nonatomic,assign)CGFloat detalX;
@property (nonatomic,strong)NSMutableArray *showedLineArr;

@property (nonatomic,assign)NSInteger lastCount;
@property (nonatomic,assign)NSInteger newCount;
@end
