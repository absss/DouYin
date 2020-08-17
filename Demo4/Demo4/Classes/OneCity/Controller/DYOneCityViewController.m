//
//  DYOneCityViewController.m
//  DouYin
//
//  Created by hehaichi on 2020/7/31.
//  Copyright © 2020 hehaichi. All rights reserved.
//

#import "DYOneCityViewController.h"
#import "DYVideoThumbnailCell.h"
#import "DYVideoThumbnailLayout.h"
#import "DYVideoThumbnailModel.h"

@interface DYOneCityViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,DYVideoThumbnailLayoutDelegate>
@property(nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray <DYVideoThumbnailModel *>*dataArray;
@end

@implementation DYOneCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"同城";
    [self.view addSubview:self.collectionView];
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    DYVideoThumbnailModel *model = [DYVideoThumbnailModel new];
    model.height = 80;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        DYVideoThumbnailLayout *layout = [DYVideoThumbnailLayout new];
        layout.delegate = self;
        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[DYVideoThumbnailCell class] forCellWithReuseIdentifier:@"reuseId"];
    }
    return _collectionView;
}

#pragma mark - UICollectionViewDataSource,UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DYVideoThumbnailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reuseId" forIndexPath:indexPath];
    cell.imageView.image = self.dataArray[indexPath.row].thumbnail;
    return cell;
}

#pragma mark - DYVideoThumbnailLayoutDelegate
- (CGFloat)layout:(DYVideoThumbnailLayout *)layout heightForCellAtIndexPath:(NSIndexPath *)indexPath {
    return self.dataArray[indexPath.row].height;
}

- (NSInteger)numberOfColumnWithLayout:(DYVideoThumbnailLayout *)layout {
    return 2;
}
@end
