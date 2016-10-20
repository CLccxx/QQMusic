//
//  CLMusicTool.h
//  QQMusic
//
//  Created by 杨博兴 on 16/10/19.
//  Copyright © 2016年 xx_cc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CLMusicModel;
@interface CLMusicTool : NSObject

// 获取所有音乐
+(NSArray *)Musics;

// 当前正在播放的音乐
+(CLMusicModel *)playingMusic;

// 设置默认播放的音乐
+(void)setUpPlayingMusic:(CLMusicModel *)playingMusic;

// 返回上一首音乐
+ (CLMusicModel *)previousMusic;

// 返回下一首音乐
+ (CLMusicModel *)nextMusic;


@end
