//
//  CLMusicTool.m
//  QQMusic
//
//  Created by 杨博兴 on 16/10/19.
//  Copyright © 2016年 xx_cc. All rights reserved.
//

#import "CLMusicTool.h"
#import "CLMusicModel.h"
#import "MJExtension.h"
@implementation CLMusicTool

static NSArray *_musics;
static CLMusicModel *_playingMusic;

// 类加载的时候初始化音乐列表和播放音乐
+(void)initialize
{
    if (_musics == nil) {
        _musics = [CLMusicModel objectArrayWithFilename:@"Musics.plist"];
    }
    if (_playingMusic == nil) {
        _playingMusic = _musics[4];
    }
}
// 获取所有音乐
+(NSArray *)Musics
{
    return _musics;
}
// 当前正在播放的音乐
+(CLMusicModel *)playingMusic
{
    return _playingMusic;
}
// 设置默认播放的音乐
+(void)setUpPlayingMusic:(CLMusicModel *)playingMusic
{
    _playingMusic = playingMusic;
}

// 返回上一首音乐
+ (CLMusicModel *)previousMusic
{
    NSInteger index = [_musics indexOfObject:_playingMusic];
    
//    index -= 1;
//    if (index < 0) {
//        index = _musics.count - 1;
//    }
//    CLMusicModel *previousMusic = _musics[index];
    
    if (index == 0) {
        index = _musics.count -1;
    }else{
        index = index -1;
    }
    CLMusicModel *previousMusic = _musics[index];
    return previousMusic;
}

// 返回下一首音乐
+ (CLMusicModel *)nextMusic
{
    NSInteger index = [_musics indexOfObject:_playingMusic];
    if (index == _musics.count - 1) {
        index = 0;
    }else{
        index = index +1;
    }
    CLMusicModel *previousMusic = _musics[index];
    return previousMusic;
}


@end
