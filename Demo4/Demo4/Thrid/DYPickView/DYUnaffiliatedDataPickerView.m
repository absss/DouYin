//
//  DYUnaffiliatedDataPickerView.m
//  DYPickerViewDemo
//
//  Created by hehaichi on 2020/7/31.
//  Copyright © 2020 hehaichi. All rights reserved.
//
//

#import "DYUnaffiliatedDataPickerView.h"

@interface DYUnaffiliatedDataPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
// 字符串选择器(默认大小: 320px × 216px)
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, assign) BOOL isDataSourceValid;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *primaryKey;
@property (nonatomic, strong) NSArray  *dataSource;
// 是否开启自动选择
@property (nonatomic, assign) BOOL isAutoSelect;
@property (nonatomic, copy) DYStringResultBlock resultBlock;
// 多列选中的项
@property (nonatomic, strong) NSMutableArray *selectedItems;

@end

@implementation DYUnaffiliatedDataPickerView

#pragma mark - 显示自定义字符串选择器
+ (void) showPickerWithTitle:(NSString *)title
                       dataSource:(NSArray *)dataSource
                          primaryKey:(NSString *)primaryKey
                  defaultSelValue:(id)defaultSelValue
                     isAutoSelect:(BOOL)isAutoSelect
                      resultBlock:(DYStringResultBlock)resultBlock{
    if (dataSource == nil || dataSource.count == 0) {
        return;
    }
    DYUnaffiliatedDataPickerView *strPickerView = [[DYUnaffiliatedDataPickerView alloc]initWithTitle:title dataSource:dataSource primaryKey:primaryKey defaultSelValue:defaultSelValue isAutoSelect:isAutoSelect resultBlock:resultBlock];
    [strPickerView showWithAnimation:YES];
}

#pragma mark - 初始化自定义字符串选择器
- (instancetype)initWithTitle:(NSString *)title
                   dataSource:(NSArray *)dataSource
                      primaryKey:(NSString *)primaryKey
              defaultSelValue:(id)defaultSelValue
                 isAutoSelect:(BOOL)isAutoSelect
                  resultBlock:(DYStringResultBlock)resultBlock {
    if (self = [super init]) {
        self.title = title;
        self.dataSource = dataSource;
        self.isAutoSelect = isAutoSelect;
        self.resultBlock = resultBlock;
        self.primaryKey = primaryKey;
        
        if (defaultSelValue) {
            self.selectedItems = [defaultSelValue mutableCopy];
        }
        
        [self loadData];
        [self initUI];
    }
    return self;
}

#pragma mark - 初始化子视图
- (void)initUI {
    [super initUI];
    self.titleLabel.text = self.title;
    // 添加字符串选择器
    [self.alertView addSubview:self.pickerView];
}

#pragma mark - 加载自定义字符串数据
- (void)loadData {
    if (self.dataSource == nil || self.dataSource.count == 0) {
        self.isDataSourceValid = NO;
        return;
    } else {
        self.isDataSourceValid = YES;
    }
    
    __weak typeof(self) weakSelf = self;
    // 遍历数组元素 (遍历多维数组一般用这个方法)
    [self.dataSource enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        static Class itemType;
        if (idx == 0) {
         
        } else {
            // 判断数组的元素类型是否相同
            if (itemType != [obj class]) {
                weakSelf.isDataSourceValid = NO; // 数组不合法
                *stop = YES;
                return;
            }
            
            if ([obj isKindOfClass:[NSArray class]]) {
                if (((NSArray *)obj).count == 0) {
                    weakSelf.isDataSourceValid = NO;
                    *stop = YES;
                    return;
                } else {
                    for (id subObj in obj) {
                        if (![subObj isKindOfClass:[NSDictionary class]] || ![subObj objectForKey:self.primaryKey]) {
                            weakSelf.isDataSourceValid = NO;
                            *stop = YES;
                            return;
                        }
                    }
                }
            }
        }
    }];
    
    BOOL isSelectedItemsValid = YES;
    for (id obj in self.selectedItems) {
        if (![obj isKindOfClass:[NSDictionary class]] || ![obj objectForKey:self.primaryKey]) {
            isSelectedItemsValid = NO;
            break;
        }
    }
    
    if (self.selectedItems == nil || self.selectedItems.count != self.dataSource.count || !isSelectedItemsValid) {
        NSMutableArray *mutableArray = [NSMutableArray array];
        for (NSArray* componentItem in _dataSource) {
            [mutableArray addObject:componentItem.firstObject];
        }
        self.selectedItems = [NSMutableArray arrayWithArray:mutableArray];
    }
    
}

#pragma mark - 背景视图的点击事件
- (void)didTapBackgroundView:(UITapGestureRecognizer *)sender {
    [self dismissWithAnimation:NO];
}

#pragma mark - 弹出视图方法
- (void)showWithAnimation:(BOOL)animation {
    //1. 获取当前应用的主窗口
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow addSubview:self];
    if (animation) {
        // 动画前初始位置
        CGRect rect = self.alertView.frame;
        rect.origin.y = SCREEN_HEIGHT;
        self.alertView.frame = rect;
        
        // 浮现动画
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect = self.alertView.frame;
            rect.origin.y -= kDatePicHeight + kTopViewHeight;
            self.alertView.frame = rect;
        }];
    }
}

#pragma mark - 关闭视图方法
- (void)dismissWithAnimation:(BOOL)animation {
    // 关闭动画
    [UIView animateWithDuration:0.2 animations:^{
        CGRect rect = self.alertView.frame;
        rect.origin.y += kDatePicHeight + kTopViewHeight;
        self.alertView.frame = rect;
        
        self.backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.leftBtn removeFromSuperview];
        [self.rightBtn removeFromSuperview];
        [self.titleLabel removeFromSuperview];
        [self.lineView removeFromSuperview];
        [self.topView removeFromSuperview];
        [self.pickerView removeFromSuperview];
        [self.alertView removeFromSuperview];
        [self.backgroundView removeFromSuperview];
        [self removeFromSuperview];
        
        self.leftBtn = nil;
        self.rightBtn = nil;
        self.titleLabel = nil;
        self.lineView = nil;
        self.topView = nil;
        self.pickerView = nil;
        self.alertView = nil;
        self.backgroundView = nil;
    }];
}

#pragma mark - 取消按钮的点击事件
- (void)clickLeftBtn {
    [self dismissWithAnimation:YES];
}

#pragma mark - 确定按钮的点击事件
- (void)clickRightBtn {
    NSLog(@"点击确定按钮后，执行block回调");
    [self dismissWithAnimation:YES];
    _resultBlock([self.selectedItems copy]);
}

#pragma mark - 字符串选择器
- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, kTopViewHeight + 0.5, SCREEN_WIDTH, kDatePicHeight)];
        _pickerView.backgroundColor = [UIColor whiteColor];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        
        __weak typeof(self) weakSelf = self;
        [self.selectedItems enumerateObjectsUsingBlock:^(NSDictionary *selectedItem, NSUInteger component, BOOL *stop) {
            [_dataSource[component] enumerateObjectsUsingBlock:^(NSDictionary * rowItem, NSUInteger rowIdx, BOOL *stop) {
                NSString *v1 = [weakSelf.selectedItems.firstObject objectForKey:self.primaryKey];
                NSString *v2 = [rowItem objectForKey:self.primaryKey];
                if ([v1 isEqualToString:v2]) {
                    [weakSelf.pickerView selectRow:rowIdx inComponent:component animated:NO];
                    *stop = YES;
                }
            }];
        }];
        
    }
    return _pickerView;
}


#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return _dataSource.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return ((NSArray*)_dataSource[component]).count;
}

#pragma mark - UIPickerViewDelegate
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSDictionary *dic = ((NSArray*)_dataSource[component])[row];
    return [dic objectForKey:self.primaryKey];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
   self.selectedItems[component] = ((NSArray *)_dataSource[component])[row];
    // 设置是否自动回调
    if (self.isAutoSelect) {
        if(_resultBlock) {
            _resultBlock([self.selectedItems copy]);
        }
    }
}

@end
