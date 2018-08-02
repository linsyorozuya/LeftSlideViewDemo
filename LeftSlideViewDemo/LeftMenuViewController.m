//
//  LeftMenuViewController.m
//  DatingU
//
//  Created by linsyorozuya on 2017/9/6.
//  Copyright © 2017年 linsyorozuya. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "LeftMenuCell.h"

@interface LeftMenuViewController ()
@property (nonatomic,strong) NSArray *tableViewItems;
@end

@implementation LeftMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableViewItems = @[@{@"imageName":@"",@"itemName":@"我的"},
                        @{@"imageName":@"",@"itemName":@"我的"},
                        @{@"imageName":@"",@"itemName":@"我的"},
                        @{@"imageName":@"",@"itemName":@"我的"}
                        ];
}

#pragma mark -- show or hide
- (void)showFromLeft
{
    [self show];
}

- (IBAction)hideToLeft:(id)sender {
    [self hide];
}

#pragma mark -- TableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableViewItems.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = self.tableViewItems[indexPath.row];
    static NSString *CellIdentifier = @"LeftMenuCell";
    LeftMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.itemNameLabel.text = dic[@"itemName"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
