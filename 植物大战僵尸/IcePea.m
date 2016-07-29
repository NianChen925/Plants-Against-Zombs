//
//  IcePea.m
//  植物大战僵尸
//
//  Created by orange on 16/7/28.
//  Copyright © 2016年 orange. All rights reserved.
//

#import "IcePea.h"

@implementation IcePea

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.plantName = @"plant_3";
        self.bulletName = @"bullet_1";
        self.price = 175;
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
