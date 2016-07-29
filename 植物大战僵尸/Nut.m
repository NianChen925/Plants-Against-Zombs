//
//  Nut.m
//  植物大战僵尸
//
//  Created by orange on 16/7/28.
//  Copyright © 2016年 orange. All rights reserved.
//

#import "Nut.h"

@implementation Nut

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.plantName = @"plant_5";
        self.price = 125;
        [self initAnimation];
    }
    return self;
}

@end
