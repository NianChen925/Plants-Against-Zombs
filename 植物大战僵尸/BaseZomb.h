//
//  BaseZomb.h
//  植物大战僵尸
//
//  Created by orange on 16/7/28.
//  Copyright © 2016年 orange. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface BaseZomb : UIImageView
@property (nonatomic,strong) NSString *imageName;
@property (nonatomic) CGFloat health;
@property (nonatomic) CGFloat speed;
@property (nonatomic,weak) ViewController *delegate;
- (void)initAnimation;
@end
