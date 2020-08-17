//
//  DYVideoThumbnailLayout.h
//  Demo4
//
//  Created by hehaichi on 2020/8/17.
//  Copyright © 2020 hehaichi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DYVideoThumbnailLayout;
@protocol DYVideoThumbnailLayoutDelegate <NSObject>
@required
// 高度
- (CGFloat)layout:(DYVideoThumbnailLayout *)layout heightForCellAtIndexPath:(NSIndexPath *)indexPath;
// 列数
- (NSInteger)numberOfColumnWithLayout:(DYVideoThumbnailLayout *)layout;
@end

@interface DYVideoThumbnailLayout : UICollectionViewLayout
@property (nonatomic,weak)id<DYVideoThumbnailLayoutDelegate> delegate;
@end


