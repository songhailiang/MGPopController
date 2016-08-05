# MGPopController
A custom popup view。自定义弹出框。

提供了一种自定义弹出框的实现方式，UI不是重点，有了思路，你能面对任何UI！

# 实现的功能

## 1、操作按钮部分（ActionButton）
- 支持任意数量的操作按钮，0个或者多个（按钮一行显示，不会换行，因为正常情况下不会超过3个按钮，一行显示足够了）
- 支持自定义操作按钮的字体、颜色、是否可点击、不可点击状态按钮颜色
- 支持操作按钮点击后是否关闭弹出框（系统的UIAlertController点击后会自动关闭）
- 支持使用文字或者图片显示按钮

## 2、弹出框部分（PopController）
- 支持设置图片、标题、副标题和操作按钮
- 支持显示右上角关闭按钮（也可不显示）
- 支持设置标题、副标题字体大小、字体颜色
- 支持设置背景色、圆角、左右边距和垂直位置（默认垂直居中，可设置垂直偏移量）
- 支持设置操作按钮（ActionButton）之间的一些距离
- 其他一些属性设置

# 效果图
## 默认的一些效果
<img src='https://github.com/songhailiang/MGPopController/blob/master/screenshots/screenshot1.gif' width='300' />
## 自定义样式
<img src='https://github.com/songhailiang/MGPopController/blob/master/screenshots/screenshot2.gif' width='300' />
## 仿系统UIAlertController
（操作按钮上是有分割线的，效果图因为分辨率的问题，没显示出来）

<img src='https://github.com/songhailiang/MGPopController/blob/master/screenshots/screenshot3.gif' width='300' />

# 安装方法
将MGPopController文件夹里的MGPopController.h和MGPopController.m拖到你的项目中，再把Assets里的icon_close图片（右上角关闭按钮用到）加入到你的项目中就可以了。

**特别注意：我的UI布局用到了Masonry（还是开头那句话，UI不是重点...），所以如果你的项目中没有用到，可能还得添加一下 :(**

# 使用方法
类似系统UIAlertController的用法：

1.实例化MGPopController
```objc
MGPopController *pop = [[MGPopController alloc] initWithTitle:@"恭喜您" message:@"获得一把拆宝箱钥匙" image:[UIImage imageNamed:@"image_key"]];
```

2.添加操作按钮
```objc
[pop addAction:[MGPopAction actionWithImage:[UIImage imageNamed:@"image_continue"] action:^{
                NSLog(@"继续拆宝箱...");
}]];
```
温馨提示：action里是block，如果你需要调用self（当前ViewController）的属性或者方法，需要先weak一下（系统的UIAlertController里也是如此）
```objc
__weak __typeof(&*self)weakSelf = self
```

3.Pop出来就行了
```objc
[pop show];
```

更多用法，请参见Demo！

# 未来计划
- 增加对输入框的支持


# 最后
Enjoy Yourself！！
