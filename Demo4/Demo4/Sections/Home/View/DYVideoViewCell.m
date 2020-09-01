//
//  DYVideoViewCell.m
//  DouYin
//
//  Created by hehaichi on 2020/8/3.
//  Copyright © 2020 hehaichi. All rights reserved.
//

#import "DYVideoViewCell.h"
#import "Masonry.h"

@interface DYVideoViewCell()
@property (nonatomic,strong,readwrite) DYVideoView *videoView;
@end
@implementation DYVideoViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.videoView];
        self.contentView.backgroundColor = DYColor.blackColor0;
        
    }
    return self;
}

- (void)setData:(DYVideoModel *)data {
    _data = data;
    _videoView.videoURL = data.videoUrl;
    _videoView.frame = CGRectMake(0, 0, data.videoViewSize.width, data.videoViewSize.height);
    
}

- (DYVideoView *)videoView {
    if (!_videoView) {
        _videoView= [DYVideoView new];;
    }
    return _videoView;
}

@end
