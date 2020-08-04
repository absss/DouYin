//
//  DYVideoTableController.m
//  DouYin
//
//  Created by hehaichi on 2020/8/3.
//  Copyright © 2020 hehaichi. All rights reserved.
//

#import "DYVideoTableController.h"
#import "DYVideoViewCell.h"

@interface DYVideoTableController ()<UITableViewDelegate,UITableViewDataSource>
{
    DYVideoTableVcType _type;
}
@property(nonatomic, strong) UITableView *tableView;
@end

@implementation DYVideoTableController

- (instancetype)initWithType:(DYVideoTableVcType)type
{
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = CGRectGetHeight(self.view.frame);
        _tableView.sectionHeaderHeight = 0.1;
        [_tableView registerClass:[DYVideoViewCell class] forCellReuseIdentifier:@"DYVideoViewCell"];
    }
    return _tableView;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 49+34;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DYVideoViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"DYVideoViewCell"];
    cell.contentView.backgroundColor = UIColor.greenColor;
    return cell;
}
@end
