//
//  UIViewController+SlideFromSide.h
//  DatingU
//
//  Created by linsyorozuya on 2017/9/6.
//  Copyright © 2017年 linsyorozuya. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SlideDirection) {
    SlideDirectionFromLeft,
    SlideDirectionFromRight
};

@interface UIViewController (SlideFromSide)<UIGestureRecognizerDelegate>
@property (nonatomic,strong) UIView *maskView;
@property (nonatomic,assign) BOOL isOpen;
@property (nonatomic,assign) SlideDirection direction;
@property(nonatomic, assign) SlideDirection currentPanDirection;

-(void)show;
-(void)hide;
-(void)initSlideFoundationWithDirection:(SlideDirection)direction;

@end
