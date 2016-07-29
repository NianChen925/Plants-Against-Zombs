//
//  Plant.h
//  植物大战僵尸
//
//  Created by orange on 16/7/28.
//  Copyright © 2016年 orange. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface Plant : UIImageView
@property (nonatomic,strong) NSString *plantName;
@property (nonatomic) CGFloat health;
@property (nonatomic,weak) ViewController *delegate;
@property (nonatomic,assign) CGFloat price;
- (void)initAnimation;
- (void)fire;
@end
