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
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    self.menu = [story instantiateViewControllerWithIdentifier:@"LeftMenuViewController"];
    self.menu.view.frame = CGRectMake(0, 0, 300, self.view.bounds.size.height);
    [self.menu initSlideFoundationWithDirection:SlideDirectionFromLeft];
    [self.menu show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
