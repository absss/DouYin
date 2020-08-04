//
//  DYAddressModel.m
//  DYPickerViewDemo
//
//  Created by hehaichi on 2020/7/31.
//  Copyright © 2020 hehaichi. All rights reserved.
//

#import "DYAddressModel.h"

@implementation DYProvinceModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"name": @"name",
             @"city": @"children",
             @"code": @"code",
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"city": [DYCityModel class]
             };
}

@end


@implementation DYCityModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"name": @"name",
             @"code": @"code",
             @"town": @"grandChildren"
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"town": [DYTownModel class]
             };
}

@end


@implementation DYTownModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"name": @"name",
             @"code": @"code"
             };
}

@end
