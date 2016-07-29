//
//  Plant.m
//  植物大战僵尸
//
//  Created by orange on 16/7/28.
//  Copyright © 2016年 orange. All rights reserved.
//

#import "Plant.h"

@implementation Plant
- (void)initAnimation {
    UIImage *subImage = [UIImage imageNamed:self.plantName];
    NSMutableArray *images = [NSMutableArray array];
    for (int i = 0; i < 8; i++) {
        CGImageRef imageRef = CGImageCreateWithImageInRect(subImage.CGImage, CGRectMake(i * subImage.size.width/8, 0, subImage.size.width/8, subImage.size.height));
        [images addObject:[UIImage imageWithCGImage:imageRef]];
        CGImageRelease(imageRef);
    }
    self.animationImages = images;
    self.animationDuration = 1;
    self.animationRepeatCount = 0;
    [self startAnimating];
}

- (void)fire {
    
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
