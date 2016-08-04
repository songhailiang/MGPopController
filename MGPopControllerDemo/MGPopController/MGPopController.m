//
//  MGPopController.m
//  MGPopControllerDemo
//
//  Created by 宋海梁 on 16/8/4.
//  Copyright © 2016年 宋海梁. All rights reserved.
//

#import "MGPopController.h"
#import <Masonry/Masonry.h>

@implementation MGPopAction

- (instancetype)initWithImage:(UIImage *)image action:(dispatch_block_t)action {

    self = [super init];
    if (self) {
        _image = image;
        _action = action;
    }
    
    return self;
}

+ (instancetype)actionWithImage:(UIImage *)image action:(dispatch_block_t)action {

    return [[MGPopAction alloc] initWithImage:image action:action];
}

@end

@interface MGPopController () {

    NSString *_title;
    NSString *_message;
    UIImage *_image;
}

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIImageView *topImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UIView *actionContainerView;

@property (nonatomic, strong) NSMutableArray *actions;

@end

@implementation MGPopController

#pragma mark - Init

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message image:(UIImage *)image {
    
    self = [super init];
    if (self) {
        _title = title;
        _message = message;
        _image = image;
        
        _actions = [NSMutableArray array];
    }
    
    return self;
}

#pragma mark - Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"dealloc -- %@",NSStringFromClass([self class]));
}

#pragma mark - UI

- (void)setupUI {
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    
    [self.view addSubview:self.containerView];
    [self.containerView addSubview:self.topImageView];
    [self.containerView addSubview:self.titleLabel];
    [self.containerView addSubview:self.messageLabel];
    [self.containerView addSubview:self.closeButton];
    [self.containerView addSubview:self.actionContainerView];
    
    [self.actions enumerateObjectsUsingBlock:^(MGPopAction *action, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = idx;
        [btn addTarget:self action:@selector(actionButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
        if (action.image) {
            [btn setImage:action.image forState:UIControlStateNormal];
        }
        
        [self.actionContainerView addSubview:btn];
    }];
    
    [self makeConstrains];
    
    self.containerView.backgroundColor = [UIColor colorWithRed:1.0 green:234/255.0 blue:170/255.0 alpha:1.0];
    self.titleLabel.text = _title;
    self.messageLabel.text = _message;
    self.topImageView.image = _image;
}

- (void)makeConstrains {
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.offset(50);
        make.trailing.offset(-50);
        make.centerY.equalTo(self.view);
    }];
    
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(17);
        make.centerX.equalTo(self.containerView);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topImageView.mas_bottom).offset(9);
        make.centerX.equalTo(self.containerView);
    }];
    
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.offset(10);
        make.trailing.offset(-10);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(10);
    }];
    
    [self.actionContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.offset(10);
        make.trailing.offset(-10);
        make.top.mas_equalTo(self.messageLabel.mas_bottom).offset(15);
        make.bottom.equalTo(self.containerView).offset(-15);
    }];
    
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.trailing.offset(0);
        make.width.height.equalTo(@44);
    }];
    
    //Actions
    NSInteger count = self.actions.count;
    NSInteger space = 10; //按钮之间的空隙
    __block UIButton *preBtn;
    [self.actionContainerView.subviews enumerateObjectsUsingBlock:^(UIButton * _Nonnull btn, NSUInteger idx, BOOL * _Nonnull stop) {
       [btn mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.bottom.offset(0);
           if (preBtn) {
               make.left.equalTo(preBtn.mas_right).offset(space);
               make.width.equalTo(preBtn.mas_width);
           }
           else {
               make.leading.offset(0);
           }
           if (idx == count-1) { //最后一个
               make.trailing.offset(0);
           }
       }];
        
        preBtn = btn;
    }];
}

#pragma mark - Public Method

- (void)addAction:(MGPopAction *)action {

    [_actions addObject:action];
}

- (void)show {
    
    UIViewController *currentController = [self currentController];
    [currentController addChildViewController:self];
    [currentController.view addSubview:self.view];
    [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsZero);
    }];
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue = @(0.9);
    animation.toValue = @(1);
    animation.duration = 0.15;
    animation.autoreverses = NO;
    animation.repeatCount = 1;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    
    [self.containerView.layer addAnimation:animation forKey:@"animation"];
}

- (void)dismiss {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.1 animations:^{
        [weakSelf.view removeFromSuperview];
        [weakSelf removeFromParentViewController];
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - Private Method

- (void)closeButtonTouched:(UIButton *)sender {
    
    [self dismiss];
}

- (void)actionButtonTouched:(UIButton *)sender {

    if (self.actions.count > sender.tag) {
        MGPopAction *action = [self.actions objectAtIndex:sender.tag];
        if (action.action) {
            action.action();
        }
    }
}

- (UIViewController *)currentController {
    UIViewController *result = nil;
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        
        for (UIWindow *temWin in windows) {
            if (temWin.windowLevel == UIWindowLevelNormal) {
                window = temWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nestResponder = [frontView nextResponder];
    if ([nestResponder isKindOfClass:[UIViewController class]]) {
        result = nestResponder;
    } else {
        result = window.rootViewController;
    }
    return result;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

#pragma mark - Property

- (UIView *)containerView {
    
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        _containerView.layer.cornerRadius = 20.0;
    }
    
    return _containerView;
}

- (UIImageView *)topImageView {
    
    if (!_topImageView) {
        _topImageView = [[UIImageView alloc] init];
        _topImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    
    return _topImageView;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 1;
        _titleLabel.font = [UIFont systemFontOfSize:36.0];
        _titleLabel.textColor = [UIColor colorWithRed:105/255.0 green:60/255.0 blue:29/255.0 alpha:1.0];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _titleLabel;
}

- (UILabel *)messageLabel {
    
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.numberOfLines = 0;
        _messageLabel.font = [UIFont systemFontOfSize:18.0];
        _messageLabel.textColor = [UIColor colorWithRed:105/255.0 green:60/255.0 blue:29/255.0 alpha:1.0];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _messageLabel;
}

- (UIButton *)closeButton {
    
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeButton.tintColor = [UIColor colorWithRed:207/255.0 green:178/255.0 blue:97/255.0 alpha:1.0];
        [_closeButton setImage:[UIImage imageNamed:@"icon_close"] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(closeButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _closeButton;
}

- (UIView *)actionContainerView {
    
    if (!_actionContainerView) {
        _actionContainerView = [[UIView alloc] init];
    }
    
    return _actionContainerView;
}

@end
