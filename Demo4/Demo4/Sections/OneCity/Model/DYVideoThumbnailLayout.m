//
//  DYVideoThumbnailLayout.m
//  Demo4
//
//  Created by hehaichi on 2020/8/17.
//  Copyright © 2020 hehaichi. All rights reserved.
//

#import "DYVideoThumbnailLayout.h"
@interface DYVideoThumbnailLayout()
@property (nonatomic, strong) NSMutableArray *cellHeightArray;
@property (nonatomic, strong) NSMutableArray *cellFrameArray;
@end
@implementation DYVideoThumbnailLayout

- (void)prepareLayout{
    [super prepareLayout];
    NSInteger column = [self.delegate numberOfColumnWithLayout:self];
    _cellHeightArray = [NSMutableArray arrayWithCapacity:column];
    for (int i = 0; i < column; i++) {
        [_cellHeightArray addObject:@(0)];
    }
    _cellFrameArray = [NSMutableArray arrayWithCapacity:column];
    [self initCellHeight];
}


- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [_cellFrameArray objectAtIndex:indexPath.item];
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray *temp = [NSMutableArray arrayWithCapacity:0];
    for (UICollectionViewLayoutAttributes *attributes in _cellFrameArray) {
        if (CGRectIntersectsRect(attributes.frame, rect)) {
            [temp addObject:attributes];
        }
    }
    return temp;
}

- (CGSize)collectionViewContentSize{
    CGFloat width = CGRectGetWidth(self.collectionView.frame);
    CGFloat height = [self getMaxH];
    return CGSizeMake(width, height);
}

#pragma mark - private method
- (void)initCellHeight{
    NSInteger allCellNumber = [self.collectionView numberOfItemsInSection:0];
    CGFloat totalWidth = CGRectGetWidth(self.collectionView.frame);
    NSInteger column = [self.delegate numberOfColumnWithLayout:self];
    CGFloat width = totalWidth/column;
    for (int i = 0; i < allCellNumber; i++) {
        NSInteger currentcolumn = [self getMinHCol];
        CGFloat x = currentcolumn * (width);
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        CGFloat y = [[_cellHeightArray objectAtIndex:currentcolumn] floatValue];
        CGFloat height = 0.f;
        height =[self.delegate layout:self heightForCellAtIndexPath:indexPath];
        CGRect frame = CGRectMake(x, y, width, height);
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attributes.frame = frame;
        [_cellFrameArray addObject:attributes];
        _cellHeightArray[currentcolumn] = @(frame.size.height + frame.origin.y);
    }
}

- (NSInteger)getMinHCol{
    __block NSInteger currentcolumn = 0;
    __block CGFloat shortHeight = CGFLOAT_MAX;
    [_cellHeightArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj floatValue] < shortHeight) {
            shortHeight = [obj floatValue];
            currentcolumn = idx;
        }
    }];
    return currentcolumn;
}

- (CGFloat)getMaxH{
    __block NSInteger currentcolumn = 0;
    __block CGFloat longHeight = 0;
    [_cellHeightArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj floatValue] > longHeight) {
            longHeight = [obj floatValue];
            currentcolumn = idx;
        }
    }];
    return longHeight;
}
@end
