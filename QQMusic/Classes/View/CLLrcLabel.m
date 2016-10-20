//
//  CLlrcLabel.m
//  QQMusic
//
//  Created by 杨博兴 on 16/10/20.
//  Copyright © 2016年 xx_cc. All rights reserved.
//

#import "CLlrcLabel.h"

@implementation CLLrcLabel


- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    
    [[UIColor greenColor] set];
    CGRect fillRect = CGRectMake(0, 0, self.bounds.size.width * self.progress, self.bounds.size.height);
    
    UIRectFillUsingBlendMode(fillRect, kCGBlendModeSourceIn);
}

@end
