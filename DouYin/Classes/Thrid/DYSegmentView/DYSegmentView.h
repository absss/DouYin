//
//  DYSegmentView.h
//  DouYin
//
//  Created by hehaichi on 2020/8/1.
//  Copyright © 2020 hehaichi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DYSegmentIndicatorStyle) {
    DYSegmentIndicatorStyleWithTitleWidth,
    DYSegmentIndicatorStyleWithTotalWidth
};
@class DYSegmentItemView;
@class DYSegmentView;

@protocol DYSegmentDelegate <NSObject>

@required
- (NSInteger)numberOfItemsInSegmentView:(DYSegmentView *)segmentView;
- (DYSegmentItemView *)segmentView:(DYSegmentView *)segmentView viewForItemAtIndex:(NSInteger)index;

@optional
- (BOOL)segmentView:(DYSegmentView *)segmentView shouldSelectItemAtIndex:(NSInteger)index;
- (void)segmentView:(DYSegmentView *)segmentView didSelectItemAtIndex:(NSInteger)index;
@end

@interface DYSegmentItemView : UIView;
@property(nonatomic,assign) NSString *title;
@property(nonatomic,assign) CGFloat titleWidth;
@property(nonatomic,strong,readonly) UIButton * button;

@end

@interface DYSegmentView : UIScrollView
@property(nonatomic, assign) CGFloat indicatorBarHeight; //指示杆高度
@property(nonatomic, strong) UIColor *indicatorBarColor; // 指示杆颜色
@property(nonatomic,assign) CGFloat minItemOffset; // 默认20
@property(nonatomic, assign) DYSegmentIndicatorStyle style; // 指示杆颜色
@property(nonatomic, weak) id<DYSegmentDelegate> segemtnDelegate; // 代理
@property(nonatomic,assign,readonly) NSInteger selectedIndex;
@property(nonatomic,assign,readonly) BOOL isMovingItem;

/// 加载数据
- (void)reloadData;
/// 主动移动到某个index
- (void)moveToIndex:(NSInteger)index;
/// 根据index得到itemView
- (DYSegmentItemView *)itemViewForIdx:(NSInteger)index;

/// segment的指示杆跟随外部页面移动，
/// @param offsetX 移动距离
/// @param pageWidth 页面的宽度
- (void)followMove:(CGFloat)offsetX pageWidth:(CGFloat)pageWidth ;
@end


