

## 实现思路：



#### 1. 自定义TabBar

基本思路是移除原有TabBar的子视图，然后再在上面添加自定义的`DYTabBar`

`DYTabBar`实现思路基本仿照`UITableView`，数据源由代理实现者提供：

```objc
@class DYTabBar;
@protocol DYTabBarDelegate <NSObject>
- (BOOL)tabbar:(DYTabBar *)tabbar shouldSelectItemAtIndex:(NSInteger)index;
- (void)tabbar:(DYTabBar *)tabbar didSelectItemAtIndex:(NSInteger)index;
@required
// NSString or UIButton 子类
- (id)tabbar:(DYTabBar *)tabbar itemForColumnAtIndex:(NSInteger)index;
- (NSInteger)numberOfItemsWithTabbar:(DYTabBar *)tabbar;
@end

@interface DYTabBar : UIView
@property (nonatomic, weak)id<DYTabBarDelegate> delegate;
- (void)reloadData;
@end
```

中间不是文字，而是一个图片，所以数据源第三个元素应当是一个`UIButton`对象

自由度很高，使用较为方便



#### 2. 首页Segmeny分页

思路：在`UIScrolleView`上添加视图，数据来源由代理者提供， 通过协议方法告知代理者滑动状态的变化，

协议方法定义的思路仿照`UITableView`

```objc
@required
- (NSInteger)numberOfItemsInSegmentView:(DYSegmentView *)segmentView;
- (DYSegmentItemView *)segmentView:(DYSegmentView *)segmentView viewForItemAtIndex:(NSInteger)index;

@optional
- (BOOL)segmentView:(DYSegmentView *)segmentView shouldSelectItemAtIndex:(NSInteger)index;
- (void)segmentView:(DYSegmentView *)segmentView didSelectItemAtIndex:(NSInteger)index;
@end
```



#### 3. 视频播放

播放使用`AVPlayer` 和`AVPlayerLayer `

```objc
    // 初始化
		self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
  	self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.layer addSublayer:self.playerLayer];
```

```objc
 	 // 切换视频
 	 AVPlayerItem *item = [AVPlayerItem playerItemWithURL:data.videoUrl];
   [self.player replaceCurrentItemWithPlayerItem:item];
```



#### 4. 红心动画

动画过程：尺寸从大到小->弹性动画->禁止->尺寸从小到大+逐渐透明

动画很多，本来打算使用`keyframeAnimation+AnimationGroup` ，但是弹性动画不是很好弄，后面决定还是采用`UIView`的两段动画完成，最后完成的动画效果还原度还行。代码如下：

```objc
/// 显示红心
- (void)showRedStar:(CGPoint)center animationCompletion:(dispatch_block_t)completion {
   UIImageView * redStarView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ic_home_like_after"]];
    redStarView.layer.anchorPoint = CGPointMake(0.5, 1);
    redStarView.frame = CGRectMake(0, 0, 100, 100);
    redStarView.center = center;
    [self addSubview:redStarView];
    
    int radom1 = arc4random()%20;
    double rotate = radom1/100.0;
    if (arc4random()%2  == 0) {
        rotate = -rotate;
    }
    NSLog(@"rotate:%f",rotate);
    CGAffineTransform transform1 = CGAffineTransformMakeScale(2, 2);
    transform1 = CGAffineTransformRotate(transform1,-M_PI*rotate);
    
    CGAffineTransform transform2 = CGAffineTransformMakeScale(1, 1);
    transform2 = CGAffineTransformRotate(transform2,-M_PI*rotate);
    
    CGAffineTransform transform3 = CGAffineTransformMakeScale(3, 3);
    transform3 = CGAffineTransformRotate(transform3,-M_PI*rotate);
    
    redStarView.transform = transform1;
    redStarView.alpha = 0;
    [UIView animateWithDuration:0.2 delay:0.0 usingSpringWithDamping:0.7 initialSpringVelocity:20 options:0 animations:^{
        redStarView.transform = transform2;
        redStarView.alpha = 1;
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:0.7 delay:0.3 options:UIViewAnimationOptionCurveLinear animations:^{
                redStarView.alpha = 0;
                               redStarView.transform = transform3;
            } completion:^(BOOL finished) {
                if (finished) {
                    [redStarView removeFromSuperview];
                    if (completion) {
                        completion();
                    }
                }
            }];
        }
    }];
}
```

当前实现效果图如下：

