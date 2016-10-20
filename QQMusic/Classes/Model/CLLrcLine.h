//
//  CLLrcLine.h
//  QQMusic
//
//  Created by 杨博兴 on 16/10/19.
//  Copyright © 2016年 xx_cc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLLrcLine : NSObject

@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign) NSTimeInterval time;

- (instancetype)initWithLrcLineString:(NSString *)lrcLineString;
+ (instancetype)LrcLineString:(NSString *)lrcLineString;


@end
