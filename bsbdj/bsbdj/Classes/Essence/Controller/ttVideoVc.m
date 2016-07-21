//
//  ttVideoVc.m
//  bsbdj
//
//  Created by 王涛 on 16/7/20.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "ttVideoVc.h"

@interface ttVideoVc ()

@end

@implementation ttVideoVc

- (void)viewDidLoad {
    [super viewDidLoad];
    

}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
//        cell.backgroundColor = [UIColor blueColor];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@----%zd", [self class], indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ttLog(@"%@", NSStringFromUIEdgeInsets(tableView.contentInset));
    ttLog(@"%@", NSStringFromCGRect(tableView.frame));
}

@end
