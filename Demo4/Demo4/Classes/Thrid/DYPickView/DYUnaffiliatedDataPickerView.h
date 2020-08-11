//
//  DYUnaffiliatedDataPickerView.h
//  DYPickerViewDemo
//
//  Created by hehaichi on 2020/7/31.
//  Copyright © 2020 hehaichi. All rights reserved.
//
//  

#import "DYBaseView.h"

typedef void(^DYStringResultBlock)(id selectValue);

@interface DYUnaffiliatedDataPickerView : DYBaseView

/**
 *  显示自定义字符串选择器
 *
 *  @param title            标题
 *  @param dataSource       数组数据源
 *  @param primaryKey       数据源的dictionary中哪个字段用于显示
 *  @param defaultSelValue  默认选中的行(单列传字符串，多列传一维数组)
 *  @param isAutoSelect     是否自动选择，即选择完(滚动完)执行结果回调，传选择的结果值
 *  @param resultBlock      选择后的回调
 *
 */
+ (void)showPickerWithTitle:(NSString *)title
                       dataSource:(NSArray *)dataSource
                      primaryKey:(NSString *)primaryKey
                  defaultSelValue:(id)defaultSelValue
                     isAutoSelect:(BOOL)isAutoSelect
                      resultBlock:(DYStringResultBlock)resultBlock;

@end
