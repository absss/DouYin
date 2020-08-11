//
//  DYSegmentView.m
//  DouYin
//
//  Created by hehaichi on 2020/8/1.
//  Copyright © 2020 hehaichi. All rights reserved.
//

#import "DYSegmentView.h"

@interface DYSegmentItemView()
@property(nonatomic,copy) void(^clickAction)(NSInteger tag, NSString *title);
@property(nonatomic,strong,readwrite) UIButton * button;

@end
@implementation DYSegmentItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.button];
        self.button.frame = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame));
        [self.button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    [self.button setTitle:title forState:UIControlStateNormal];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.button.frame = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame));
}

- (void)click:(UIButton *)sender {
    if (self.clickAction) {
        self.clickAction(self.tag,self.title);
    }
}

UIButtonGetter(button, nil, DYColor.whiteColor0, [DYFont systemFontOfSize:16])
@end

@interface DYSegmentView()<UIScrollViewDelegate>
@property(nonatomic,assign,readwrite) NSInteger selectedIndex;
@property(nonatomic,strong) UIView *indicatorBar;
@property(nonatomic,assign,readwrite) BOOL isMovingItem;
@end


@implementation DYSegmentView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _indicatorBarHeight = 3;
        _minItemOffset = 20;
        self.alwaysBounceHorizontal = NO;
        self.alwaysBounceVertical = NO;
        self.bounces = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
    }
    return self;
}


UIViewGetter(indicatorBar, UIColor.redColor);

- (CGFloat)itemOffset:(NSInteger)index {
    DYSegmentItemView *view  = [self itemViewForIdx:index];
    return CGRectGetWidth(view.frame)/2 - view.titleWidth/2;
   
}

- (void)reloadData {
   
    [self removeAllSubViews];
    
    NSInteger totalCount = [self.segemtnDelegate numberOfItemsInSegmentView:self];
    CGFloat height = CGRectGetHeight(self.frame)-_indicatorBarHeight;
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat totolWidth = 0;
    
    for (int i = 0; i < totalCount; i++) {
        DYSegmentItemView *itemView = [self.segemtnDelegate segmentView:self viewForItemAtIndex:i];
        NSString *title = itemView.title;
        CGFloat itemWidth = [title widthWithFixedHeight:height font:itemView.button.titleLabel.font];
        itemView.titleWidth = itemWidth;
        itemWidth+=_minItemOffset*2;
        itemView.frame = CGRectMake(totolWidth, 0, itemWidth, height);
        [self addSubview:itemView];
        itemView.tag = 100+i;
        
        DYWeakSelf
        itemView.clickAction = ^(NSInteger tag, NSString *title) {
            [weakSelf moveToIndex:tag-100];
            
        };
     
        totolWidth += itemWidth;
    }
    if (totolWidth < width) {
        totolWidth = width;
        CGFloat itemWidth = totolWidth / totalCount;
        for (int i = 0; i < totalCount; i++) {
            DYSegmentItemView *itemView = [self itemViewForIdx:i];
            itemView.frame = CGRectMake(i*itemWidth, 0, itemWidth, height);
        }
    }
    
    
    self.contentSize = CGSizeMake(totolWidth, CGRectGetHeight(self.frame));
    DYSegmentItemView *view = [self itemViewForIdx:self.selectedIndex];
    CGFloat itemOffset = [self itemOffset:self.selectedIndex];
    self.indicatorBar.frame = CGRectMake(CGRectGetMinX(view.frame)+itemOffset,height, view.titleWidth, _indicatorBarHeight);
    [self addSubview:self.indicatorBar];
    self.indicatorBar.backgroundColor = self.indicatorBarColor;
    
    
}
- (DYSegmentItemView *)itemViewForIdx:(NSInteger)index {
    return (DYSegmentItemView *)[self viewWithTag:100+index];
    
}
- (void)moveToIndex:(NSInteger)index {
    self.isMovingItem = YES;
    BOOL should = YES;
    if ([self.segemtnDelegate  respondsToSelector:@selector(segmentView:shouldSelectItemAtIndex:)]) {
        should =  [self.segemtnDelegate segmentView:self shouldSelectItemAtIndex:index];
    }
    if (!should) {
        return;
    }
    self.selectedIndex = index;
    if ([self.segemtnDelegate respondsToSelector:@selector(segmentView:didSelectItemAtIndex:)]) {
        [self.segemtnDelegate segmentView:self didSelectItemAtIndex:index];
    }
    DYSegmentItemView *itemView = [self itemViewForIdx:index];
    CGRect frame = self.indicatorBar.frame;
    CGFloat itemOffset = [self itemOffset:index];
    frame.origin.x = itemView.frame.origin.x+itemOffset;
    frame.size.width = itemView.titleWidth;
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.indicatorBar.frame = frame;
      } completion:^(BOOL finished) {
         
      }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.isMovingItem = NO;
    });
    [self scrollSegementView];
    
    
}


- (void)followMove:(CGFloat)offsetX pageWidth:(CGFloat)pageWidth {
    if (_isMovingItem) {
        return;;
    }
    NSInteger currentIndex = self.selectedIndex;
    
    // 当当前的偏移量大于被选中index的偏移量的时候，就是在右侧
    CGFloat offset; // 在同一侧的偏移量
    NSInteger buttonIndex = currentIndex;
    if (offsetX >=self.selectedIndex * pageWidth) {
        offset = offsetX -self.selectedIndex * pageWidth;
        buttonIndex += 1;
    } else {
        offset =self.selectedIndex * pageWidth - offsetX;
        buttonIndex -= 1;
        currentIndex -= 1;
    }
    
    CGFloat currentItemOffset = [self itemOffset:currentIndex];
    CGFloat targetItemOffset = [self itemOffset:buttonIndex];
    
    DYSegmentItemView * currentview = [self itemViewForIdx:self.selectedIndex];
    DYSegmentItemView * targetView = [self itemViewForIdx:self.selectedIndex];
    CGFloat originMovedX = _style == DYSegmentIndicatorStyleWithTotalWidth ? CGRectGetMinX(currentview.frame) : CGRectGetMinX(currentview.frame)+currentItemOffset;
    CGFloat targetMovedWidth = CGRectGetWidth(currentview.frame);//需要移动的距离
    
    CGFloat targetIndicatorWidth = _style == DYSegmentIndicatorStyleWithTotalWidth ? CGRectGetWidth(targetView.frame):CGRectGetWidth(targetView.frame) - 2*targetItemOffset;
    CGFloat originIndicatorWidth = _style == DYSegmentIndicatorStyleWithTotalWidth ? CGRectGetWidth(currentview.frame):CGRectGetWidth(currentview.frame) - 2*currentItemOffset;
    
    
    CGFloat moved; // 移动的距离
    
    moved = offsetX -self.selectedIndex * pageWidth;
    _indicatorBar.frame = CGRectMake(originMovedX + targetMovedWidth / pageWidth * moved, _indicatorBar.frame.origin.y,  originIndicatorWidth + (targetIndicatorWidth - originIndicatorWidth) / pageWidth * offset, _indicatorBar.frame.size.height);
}

- (void)scrollSegementView {
    DYSegmentItemView *itemView = [self itemViewForIdx:self.selectedIndex];
    CGFloat selectedWidth = itemView.frame.size.width;
    CGFloat offsetX = (CGRectGetWidth(self.frame) - selectedWidth) / 2;
    
    if (itemView.frame.origin.x <= self.frame.size.width / 2) {
        [self setContentOffset:CGPointMake(0, 0) animated:YES];
    } else if (CGRectGetMaxX(itemView.frame) >= (self.contentSize.width - self.frame.size.width / 2)) {
        [self setContentOffset:CGPointMake(self.contentSize.width - self.frame.size.width, 0) animated:YES];
    } else {
        [self setContentOffset:CGPointMake(CGRectGetMinX(itemView.frame) - offsetX, 0) animated:YES];
    }
}


@end
