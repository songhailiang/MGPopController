//
//  ViewController.m
//  MGPopControllerDemo
//
//  Created by 宋海梁 on 16/8/4.
//  Copyright © 2016年 宋海梁. All rights reserved.
//

#import "ViewController.h"

#import "MGPopController.h"

@interface ViewController ()
- (IBAction)popButtonTouched:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)popButtonTouched:(id)sender {
    
    MGPopController *pop = [[MGPopController alloc] initWithTitle:@"恭喜您" message:@"获得一把拆宝箱钥匙" image:[UIImage imageNamed:@"image_key"]];
    
    [pop addAction:[MGPopAction actionWithImage:[UIImage imageNamed:@"icon_box"] action:^{
        NSLog(@"继续拆宝箱...");
    }]];
    
    [pop addAction:[MGPopAction actionWithImage:[UIImage imageNamed:@"icon_share"] action:^{
        NSLog(@"分享给好友...");
    }]];
    
//    [pop addAction:[MGPopAction actionWithImage:[UIImage imageNamed:@"icon_share"] action:^{
//        NSLog(@"分享给好友222...");
//    }]];
    
    [pop show];
}
@end
