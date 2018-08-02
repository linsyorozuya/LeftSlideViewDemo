//
//  UIViewController+SlideFromSidee.m
//  DatingU
//
//  Created by linsyorozuya on 2017/9/6.
//  Copyright © 2017年 linsyorozuya. All rights reserved.
//

#import "UIViewController+SlideFromSide.h"
#import <objc/runtime.h>

@implementation UIViewController (SlideFromSide)
#pragma mark - UIPanGestureRecognizer
-(void)initSlideFoundationWithDirection:(SlideDirection)direction
{
    self.direction = direction;    
    // 点击收起的遮罩层
    self.maskView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.maskView.backgroundColor = [UIColor colorWithRed:0.184 green:0.184 blue:0.216 alpha:0.50];
    self.maskView.alpha = 0;
    self.maskView.hidden = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:self.maskView];
    
    // 添加 view 到 keyWindow
    CGRect frame = self.view.frame;
    frame.origin.x = self.direction == SlideDirectionFromLeft ? -CGRectGetWidth(self.view.frame) : CGRectGetWidth([UIScreen mainScreen].bounds);
    self.view.frame = frame;
    [[UIApplication sharedApplication].keyWindow addSubview:self.view];
    
    // 添加滑动手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(didPanEvent:)];
    [self.maskView addGestureRecognizer:pan];
    
    UIPanGestureRecognizer *pan1 = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(didPanEvent:)];
    [self.view addGestureRecognizer:pan1];
    
    // 添加点击手势收起View
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
    [self.maskView addGestureRecognizer:tap];
}

#pragma mark -- set & get
-(BOOL)isOpen
{
    return  [objc_getAssociatedObject(self, _cmd) boolValue];
}

-(void)setIsOpen:(BOOL)isOpen
{
    objc_setAssociatedObject(self, @selector(isOpen), @(isOpen), OBJC_ASSOCIATION_ASSIGN);
}

-(SlideDirection)direction
{
    return  [objc_getAssociatedObject(self, _cmd) integerValue];
}

-(void)setDirection:(SlideDirection)direction
{
    objc_setAssociatedObject(self,  @selector(direction), @(direction), OBJC_ASSOCIATION_ASSIGN);
}

-(SlideDirection)currentPanDirection
{
    return  [objc_getAssociatedObject(self, _cmd) integerValue];
}

-(void)setCurrentPanDirection:(SlideDirection)currentPanDirection
{
    objc_setAssociatedObject(self,  @selector(currentPanDirection), @(currentPanDirection), OBJC_ASSOCIATION_ASSIGN);
}


-(UIView *)maskView{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setMaskView:(UIView *)maskView
{
    objc_setAssociatedObject(self, @selector(maskView), maskView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark -- 拖动隐藏

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
//    return [touch.view isEqual:self.view];
//}

-(void)didPanEvent:(UIPanGestureRecognizer *)recognizer
{
    CGPoint translation = [recognizer translationInView:self.view];
    NSLog(@"translation.x == %f", translation.x);
    if(translation.x != 0){
        self.currentPanDirection = translation.x > 0 ? SlideDirectionFromRight : SlideDirectionFromLeft;
    }
    
    [recognizer setTranslation:CGPointZero inView:self.view];
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    
    //---根据手势状态操作
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:{
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            if (self.direction == SlideDirectionFromLeft) {
                if (translation.x >= 0 )
                {
                    //SwipRight
                    CGFloat tempX = CGRectGetMinX(self.view.frame) + translation.x;
                    if (tempX<0) {
                        self.view.frame = CGRectMake(tempX, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
                    }
                }
                else
                {
                    //SwipLeft
                    CGFloat tempX = CGRectGetMinX(self.view.frame) + translation.x;
                    self.view.frame = CGRectMake(tempX, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
                }
            }else{
                if (translation.x >= 0 )
                {
                    //SwipRight
                    CGFloat tempX = CGRectGetMinX(self.view.frame) + translation.x;
                    self.view.frame = CGRectMake(tempX, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
                }
                else
                {
                    //SwipLeft
                    CGFloat tempX = CGRectGetMinX(self.view.frame) + translation.x;
                    if(tempX > (CGRectGetWidth([UIScreen mainScreen].bounds) - CGRectGetWidth(self.view.frame))){
                        self.view.frame = CGRectMake(tempX, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
                    }
                }
            }
            
            break;
        }
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
        {
            if(self.direction == SlideDirectionFromLeft && self.currentPanDirection == SlideDirectionFromRight){
                [self show];
            }else if(self.direction == SlideDirectionFromRight && self.currentPanDirection == SlideDirectionFromLeft){
                [self show];
            }else{
                [self hide];
            }
            break;
        }
            
        default:
            break;
    }
}

/**关闭左视图 */
- (void)hide
{
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut  animations:^{
        self.view.frame = CGRectOffset(self.view.frame, self.direction == SlideDirectionFromLeft ? -CGRectGetWidth(self.view.frame) : CGRectGetWidth(self.view.frame), 0) ;
        self.maskView.alpha = 0;
    }completion:^(BOOL finished) {
        self.isOpen = NO;
        self.maskView.hidden = YES;
        [self.view removeFromSuperview];
    }];
}

/** 打开视图 */
- (void)show
{
    self.maskView.hidden = NO;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut  animations:^{
        self.view.frame = CGRectMake(self.direction == SlideDirectionFromLeft ? 0 : CGRectGetWidth([UIScreen mainScreen].bounds) - CGRectGetWidth(self.view.frame), 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
        self.maskView.alpha = 0.5;
    } completion:^(BOOL finished) {
        self.isOpen = YES;
    }];
}



@end
