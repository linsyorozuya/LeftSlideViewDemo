//
//  UIViewController+LeftSlide.h
//  DatingU
//
//  Created by linsyorozuya on 2017/9/6.
//  Copyright © 2017年 linsyorozuya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (LeftSlide)<UIGestureRecognizerDelegate>
@property (nonatomic,strong) UIView *maskView;
@property (nonatomic,assign) BOOL isOpen;

-(void)show;
-(void)hide;
-(void)initSlideFoundation;
@end
