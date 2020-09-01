//
//  DYAddressPickerView.h
//  DYPickerViewDemo
//
//  Created by hehaichi on 2020/7/31.
//  Copyright © 2020 hehaichi. All rights reserved.
//
//  

#import "DYBaseView.h"
#import "DYAddressModel.h"

typedef void(^DYAddressResultBlock)(NSArray *selectAddressArr);

@interface DYAddressPickerView : DYBaseView
/**
 *  显示地址选择器
 *
 *  @param defaultSelectedArr       默认选中的值(传数组，元素为对应的索引值。如：@[@10, @1, @1])
 *  @param isAutoSelect             是否自动选择，即选择完(滚动完)执行结果回调，传选择的结果值
 *  @param resultBlock              选择后的回调
 *
 */
+ (void)showAddressPickerWithDefaultSelected:(NSArray *)defaultSelectedArr isAutoSelect:(BOOL)isAutoSelect resultBlock:(DYAddressResultBlock)resultBlock;

@end
