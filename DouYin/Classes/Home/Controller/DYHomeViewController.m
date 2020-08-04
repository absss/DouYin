//
//  DYHomeViewController.m
//  DouYin
//
//  Created by hehaichi on 2020/7/31.
//  Copyright © 2020 hehaichi. All rights reserved.
//

#import "DYHomeViewController.h"
#import "DYSegmentView.h"
#import "DYVideoTableController.h"

@interface DYHomeViewController ()<UIScrollViewDelegate,DYSegmentDelegate>
@property(nonatomic, strong)UIView * navView;
@property(nonatomic, strong)DYSegmentView * segmentView;
@property (nonatomic, strong) UIScrollView *containerView;
@end

@implementation DYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubViews];

}

- (void)setupSubViews {
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view addSubview:[UIView new]];
    [self.view addSubview:self.containerView];
    [self.view addSubview:self.navView];
    [self.navView addSubview:self.segmentView];
    
    self.navView.frame = CGRectMake(0, 0, DYViewControllerWidth, 90);
    self.containerView.frame = CGRectMake(0, 0, DYViewControllerWidth,DYViewControllerHeight);
  
    
    DYVideoTableController *v1 = [DYVideoTableController new];
    v1.title = @"关注";
    v1.view.backgroundColor = UIColor.redColor;
    
    DYVideoTableController *v2 = [DYVideoTableController new];
    v2.title = @"推荐";
    v2.view.backgroundColor = UIColor.blueColor;
  
    [self addChildViewController:v1];
    [self addChildViewController:v2];

    self.containerView.contentSize = CGSizeMake(DYViewControllerWidth*self.childViewControllers.count, DYViewControllerHeight);
    int i = 0;
    for (UIViewController *vc in self.childViewControllers) {
        vc.view.frame = CGRectMake(i*DYViewControllerWidth, 0, DYViewControllerWidth, CGRectGetHeight(self.containerView.frame));
        [self.containerView addSubview:vc.view];
        i++;
    }
    [self.segmentView reloadData];
}

UIViewGetter(navView, UIColor.clearColor);
- (UIScrollView *)containerView {
    if (!_containerView) {
        _containerView = [UIScrollView new];
        _containerView.backgroundColor = [UIColor clearColor];
        _containerView.showsVerticalScrollIndicator = NO;
        _containerView.showsHorizontalScrollIndicator = NO;
        _containerView.delegate = self;
        _containerView.pagingEnabled = YES;
        _containerView.bounces = NO;
}
    return _containerView;;
}

- (DYSegmentView *)segmentView {
    if (!_segmentView) {
        _segmentView = [[DYSegmentView alloc]initWithFrame:CGRectMake(100, 44, DYViewControllerWidth-200, 44)];
        _segmentView.segemtnDelegate = self;
        _segmentView.indicatorBarColor = DYColor.whiteColor1;
    }
    return _segmentView;
}

- (NSInteger)numberOfItemsInSegmentView:(DYSegmentView *)segmentView {
    return self.childViewControllers.count;
}

- (DYSegmentItemView *)segmentView:(DYSegmentView *)segmentView viewForItemAtIndex:(NSInteger)index {
    DYSegmentItemView *itemView = [DYSegmentItemView new];
    itemView.button.titleLabel.font = [DYFont boldSystemFontOfSize:20];
    itemView.title = self.childViewControllers[index].title;
    return itemView;
}

- (void)segmentView:(DYSegmentView *)segmentView didSelectItemAtIndex:(NSInteger)index {
    [self.containerView setContentOffset:CGPointMake(index*CGRectGetWidth(self.view.frame), 0) animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.segmentView followMove:scrollView.contentOffset.x pageWidth:DYViewControllerWidth];    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == _containerView) {
        NSInteger index = round(scrollView.contentOffset.x / CGRectGetWidth(self.view.frame));
        if (index != self.segmentView.selectedIndex) {
            [self.segmentView moveToIndex:index];
        }
    }
}

@end
