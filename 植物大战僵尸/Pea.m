//
//  Pea.m
//  植物大战僵尸
//
//  Created by orange on 16/7/28.
//  Copyright © 2016年 orange. All rights reserved.
//

#import "Pea.h"

@implementation Pea

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.plantName = @"plant_2";
        self.bulletName = @"bullet_0";
        self.price = 200;
        [self initAnimation];
    }
    return self;
}

- (void)fire {
    self.bulletArr = [NSMutableArray array];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(addBulletAction) userInfo:nil repeats:YES];
}

- (void)addBulletAction {
    UIImageView *bulletImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.superview.center.x+18, self.superview.center.y-18, 15, 15)];
    bulletImage.image = [UIImage imageNamed:self.bulletName];
    [self.delegate.view addSubview:bulletImage];
    [self.bulletArr addObject:bulletImage];
    
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
