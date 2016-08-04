//
//  ViewController.m
//  MGPopControllerDemo
//
//  Created by 宋海梁 on 16/8/4.
//  Copyright © 2016年 宋海梁. All rights reserved.
//

#import "ViewController.h"

#import "MGPopController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *titles;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.navigationItem.title = @"自定义弹出框";
    
    self.titles = @[
                    @"无操作按钮",
                    @"一个操作按钮",
                    @"两个操作按钮",
                    @"点击操作按钮不隐藏弹出框",
                    @"无Image模式",
                    @"自定义样式"
                    ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)popButtonTouched:(id)sender {
    
    MGPopController *pop = [[MGPopController alloc] initWithTitle:@"恭喜您" message:@"获得一把拆宝箱钥匙" image:[UIImage imageNamed:@"image_key"]];
    
    pop.backgroundColor = [UIColor colorWithRed:1.0 green:234/255.0 blue:170/255.0 alpha:1.0];
    
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

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [self.titles objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0: //无操作按钮
        {
            MGPopController *pop = [[MGPopController alloc] initWithTitle:@"恭喜您" message:@"获得一把拆宝箱钥匙" image:[UIImage imageNamed:@"image_key"]];
            [pop show];
        }
            break;
        case 1: //一个操作按钮
        {
            MGPopController *pop = [[MGPopController alloc] initWithTitle:@"恭喜您" message:@"获得一把拆宝箱钥匙" image:[UIImage imageNamed:@"image_key"]];
            [pop addAction:[MGPopAction actionWithImage:[UIImage imageNamed:@"image_continue"] action:^{
                NSLog(@"继续拆宝箱...");
            }]];
            [pop show];
        }
            break;
        case 2: //两个操作按钮
        {
            MGPopController *pop = [[MGPopController alloc] initWithTitle:@"恭喜您" message:@"获得一把拆宝箱钥匙" image:[UIImage imageNamed:@"image_key"]];
            [pop addAction:[MGPopAction actionWithImage:[UIImage imageNamed:@"icon_box"] action:^{
                NSLog(@"继续拆宝箱...");
            }]];
            
            [pop addAction:[MGPopAction actionWithImage:[UIImage imageNamed:@"icon_share"] action:^{
                NSLog(@"分享给好友...");
            }]];
            [pop show];
        }
            break;
        case 3: //点击操作按钮不隐藏弹出框
        {
            MGPopController *pop = [[MGPopController alloc] initWithTitle:@"恭喜您" message:@"获得一把拆宝箱钥匙" image:[UIImage imageNamed:@"image_key"]];
            MGPopAction *action = [MGPopAction actionWithImage:[UIImage imageNamed:@"image_continue"] action:^{
                NSLog(@"继续拆宝箱...");
            }];
            action.autoDismiss = NO;
            [pop addAction:action];
            [pop show];
        }
            break;
        case 4: //无Image模式
        {
            MGPopController *pop = [[MGPopController alloc] initWithTitle:@"恭喜您" message:@"获得一把拆宝箱钥匙，继续拆宝箱吧~~" image:nil];
            [pop addAction:[MGPopAction actionWithImage:[UIImage imageNamed:@"image_continue"] action:^{
                NSLog(@"继续拆宝箱...");
            }]];
            [pop show];
        }
            break;
        case 5: //自定义样式
        {
            MGPopController *pop = [[MGPopController alloc] initWithTitle:@"恭喜您" message:@"获得一把拆宝箱钥匙" image:[UIImage imageNamed:@"image_key"]];
            
            pop.backgroundColor = [UIColor colorWithRed:1.0 green:234/255.0 blue:170/255.0 alpha:1.0];
            pop.titleFont = [UIFont systemFontOfSize:24];
            pop.titleColor = [UIColor colorWithRed:105/255.0 green:60/255.0 blue:29/255.0 alpha:1.0];
            pop.messageFont = [UIFont systemFontOfSize:16.0];
            pop.messageColor = [UIColor colorWithRed:105/255.0 green:60/255.0 blue:29/255.0 alpha:1.0];
            pop.closeButtonTintColor = [UIColor colorWithRed:207/255.0 green:178/255.0 blue:97/255.0 alpha:1.0];
            pop.cornerRadius = 20;
            pop.verticalOffset = -CGRectGetHeight(self.view.frame)* 0.2;
            pop.horizontalOffset = 30;
            [pop show];
        }
            break;
        default:
            break;
    }
}

@end
