//
//  ttWordVc.m
//  bsbdj
//
//  Created by 王涛 on 16/7/20.
//  Copyright © 2016年 wata. All rights reserved.
//

#import "ttWordVc.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"

@interface ttWordVc ()
/** 帖子数据 */
@property (nonatomic, strong) NSArray *topics;
@end

@implementation ttWordVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @"29";
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.topics = responseObject[@"list"];
        [self.tableView reloadData];
        [responseObject writeToFile:@"/Users/TaoWang/Desktop/tiezi.plist" atomically:YES];
        
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        //cell.backgroundColor = [UIColor blueColor];
    }
    
    NSDictionary *topic = self.topics[indexPath.row];
    cell.textLabel.text = topic[@"name"];
    cell.detailTextLabel.text = topic[@"text"];
    
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:topic[@"profile_image"]] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ttLog(@"%@", NSStringFromUIEdgeInsets(tableView.contentInset));
    ttLog(@"%@", NSStringFromCGRect(tableView.frame));
}


@end
