//
//  MGPopController.h
//  MGPopControllerDemo
//
//  Created by 宋海梁 on 16/8/4.
//  Copyright © 2016年 宋海梁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MGPopAction : NSObject

@property (nonatomic, readonly, copy) NSString          *title;
@property (nonatomic, readonly, strong) UIImage         *image;
@property (nonatomic, readonly, copy) dispatch_block_t  action;

+ (instancetype)actionWithImage:(UIImage *)image action:(dispatch_block_t)action;

@end

@interface MGPopController : UIViewController

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message image:(UIImage *)image;

- (void)addAction:(MGPopAction *)action;

- (void)show;

@end
