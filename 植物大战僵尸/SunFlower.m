//
//  SunFlower.m
//  植物大战僵尸
//
//  Created by orange on 16/7/28.
//  Copyright © 2016年 orange. All rights reserved.
//

#import "SunFlower.h"

@implementation SunFlower

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.plantName = @"plant_0";
        self.price = 50;
        [self initAnimation];
    }
    return self;
}
- (void)fire {
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(addSun) userInfo:nil repeats:YES];
}

- (void)addSun {
    UIButton *sunBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [sunBtn setBackgroundImage:[UIImage imageNamed:@"sun"] forState:UIControlStateNormal];
    sunBtn.frame = CGRectMake(25, 30, 25, 25);
    [self.superview addSubview:sunBtn];
    [sunBtn addTarget:self action:@selector(clickSun:) forControlEvents:UIControlEventTouchUpInside];
    
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(removeSun:) userInfo:sunBtn repeats:NO];
}

- (void)removeSun:(NSTimer *)timer {
    UIButton *sunBtn = timer.userInfo;
    [sunBtn removeFromSuperview];
}
- (void)clickSun:(UIButton *)sunBtn {
    CGPoint oldPoint = CGPointMake(47, 22);
    CGPoint newPoint = [self.delegate.view convertPoint:oldPoint toView:self.superview];
    
    [UIView animateWithDuration:1 animations:^{
        sunBtn.center = newPoint;
    } completion:^(BOOL finished) {
        [self.delegate addSunCount:25];
        [sunBtn removeFromSuperview];
    }];
    
    
    
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
