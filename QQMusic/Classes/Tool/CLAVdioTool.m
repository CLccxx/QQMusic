//
//  CLAVdioTool.m
//  QQMusic
//
//  Created by 杨博兴 on 16/10/19.
//  Copyright © 2016年 xx_cc. All rights reserved.
//

#import "CLAVdioTool.h"
#import <AVFoundation/AVFoundation.h>

@implementation CLAVdioTool

static NSMutableDictionary *_players;

+(void)initialize
{
    _players = [NSMutableDictionary dictionary];
}
+(AVAudioPlayer *)playingMusicWithMusicFileName:(NSString *)filename
{
    AVAudioPlayer *player = nil;
    player = _players[filename];
    if (player == nil) {
        // 文件路径转化为url
        NSURL *url = [[NSBundle mainBundle]URLForResource:filename withExtension:nil];
        if (url == nil) {
            return nil;
        }
        // 创建player
        player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
        // 准备播放
        [player prepareToPlay];
        // 将播放器存储到字典中
        [_players setObject:player forKey:filename];
    }
    // 开始播放
    [player play];
    return player;
}

+(void)pauseMusicWithMusicFileName:(NSString *)filename
{
    AVAudioPlayer *player = _players[filename];
    if (player) {
        [player pause];
    }
}

+(void)stopMusicWithMusicFileName:(NSString *)filename
{
    AVAudioPlayer *player = _players[filename];
    if (player) {
        [player stop];
        [_players removeObjectForKey:filename];
        player = nil;
    }
}

@end
