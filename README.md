# LeftSlideViewDemo

在需要作为侧边栏的视图中添加以下代码即可，例如：

    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    self.menu = [story instantiateViewControllerWithIdentifier:@"LeftMenuViewController"];
    self.menu.view.frame = CGRectMake(0, 0, 300, self.view.bounds.size.height);
    [self.menu initSlideFoundationWithDirection:SlideDirectionFromLeft];
 
显示：
    
    [self.menu show];
    
隐藏：
    
    [self.menu hide];
    
效果如下：

![gif](https://github.com/linsyorozuya/LeftSlideViewDemo/blob/master/leftslide.gif)


