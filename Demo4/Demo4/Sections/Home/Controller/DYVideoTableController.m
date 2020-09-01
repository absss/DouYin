//
//  DYVideoTableController.m
//  DouYin
//
//  Created by hehaichi on 2020/8/3.
//  Copyright © 2020 hehaichi. All rights reserved.
//

#import "DYVideoTableController.h"
#import "DYVideoViewCell.h"
#import "DYVideoModel.h"

@interface DYVideoTableController ()<UITableViewDelegate,UITableViewDataSource>
{
    DYVideoTableVcType _type;
}
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *dataArray;
@property(nonatomic, assign) NSInteger currentPageIndex;
@end

@implementation DYVideoTableController

- (instancetype)initWithType:(DYVideoTableVcType)type
{
    self = [super init];
    if (self) {
        _type = type;
        _dataArray = [NSMutableArray array];
        _currentPageIndex = -1;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    for (int i = 0; i < 10; i++) {
        NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"v%d",i+1] ofType:@"MP4"];
        NSURL *url = [NSURL fileURLWithPath:path];
        DYVideoModel *model = [DYVideoModel new];
        model.videoUrl = url;
        model.videoViewSize = CGSizeMake(DYViewControllerWidth, DYViewControllerHeight);
        [self.dataArray addObject:model];
    }
    [self.tableView reloadData];
    [self setCurrentPageIndex:0];
    
}

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    DYVideoViewCell *currentcell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_currentPageIndex inSection:0]];
    if (_selected) {
        [self setCurrentPageIndex:_currentPageIndex];
    } else {
        [currentcell.videoView setPlaying:NO animation:NO];
        [currentcell.videoView resetState];
    }
    
}

#pragma mark - setter
- (void)setCurrentPageIndex:(NSInteger)currentPageIndex {
    
    NSInteger preIndex = _currentPageIndex;
    _currentPageIndex = currentPageIndex;
    if (! _selected) {
        return;
    }
    DYVideoViewCell *currentcell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:currentPageIndex inSection:0]];
    DYVideoViewCell *preCell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:preIndex inSection:0]];
    if (currentPageIndex != preIndex) {
        [preCell.videoView setPlaying:NO animation:NO];
        [preCell.videoView resetState];
        [currentcell.videoView setPlaying:YES animation:NO];
    } else {
        if (!currentcell.videoView.isPlaying) {
            [currentcell.videoView setPlaying:YES animation:NO];
        }
    }
}

#pragma mark - getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = CGRectGetHeight(self.view.frame);
        _tableView.sectionHeaderHeight = 0.1;
        [_tableView registerClass:[DYVideoViewCell class] forCellReuseIdentifier:@"DYVideoViewCell"];
        _tableView.pagingEnabled = YES;
        _tableView.backgroundColor = DYColor.blackColor0;
        _tableView.alwaysBounceVertical = NO;
        _tableView.alwaysBounceHorizontal = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
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


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int pageIndex = (int)(scrollView.contentOffset.y / DYViewControllerHeight);
 
    self.currentPageIndex =  pageIndex;
    NSLog(@"currentPageIndex:%d",pageIndex);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DYVideoViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"DYVideoViewCell"];
    cell.data = self.dataArray[indexPath.row];
    return cell;
}
@end
