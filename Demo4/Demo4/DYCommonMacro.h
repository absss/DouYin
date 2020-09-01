//
//  CommonMacro.h
//  DouYin
//
//  Created by hehaichi on 2020/7/31.
//  Copyright © 2020 hehaichi. All rights reserved.
//

#ifndef CommonMacro_h
#define CommonMacro_h

#define DYAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define DYSystemVersion [[[UIDevice currentDevice] systemVersion] floatValue]
#define DYScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define DYScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define DYViewControllerWidth CGRectGetWidth(self.view.frame)
#define DYViewControllerHeight CGRectGetHeight(self.view.frame)

#define DYStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
#define DYNonEmptyString(str) (DYStringIsEmpty(str) ? @"" : str)


#define DYIPhoneX \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

#define DYContentMinY (DYIPhoneX ? 88 : 64)

#define DYHexRGBColor(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define DYHexRGBColor2(rgbValue,Alpha) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:Alpha]


#define DYDocmentPath  NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject
#define DYResourcePathOfMainBudle(resName) [[NSBundle mainBundle] pathForResource:resName ofType:nil]


#define DYWeakSelf  __weak typeof(self) weakSelf = self;
#define DYStrongSelf __strong typeof(weakSelf) strongSelf = weakSelf;
// view getter
#define UIViewGetter(NAME,BACKGROUNDCOLOR) \
- (UIView *)NAME {\
if (!_##NAME) {\
_##NAME = [UIView new];\
_##NAME.backgroundColor = BACKGROUNDCOLOR;\
}\
return _##NAME;\
}

#define CustomClassGetter(NAME,CLASS) \
- (CLASS *)NAME {\
if (!_##NAME) {\
_##NAME = [CLASS new];\
}\
return _##NAME;\
}


#define CustomClassGetter2(NAME,CLASS,PROKEY,PROVALUE) \
- (CLASS *)NAME {\
if (!_##NAME) {\
_##NAME = [CLASS new];\
_##NAME.PROKEY = PROVALUE;\
}\
return _##NAME;\
}

#define UIImageViewGetter(NAME,IMAGENAME) \
- (UIImageView *)NAME {\
if (!_##NAME) {\
_##NAME = [UIImageView new];\
_##NAME.contentMode = UIViewContentModeScaleAspectFill;\
_##NAME.image = [UIImage imageNamed:IMAGENAME];\
}\
return _##NAME;\
}

#define UILabelGetter(NAME,TEXT_COLOR,FONT,TEXT,TEXT_ALIGN,NUMBER_OF_LINE) \
- (UILabel *)NAME {\
if (!_##NAME) {\
_##NAME = [[UILabel alloc]init];\
_##NAME.textColor = TEXT_COLOR;\
_##NAME.textAlignment = TEXT_ALIGN;\
_##NAME.numberOfLines = NUMBER_OF_LINE;\
_##NAME.font = FONT;\
_##NAME.text = TEXT;\
}\
return _##NAME;\
}

#define UIButtonGetter(NAME,TITLE,TITLE_COLOR,TITLE_FONT) \
- (UIButton *)NAME {\
if (!_##NAME) {\
_##NAME = [UIButton buttonWithType:UIButtonTypeCustom];\
[_##NAME setTitle:TITLE forState:UIControlStateNormal];\
[_##NAME setTitleColor:TITLE_COLOR forState:UIControlStateNormal];\
_##NAME.titleLabel.font = TITLE_FONT;\
}\
return _##NAME;\
}

#endif /* CommonMacro_h */
