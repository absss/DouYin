//
//  DYTabBar.m
//  DouYin
//
//  Created by hehaichi on 2020/7/31.
//  Copyright © 2020 hehaichi. All rights reserved.
//

#import "DYTabBar.h"

@interface DYTabBar()
@property (nonatomic, assign)int selecdedIdx;
@end


@implementation DYTabBar
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setTitles:(NSArray *)titles {
    _titles = titles;
    [self setupSubViews];
}
- (void)setupSubViews {
    int i = 0;
    for (NSString *title in self.titles) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        if (_selecdedIdx == i) {
            btn.selected = YES;
        }
        CGFloat width = CGRectGetWidth(self.frame)/_titles.count;
        CGFloat height = CGRectGetHeight(self.frame);
        btn.frame = CGRectMake(width*i, 0, width, height);
        NSMutableAttributedString * normalStr = [[NSMutableAttributedString alloc]initWithString:title];
        [normalStr addAttributes:@{NSForegroundColorAttributeName:DYColor.whiteColor1,NSFontAttributeName:[DYFont systemFontOfSize:16]} range:NSMakeRange(0, title.length)];
        NSMutableAttributedString * selectedStr = [[NSMutableAttributedString alloc]initWithString:title];
        [selectedStr addAttributes:@{NSForegroundColorAttributeName:DYColor.whiteColor0,NSFontAttributeName:[DYFont systemFontOfSize:18]} range:NSMakeRange(0, title.length)];
        [btn setAttributedTitle:normalStr forState:UIControlStateNormal];
        [btn setAttributedTitle:selectedStr forState:UIControlStateSelected];
        btn.tag = 100+i;
        [btn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        i++;
    }
    
}

- (void)clickAction:(UIButton *)sender {
    UIButton *preSelectedBtn =  [self viewWithTag:self.selecdedIdx+100];
    preSelectedBtn.selected = NO;
    sender.selected = YES;
    self.selecdedIdx = (int)(sender.tag - 100);
    if (self.selectedBlock) {
        self.selectedBlock(sender.tag - 100);
    }
}
@end
