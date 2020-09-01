//
//  DYVideoRecordViewController.m
//  Demo4
//
//  Created by hehaichi on 2020/8/12.
//  Copyright © 2020 hehaichi. All rights reserved.
//

#import "DYVideoRecordViewController.h"
#import "DYVideoRecordView.h"

@interface DYVideoRecordViewController ()
@property(nonatomic ,strong) DYVideoRecordView *recordView;
@end

@implementation DYVideoRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.recordView];
    [self.recordView startCapture];
}

- (DYVideoRecordView *)recordView {
    if (!_recordView) {
        _recordView = [[DYVideoRecordView alloc] initWithFrame:self.view.frame];
    }
    return _recordView;;
}
@end
