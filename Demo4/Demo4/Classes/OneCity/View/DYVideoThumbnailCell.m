//
//  DYVideoThumbnailCell.m
//  Demo4
//
//  Created by hehaichi on 2020/8/17.
//  Copyright © 2020 hehaichi. All rights reserved.
//

#import "DYVideoThumbnailCell.h"
@interface DYVideoThumbnailCell()
@property(nonatomic ,strong,readwrite) UIImageView *imageView;
@end

@implementation DYVideoThumbnailCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];  
    }
    return self;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imageView;
}
@end
