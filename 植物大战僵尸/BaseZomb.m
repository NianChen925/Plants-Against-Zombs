//
//  BaseZomb.m
//  植物大战僵尸
//
//  Created by orange on 16/7/28.
//  Copyright © 2016年 orange. All rights reserved.
//

#import "BaseZomb.h"

@implementation BaseZomb
- (void)initAnimation {
    UIImage *subImage = [UIImage imageNamed:self.imageName];
    NSMutableArray *images = [NSMutableArray array];
    CGFloat w = subImage.size.width * 0.125;
    for (int i = 0; i < 8; i++) {
        CGImageRef imageRef = CGImageCreateWithImageInRect(subImage.CGImage, CGRectMake(i * w, 0, w, subImage.size.height));
        [images addObject:[UIImage imageWithCGImage:imageRef]];
        CGImageRelease(imageRef);
    }
    self.animationImages = images;
    self.animationDuration = 1;
    self.animationRepeatCount = 0;
    [self startAnimating];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
