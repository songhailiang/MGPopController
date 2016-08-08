//
//  ViewController.m
//  MGPopControllerDemo
//
//  Created by 宋海梁 on 16/8/4.
//  Copyright © 2016年 宋海梁. All rights reserved.
//

#import "ViewController.h"

#import "MGPopController.h"
#import <MBProgressHUD.h>

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate> {

}

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, strong) MGPopController *loginController;

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
                    @"自定义样式",
                    @"系统UIAlertController",
                    @"仿系统UIAlertController",
                    @"带TextField",
                    ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"dealloc - %@",NSStringFromClass([self class]));
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
            
            [pop addAction:[MGPopAction actionWithImage:[UIImage imageNamed:@"icon_box"] action:^{
                NSLog(@"继续拆宝箱...");
            }]];
            
            [pop addAction:[MGPopAction actionWithImage:[UIImage imageNamed:@"icon_share"] action:^{
                NSLog(@"分享给好友...");
            }]];
            
            [pop show];
        }
            break;
        case 6://系统UIAlertController
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"恭喜您" message:@"获得一把拆宝箱钥匙" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"继续拆宝箱" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"继续拆宝箱...");
            }]];
            
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"分享给好友" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"分享给好友...");
            }];
            action.enabled = NO;
            [alert addAction:action];
            
            [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                
            }];
            
            [self presentViewController:alert animated:YES completion:nil];
        }
            break;
        case 7: //仿系统UIAlertController
        {
            MGPopController *pop = [[MGPopController alloc] initWithTitle:@"恭喜您" message:@"获得一把拆宝箱钥匙" image:nil];
            
            [pop addAction:[MGPopAction actionWithTitle:@"关闭" action:^{
                NSLog(@"关闭...");
            }]];
            
            [pop addAction:[MGPopAction actionWithTitle:@"继续拆宝箱" action:^{
                NSLog(@"继续拆宝箱...");
            }]];
            
            MGPopAction *action = [MGPopAction actionWithTitle:@"分享给好友" action:^{
                NSLog(@"分享给好友...");
            }];
            action.enable = NO;
            
            [pop addAction:action];
            pop.titleFont = [UIFont boldSystemFontOfSize:17.0f];
            pop.messageFont = [UIFont systemFontOfSize:13.0];
            pop.showActionSeparator = YES;
            pop.actionSpacing = 0;
            pop.actionPaddingLeftRight = 0;
            pop.actionPaddingBottom = 0;
            pop.showCloseButton = NO;
            [pop show];
        }
            break;
        case 8: //带TextField
        {
            MGPopController *pop = [[MGPopController alloc] initWithTitle:@"登录" message:@"请输入账号密码" image:[UIImage imageNamed:@"image_key"]];
            
            [pop addAction:[MGPopAction actionWithTitle:@"关闭" action:^{
                NSLog(@"关闭...");
            }]];
            
            __weak __typeof(&*self)weakSelf = self;
            MGPopAction *action = [MGPopAction actionWithTitle:@"登录" action:^{
                [weakSelf loginWithMobile:[pop.textFields firstObject].text password:[pop.textFields objectAtIndex:1].text];
            }];
            action.autoDismiss = NO;
            [pop addAction:action];
            
            [pop addTextFieldWithConfiguration:^(UITextField *textField) {
                textField.placeholder = @"请输入手机号...";
                textField.keyboardType = UIKeyboardTypeNumberPad;
                textField.delegate = self;
            }];
            
            [pop addTextFieldWithConfiguration:^(UITextField *textField) {
                textField.placeholder = @"请输入密码...";
                textField.secureTextEntry = YES;
            }];
            
            pop.titleFont = [UIFont boldSystemFontOfSize:17.0f];
            pop.messageFont = [UIFont systemFontOfSize:13.0];
            pop.showActionSeparator = YES;
            pop.actionSpacing = 0;
            pop.actionPaddingLeftRight = 0;
            pop.actionPaddingBottom = 0;
            pop.showCloseButton = NO;
            [pop show];
            
            self.loginController = pop;
        }
            break;
        default:
            break;
    }
}

#pragma mark - UITextField delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    NSInteger length = textField.text.length - range.length + string.length;
    if (length > 11) {
        return NO;
    }
    
    return YES;
}

#pragma mark - Login

- (void)loginWithMobile:(NSString *)mobile password:(NSString *)password {
    
    if (mobile.length <= 0 || password.length <= 0) {
        MGPopController *pop = [[MGPopController alloc] initWithTitle:@"提示" message:@"请输入手机号和密码" image:nil];
        [pop show];
        
        return;
    }
    
    NSLog(@"登录中...%@   %@", mobile, password);
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.loginController.view animated:YES];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"登录成功...");
        [hud hideAnimated:YES];
        [self.loginController dismiss];
    });
}

@end
