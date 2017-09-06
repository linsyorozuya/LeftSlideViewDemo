//
//  ViewController.m
//  LeftSlideViewDemo
//
//  Created by linsyorozuya on 2017/9/6.
//  Copyright © 2017年 linsyorozuya. All rights reserved.
//

#import "ViewController.h"
#import "LeftMenuViewController.h"

@interface ViewController ()
@property (nonatomic,strong) LeftMenuViewController *menu;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)openEvent:(id)sender {
    if (!self.menu) {
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        self.menu = [story instantiateViewControllerWithIdentifier:@"LeftMenuViewController"];
        CGRect frame = self.menu.view.frame;
        frame.origin.x = - CGRectGetWidth(self.view.frame);
        self.menu.view.frame = frame;
        
        [[UIApplication sharedApplication].keyWindow addSubview:self.menu.view];
    }
    [self.menu showFromLeft];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
