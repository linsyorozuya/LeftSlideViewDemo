# LeftSlideViewDemo

在需要作为侧边栏的视图中添加以下代码即可：

    [self initSlideFoundation];

在视图中实现开放一个类给需要展现侧边栏的试图调用，例如：

    - (void)showFromLeft{
       [self show];
    }

    - (IBAction)hideToLeft:(id)sender {
       [self hide];
    }

效果如下：

![gif](https://github.com/linsyorozuya/LeftSlideViewDemo/blob/master/leftslide.gif)


