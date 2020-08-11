//
//  DYFont.h
//  DouYin
//
//  Created by hehaichi on 2020/7/31.
//  Copyright © 2020 hehaichi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYFont : UIFont
/// 重写该方法希望能根据设备来适当增大或减小字体
+ (UIFont *)systemFontOfSize:(CGFloat)fontSize;
@end


