//
//  DYAddressModel.h
//  DYPickerViewDemo
//
//  Created by hehaichi on 2020/7/31.
//  Copyright © 2020 hehaichi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class DYProvinceModel, DYCityModel, DYTownModel;

@interface DYProvinceModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, strong) NSArray *city;
@property(class, nonatomic, readonly) UIColor *blackColor;      // 0.0 white

@end

@interface DYCityModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, strong) NSArray *town;

@end


@interface DYTownModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *code;

@end
