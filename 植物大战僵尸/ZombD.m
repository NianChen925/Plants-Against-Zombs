//
//  ZombD.m
//  植物大战僵尸
//
//  Created by orange on 16/7/28.
//  Copyright © 2016年 orange. All rights reserved.
//

#import "ZombD.h"

@implementation ZombD
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.imageName = @"zomb_3";
        self.speed = 2;
        self.health = 200;
        [self initAnimation];
    }
    return self;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
