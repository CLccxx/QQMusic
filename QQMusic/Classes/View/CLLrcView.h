//
//  CLLrcView.h
//  QQMusic
//
//  Created by 杨博兴 on 16/10/19.
//  Copyright © 2016年 xx_cc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLLrcLabel;

@interface CLLrcView : UIScrollView

/** 歌词文件名字 */
@property(nonatomic,strong)NSString *lrcName;

/** 歌词的Label */
@property (nonatomic, weak) CLLrcLabel *lrcLabel;

/** 当前播放的时间 */
@property (nonatomic,assign) NSTimeInterval currentTime;

/** 当前音乐的总时间 */
@property (nonatomic,assign) NSTimeInterval duration;

@end
