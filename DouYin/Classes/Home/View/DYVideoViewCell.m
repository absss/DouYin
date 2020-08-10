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

    //  the view for the selected state
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
    _videoView.data = data;
    
}

- (DYVideoView *)videoView {
    if (!_videoView) {
        _videoView= [[DYVideoView alloc] initWithFrame:self.contentView.frame];
    }
    return _videoView;
}

@end
