//
//  CSFSegmentController.m
//  CSFSegmentController
//
//  Created by hehaichi on 2019/08/09.
//  Copyright © 2019 CITICSF. All rights reserved.
//

#import "CSFSegmentController.h"

#define kSCREENBOUNDS [[UIScreen mainScreen] bounds]
typedef NS_ENUM(NSUInteger, CSFScrollRectPosition) {
    CSFScrollRectPositionOrigin, // 在原始位置
    CSFScrollRectPositionAcross, // 在中间段位置
    CSFScrollRectPositionTarget, // 到达目标位置
};

@interface CSFSegmentController ()
@property (nonatomic, strong, readwrite) UIViewController *currentViewController;
@property (nonatomic, strong, readwrite) CSFSegmentView *segmentView;
@property (nonatomic, strong, readwrite) UIScrollView *containerView;
@property (nonatomic, readwrite) NSUInteger index;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint viewOrigin; // 记录原始位置
@end

@implementation CSFSegmentController

+ (instancetype)segmentControllerWithTitles:(NSArray<NSString *> *)titles {
    return [[self alloc] initWithFrame:CGRectMake(0, 0, kSCREENBOUNDS.size.width, kSCREENBOUNDS.size.height) titles:titles];
}

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles {
    self = [super init];
    if (!self || titles.count == 0) {
        return nil;
    }
    
    _titles = titles;
    _size = frame.size;
    _viewOrigin = frame.origin;
    _pagingEnabled = YES;
    _bounces = NO;
    self.view.frame = frame;
    
    [self segmentPageSetting];
    [self containerViewSetting];
    
    return self;
}

- (void)segmentPageSetting {
    _segmentView = [[CSFSegmentView alloc] initWithFrame:CGRectMake(0, 0, _size.width, 44) titles:_titles];
    _segmentView.backgroundColor= [UIColor whiteColor];
    __weak typeof(self) weakSelf = self;
    _segmentView.didSelectedBlock = ^(UIButton * _Nonnull button, NSUInteger index) {
        [weakSelf moveToViewControllerAtIndex:index];
    };
    _segmentView.shouldSelectedBlock = ^BOOL(UIButton * _Nonnull button, NSUInteger index) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if ([strongSelf.delegate respondsToSelector:@selector(controller:shouldSelectedIndex:)]) {
           return [strongSelf.delegate controller:strongSelf shouldSelectedIndex:index];
        }
        return YES;
    };
    [self.view addSubview:_segmentView];
}

- (void)containerViewSetting {
    _containerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CSFSegmentHeight, _size.width, _size.height - CSFSegmentHeight)];
    _containerView.backgroundColor = [UIColor clearColor];
    _containerView.showsVerticalScrollIndicator = NO;
    _containerView.showsHorizontalScrollIndicator = NO;
    _containerView.delegate = self;
    _containerView.pagingEnabled = _pagingEnabled;
    _containerView.bounces = _bounces;
    

    [self.view addSubview:_containerView];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == _containerView) {
        NSInteger index = round(scrollView.contentOffset.x / _size.width);
        
        // 移除不足一页的操作
        if (index != self.index) {
            [self.segmentView setSelectedAtIndex:index];
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == _containerView) {
        CGFloat offsetX = scrollView.contentOffset.x;
        
        [_segmentView adjustOffsetXToFixIndicatePosition:offsetX];
    }
}

- (void)moveToViewControllerAtIndex:(NSUInteger)index {
    [self scrollContainerViewToIndex:index];
    
    UIViewController *targetViewController = self.viewControllers[index];
    if ([self.childViewControllers containsObject:targetViewController] || !targetViewController) {
        return;
    }
    
    [self updateFrameChildViewController:targetViewController atIndex:index];
}


- (void)updateFrameChildViewController:(UIViewController *)childViewController atIndex:(NSUInteger)index {
    childViewController.view.frame = CGRectOffset(CGRectMake(0, 0, _containerView.frame.size.width, _containerView.frame.size.height), index * _size.width, 0);
    
    [_containerView addSubview:childViewController.view];
    [self addChildViewController:childViewController];
}

#pragma mark ---- scroll

- (void)scrollContainerViewToIndex:(NSUInteger)index {
    [UIView animateWithDuration:_segmentView.duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [_containerView setContentOffset:CGPointMake(index * _size.width, 0)];
    } completion:^(BOOL finished) {
        if ([self.delegate respondsToSelector:@selector(controller:didSelectedIndex:)]) {
            [self.delegate controller:self didSelectedIndex:index];
        }
    }];
}

#pragma mark - Setter

- (void)setViewControllers:(NSArray *)viewControllers {
    _viewControllers = viewControllers;
    _containerView.contentSize = CGSizeMake(viewControllers.count * _size.width, _size.height - CSFSegmentHeight);
}

- (void)setPagingEnabled:(BOOL)pagingEnabled {
    _pagingEnabled = pagingEnabled;
    
    self.containerView.pagingEnabled = pagingEnabled;
}

- (void)setBounces:(BOOL)bounces {
    _bounces = bounces;
    
    self.containerView.bounces = bounces;
}

#pragma mark - Getter

- (NSUInteger)index {
    return self.segmentView.index;
}

- (UIViewController *)currentViewController {
    return self.viewControllers[self.index];
}

@end

#pragma mark - 分类(UIViewController)

#import <objc/runtime.h>

@implementation UIViewController(CSFSegment)
@dynamic segmentController;

- (CSFSegmentController *)segmentController {
    if ([self.parentViewController isKindOfClass:[CSFSegmentController class]] && self.parentViewController) {
        return (CSFSegmentController *)self.parentViewController;
    }
    return nil;
}

- (void)addSegmentController:(CSFSegmentController *)segment {
    if (self == segment) {
        return;
    }
    
    [self.view addSubview:segment.view];
    [self addChildViewController:segment];
    
  
    
    // 默认加入第一个控制器
    UIViewController *firstViewController = segment.viewControllers.firstObject;
    
    if (!firstViewController) {
        return;
    }
    [segment performSelector:@selector(updateFrameChildViewController:atIndex:) withObject:firstViewController withObject:0];
}
@end
