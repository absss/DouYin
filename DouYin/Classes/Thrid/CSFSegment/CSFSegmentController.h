//
//  CSFSegmentController.h
//  CSFSegmentController
//
//  Created by hehaichi on 2010/08/09.
//  Copyright © 2019 CITICSF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSFSegmentView.h"
NS_ASSUME_NONNULL_BEGIN
@class CSFSegmentController;
@protocol CSFSegmentControllerDelegate <NSObject>
@optional
- (BOOL)controller:(CSFSegmentController *)controller shouldSelectedIndex:(NSUInteger )index;
- (void)controller:(CSFSegmentController *)controller didSelectedIndex:(NSUInteger)index;
@end

@interface CSFSegmentController : UIViewController<UIScrollViewDelegate>
@property (nonatomic, strong) NSArray <UIViewController *>*viewControllers;
@property (nonatomic, strong, readonly) CSFSegmentView *segmentView;
@property (nonatomic, strong, readonly) UIViewController *currentViewController;
@property (nonatomic, strong, readonly) UIScrollView *containerView;
@property (nonatomic, readonly) NSUInteger index;
@property (nonatomic, getter=isPagingEnabled) BOOL pagingEnabled;
@property (nonatomic, getter=isBounces) BOOL bounces;
@property (nonatomic, weak) id<CSFSegmentControllerDelegate> delegate;


+ (instancetype)segmentControllerWithTitles:(NSArray <NSString *>*)titles;
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles;

@end

@interface UIViewController (CSFSegment)
@property (nonatomic, strong, readonly, nullable) CSFSegmentController *segmentController;
- (void)addSegmentController:(CSFSegmentController *_Nullable)segment;
@end
NS_ASSUME_NONNULL_END

