

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



