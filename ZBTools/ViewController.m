//
//  ViewController.m
//  ZBTools
//
//  Created by 张宝 on 2019/2/14.
//  Copyright © 2019 zb. All rights reserved.
//

#import "ViewController.h"
#import "ZBTools.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = [UIColor redColor];
    v.frame = CGRectMake(30, 100, 100, 40);
    
    UIBezierPath *path = [UIBezierPath zbRoundedRect:v.bounds
                                             topLeft:20
                                            topRight:20
                                          bottomLeft:20
                                         bottomRight:20];
    
    CAShapeLayer *shape = [CAShapeLayer layer];
    shape.path = path.CGPath;
    v.layer.mask = shape;
    
    [self.view addSubview:v];
    
    NSArray *arr = @[@{@"a":@"2435"},@{@"a":@"645"},@{@"a":@"23"}];
    
    NSString *str = [arr zb_JsonFormatString];
    NSLog(@"----:%@", str);
    
    NSArray *list = [ZBUtility arrayFromJson:@"   "];
    NSLog(@"----list:%@", list);
}


@end
