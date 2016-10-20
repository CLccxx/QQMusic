//
//  CLAVdioTool.h
//  QQMusic
//
//  Created by 杨博兴 on 16/10/19.
//  Copyright © 2016年 xx_cc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface CLAVdioTool : NSObject


+(AVAudioPlayer *)playingMusicWithMusicFileName:(NSString *)filename;

+(void)pauseMusicWithMusicFileName:(NSString *)filename;

+(void)stopMusicWithMusicFileName:(NSString *)filename;

@end
