//
//  MGPopController.h
//  MGPopControllerDemo
//
//  Created by 宋海梁 on 16/8/4.
//  Copyright © 2016年 宋海梁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MGPopAction : NSObject

@property (nonatomic, readonly, copy)   NSString            *title;
@property (nonatomic, readonly, strong) UIImage             *image;
@property (nonatomic, readonly, copy)   dispatch_block_t    action;

@property (nonatomic, assign) BOOL enable;

@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *disabledTitleColor;

//自动隐藏：默认YES
@property (nonatomic, assign) BOOL autoDismiss;

+ (instancetype)actionWithImage:(UIImage *)image action:(dispatch_block_t)action;

+ (instancetype)actionWithTitle:(NSString *)title action:(dispatch_block_t)action;

@end

@interface MGPopController : UIViewController

@property (nonatomic, readonly) NSArray<UITextField *> *textFields;

#pragma mark - UI Property

/**
 *  背景色，默认：[UIColor whiteColor]
 */
@property (nonatomic, strong) UIColor *backgroundColor;

/**
 *  主标题Font，默认：[UIFont systemFontOfSize:36.0]
 */
@property (nonatomic, strong) UIFont *titleFont;
/**
 *  主标题Color，默认：[UIColor darkGrayColor]
 */
@property (nonatomic, strong) UIColor *titleColor;

/**
 *  副标题Font，默认：[UIFont systemFontOfSize:18.0]
 */
@property (nonatomic, strong) UIFont *messageFont;
/**
 *  副标题Color，默认：[UIColor lightGrayColor]
 */
@property (nonatomic, strong) UIColor *messageColor;

/**
 *  关闭按钮tintColor，默认：[UIColor lightGrayColor];
 */
@property (nonatomic, strong) UIColor *closeButtonTintColor;
/**
 *  圆角，默认：10
 */
@property (nonatomic, assign) NSInteger cornerRadius;

/**
 *  垂直距离偏移量，默认：0（表示垂直居中）
 */
@property (nonatomic, assign) NSInteger verticalOffset;

/**
 *  水平距离偏移量，默认：50（距离左右边距都是50）
 */
@property (nonatomic, assign) NSInteger horizontalOffset;

/**
 *  操作View距离左右两侧边距，默认：10
 */
@property (nonatomic, assign) NSInteger actionPaddingLeftRight;

/**
 *  操作View距离底部距离，默认：15
 */
@property (nonatomic, assign) NSInteger actionPaddingBottom;

/**
 *  操作按钮之间的间距，默认：10
 */
@property (nonatomic, assign) NSInteger actionSpacing;

/**
 *  操作按钮之间的分割线，默认：NO
 */
@property (nonatomic, assign) BOOL showActionSeparator;

/**
 *  是否显示右上角关闭按钮，默认：YES
 */
@property (nonatomic, assign) BOOL showCloseButton;

#pragma mark - Public Method

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message image:(UIImage *)image;

- (void)addAction:(MGPopAction *)action;

- (void)addTextFieldWithConfiguration:(void (^)(UITextField *textField))configuration;

- (void)show;

- (void)dismiss;

@end
