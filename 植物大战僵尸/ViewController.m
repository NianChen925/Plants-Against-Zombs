//
//  ViewController.m
//  植物大战僵尸
//
//  Created by orange on 16/7/28.
//  Copyright © 2016年 orange. All rights reserved.
//

#import "ViewController.h"
#import "Pea.h"
#import "IcePea.h"
#import "SunFlower.h"
#import "Nut.h"
#import "Plant.h"
#import "ZombA.h"
#import "ZombB.h"
#import "ZombC.h"
#import "ZombD.h"
#import "BaseZomb.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *sunLB;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *listIVS;
@property (weak, nonatomic) IBOutlet UIImageView *shovelIV;
@property (nonatomic,strong) Plant *plant;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *caveIV;
@property (nonatomic,copy) NSMutableArray *zombArr;
@property (nonatomic,strong) NSMutableArray *plants;


@end

@implementation ViewController

#pragma mark - 生命周期 life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    self.sunLB.adjustsFontSizeToFitWidth = YES;
    //    self.zombArr = [NSMutableArray array];
    [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(move) userInfo:nil repeats:YES];
    [self performSelector:@selector(startGame) withObject:nil afterDelay:10];
    
    
}
- (void)startGame{
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(addZomb) userInfo:nil repeats:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 初始化
- (void)initUI {
    UIImage *subImage = [UIImage imageNamed:@"seedpackets"];
    for (int i = 0; i < 4; i++) {
        CGFloat x = 0;
        CGFloat w = subImage.size.width / 18;
        switch (i) {
            case 1:
                x = 2 * w;
                break;
            case 2:
                x = 3 * w;
                break;
            case 3:
                x = 5 * w;
                break;
        }
        CGImageRef imageRef = CGImageCreateWithImageInRect(subImage.CGImage, CGRectMake(x, 0, w, subImage.size.height));
        ((UIImageView *)self.listIVS[i]).image = [UIImage imageWithCGImage:imageRef];
        CGImageRelease(imageRef);
    }
}
#pragma mark - 方法
- (void)addSunCount:(int)num {
    self.sunLB.text = @(self.sunLB.text.intValue+num).stringValue;
}

- (void)move {
    for (int i = 0; i < self.zombArr.count; i++) {
        BaseZomb *zomb = self.zombArr[i];
        zomb.center = CGPointMake(zomb.center.x - 2 * zomb.speed, zomb.center.y);
        if (zomb.frame.origin.x <= - zomb.bounds.size.width) {
            [self.zombArr removeObject:zomb];
            [zomb removeFromSuperview];
        }
    }
    
    for (Plant *p in self.plants) {
        if ([p isKindOfClass:[Pea class]]) {
            Pea *pea = (Pea *)p;
            for (UIImageView *iv in pea.bulletArr) {
                iv.center = CGPointMake(iv.center.x + 10, iv.center.y);
                if (iv.center.x >= self.view.bounds.size.width) {
                    [iv removeFromSuperview];
                    [pea.bulletArr removeObject:iv];
                    break;
                }
            }
            
        }
    }
    for (int i = 0; i < self.zombArr.count; i++) {
        BaseZomb *zomb = self.zombArr[i];
        for (Plant *p in self.plants) {
            if ([p isKindOfClass:[Pea class]]) {
                Pea *pea = (Pea *)p;
                for (UIImageView *iv in pea.bulletArr) {
                    if (CGRectIntersectsRect(iv.frame, zomb.frame)) {
                        [iv removeFromSuperview];
                        [pea.bulletArr removeObject:iv];
                        
                        if ([pea isMemberOfClass:[IcePea class]] && zomb.alpha==1) {
                            zomb.speed *= 0.5;
                            zomb.alpha = 0.5;
                        }
                        zomb.health -= 10;
                        if (zomb.health<=0) {
                            [zomb removeFromSuperview];
                            [self.zombArr removeObject:zomb];
                        }
                        return;
                    }
                    
                    
                }
                
            }
        }
    }
    
    
    
}
#pragma mask - 点击操作 拖拽植物
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *t = touches.anyObject;
    CGPoint p = [t locationInView:self.view];
    CGFloat money = self.sunLB.text.floatValue;
    for (UIImageView *iv in self.listIVS) {
        if (CGRectContainsPoint(iv.frame, p)) {
            switch (iv.tag) {
                case 0:
                    if(money < 50)return;
                    self.plant = [[SunFlower alloc] initWithFrame:iv.frame];
                    break;
                case 1:
                    if(money < 200)return;
                    self.plant = [[Pea alloc] initWithFrame:iv.frame];
                    break;
                case 2:
                    if(money < 175)return;
                    self.plant = [[IcePea alloc] initWithFrame:iv.frame];
                    break;
                case 3:
                    if(money < 125)return;
                    self.plant = [[Nut alloc] initWithFrame:iv.frame];
                    break;
            }
            [self.view addSubview:self.plant];
            break;
        }
    }
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *t = touches.anyObject;
    if (self.plant) {
        self.plant.center = [t locationInView:self.view];
    }
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *t = touches.anyObject;
    CGPoint p = [t locationInView:self.view];
    if (self.plant) {
        for (UIImageView* v in self.caveIV ) {
            if (CGRectContainsPoint(v.frame, p)&&v.subviews.count==0) {
                [v addSubview:self.plant];
                self.plant.center = CGPointMake(v.bounds.size.width * 0.5, v.bounds.size.height * 0.5);
                self.plant.delegate = self;
                [self.plant fire];
                [self.plants addObject:self.plant];
                
                [self addSunCount:-self.plant.price];
            }
        }
        if ([[self.plant superview] isEqual:self.view]) {
            [self.plant removeFromSuperview];
        }
        
    }
    self.plant = nil;
}

#pragma mask - 僵尸操作
- (void)addZomb {
    for (int i = 0; i < arc4random_uniform(5); i++) {
        int rodeNum = arc4random_uniform(5);
        BaseZomb *zomb = nil;
        switch (arc4random_uniform(4)) {
            case 0:
                zomb = [[ZombA alloc] initWithFrame:CGRectMake(650, 55+61*rodeNum, 55, 60)];
                break;
            case 1:
                zomb = [[ZombB alloc] initWithFrame:CGRectMake(650, 55+61*rodeNum, 55, 60)];
                break;
            case 2:
                zomb = [[ZombC alloc] initWithFrame:CGRectMake(650, 55+61*rodeNum, 55, 60)];
                break;
            case 3:
                zomb = [[ZombD alloc] initWithFrame:CGRectMake(650, 55+61*rodeNum, 55, 60)];
                break;
        }
        [self.zombArr addObject:zomb];
        [self.view addSubview:zomb];
        
    }
}






#pragma mark - 懒加载 Lazy Load
- (NSMutableArray *)zombArr {
    if(_zombArr == nil) {
        _zombArr = [NSMutableArray array];
    }
    return _zombArr;
}

- (NSMutableArray *)plants {
    if(_plants == nil) {
        _plants = [NSMutableArray array];
    }
    return _plants;
}

@end
