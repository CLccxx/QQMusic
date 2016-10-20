//
//  CLLrcTool.m
//  QQMusic
//
//  Created by 杨博兴 on 16/10/19.
//  Copyright © 2016年 xx_cc. All rights reserved.
//

#import "CLLrcTool.h"
#import "CLLrcLine.h"
@implementation CLLrcTool

+(NSArray *)lrcToolWithLrcName:(NSString *)lrcName
{
    // 1. 获取路径
    NSString *lrcFilePath = [[NSBundle mainBundle]pathForResource:lrcName ofType:nil];
    
    // 2. 获取歌词
    NSString *lrcString = [NSString stringWithContentsOfFile:lrcFilePath encoding:NSUTF8StringEncoding error:nil];
    
    // 将歌词转化为数组 ，会以每个\n为分隔符 转化为数组中的每个元素
    NSArray *lrcArr = [lrcString componentsSeparatedByString:@"\n"];
    
    NSMutableArray *tempArr = [NSMutableArray array];
    
    for (NSString *lrcLineString in lrcArr) {
        
        // 过滤掉不要的字符串，如果是以这些开头 或者不是以[开头的直接退出循环
        if ([lrcLineString hasPrefix:@"[ti:"] ||
            [lrcLineString hasPrefix:@"[ar:"] ||
            [lrcLineString hasPrefix:@"[al:"] ||
            ![lrcLineString hasPrefix:@"["]) {
            continue;
        }
        // 将字符串转化为模型
        CLLrcLine *lrcLine = [CLLrcLine LrcLineString:lrcLineString];
        [tempArr addObject:lrcLine];
    }
    
    return tempArr;
}

@end
