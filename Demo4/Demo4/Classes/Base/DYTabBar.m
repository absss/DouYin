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

- (void)reloadData {
    [self removeAllSubViews];
    NSInteger count = [self.delegate numberOfItemsWithTabbar:self];
    for (int i = 0;i < count; i++) {
        id item = [self.delegate tabbar:self itemForColumnAtIndex:i];
        if ([item isKindOfClass:[NSString class]]) {
            NSString *title = (NSString *)item;
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self addSubview:btn];
            if (_selecdedIdx == i) {
                btn.selected = YES;
            }
            CGFloat width = CGRectGetWidth(self.frame)/count;
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
        } else {
            UIButton * btn = (UIButton *)item;
            btn.userInteractionEnabled = YES;
            [self addSubview:btn];
            if (_selecdedIdx == i) {
                btn.selected = YES;
            }
            CGFloat width = CGRectGetWidth(self.frame)/count;
            CGFloat height = CGRectGetHeight(self.frame);
            btn.frame = CGRectMake(width*i, 0, width, height);
            btn.tag = 100+i;
            [btn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];

        }
    }
    
}

- (void)clickAction:(UIButton *)sender {
    
    BOOL shouldSelect = YES;
    if ([self.delegate respondsToSelector:@selector(tabbar:shouldSelectItemAtIndex:)]) {
        shouldSelect = [self.delegate tabbar:self shouldSelectItemAtIndex:sender.tag - 100];
    }
    if (shouldSelect) {
        UIButton *preSelectedBtn =  [self viewWithTag:self.selecdedIdx+100];
        preSelectedBtn.selected = NO;
        sender.selected = YES;
        self.selecdedIdx = (int)(sender.tag - 100);
        if ([self.delegate respondsToSelector:@selector(tabbar:didSelectItemAtIndex:)]) {
            [self.delegate tabbar:self didSelectItemAtIndex:sender.tag - 100];
        }
    }
    
}
@end
