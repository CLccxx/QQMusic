//
//  CLPlayingViewController.m
//  QQMusic
//
//  Created by 杨博兴 on 16/10/19.
//  Copyright © 2016年 xx_cc. All rights reserved.
//

#import "CLPlayingViewController.h"
#import "CLMusicModel.h"
#import "CLMusicTool.h"
#import "CLAVdioTool.h"
#import "NSString+Extension.h"
#import "CALayer+PauseAimate.h"
#import "CLLrcView.h"
#import "CLlrcLabel.h"
#import <AVFoundation/AVFoundation.h>


#define CLColor(r,g,b,a)[UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
@interface CLPlayingViewController ()<UIScrollViewDelegate>

/** 歌手背景图片 */
@property (weak, nonatomic) IBOutlet UIImageView *albumView;
/** 进度条 */
@property (weak, nonatomic) IBOutlet UISlider *progressSlider;
/** 歌手图片 */
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

/** 歌曲名 */
@property (weak, nonatomic) IBOutlet UILabel *songLabel;
/** 歌手名 */
@property (weak, nonatomic) IBOutlet UILabel *singerLabel;
/** 当前播放时间 */
@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;
/** 歌曲的总时间 */
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;

/** 进度条时间 */
@property (nonatomic, strong) NSTimer *progressTimer;

/** 播放器 */
@property (nonatomic, strong) AVAudioPlayer *currentPlayer;

@property (weak, nonatomic) IBOutlet UIButton *playWithPauseBtn;
@property (weak, nonatomic) IBOutlet CLLrcView *lrcScrollView;
@property (weak, nonatomic) IBOutlet CLLrcLabel *lrcLabel;

/** 歌词的定时器 */
@property (nonatomic,strong) CADisplayLink *lrcTiemr;

@end

@implementation CLPlayingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.添加毛玻璃效果
//    [self setupBlur];
    
    // 2.改变滑块的图片
    [self.progressSlider setThumbImage:[UIImage imageNamed:@"player_slider_playback_thumb"] forState:UIControlStateNormal];

    // 5.记录歌词label属性
    self.lrcScrollView.lrcLabel = self.lrcLabel;
    
    // 开始播放音乐
    [self startPlayingMusic];
    
    self.lrcScrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 2, 0);
    

    
}

#pragma mark 播放音乐
-(void)startPlayingMusic
{
    // 获取当前正在播放的音乐
    CLMusicModel *playingMusic = [CLMusicTool playingMusic];
    
    // 设置界面信息
    self.albumView.image = [UIImage imageNamed:playingMusic.icon];
    self.iconView.image = [UIImage imageNamed:playingMusic.icon];
    self.songLabel.text = playingMusic.name;
    self.singerLabel.text = playingMusic.singer;
 
    
    // 播放音乐并且获取播放的音乐
    AVAudioPlayer *currentPlayer = [CLAVdioTool playingMusicWithMusicFileName:playingMusic.filename];
    self.currentTimeLabel.text = [NSString stringWithTime:currentPlayer.currentTime];
    self.totalTimeLabel.text = [NSString stringWithTime:currentPlayer.duration];
    self.currentPlayer = currentPlayer;
    

    self.playWithPauseBtn.selected = currentPlayer.isPlaying;
    // 获取歌词名字
    self.lrcScrollView.lrcName = playingMusic.lrcname;
    // 获取歌曲时间
    self.lrcScrollView.duration = currentPlayer.duration;
    
    // 旋转动画
    [self addIconViewAnimate];
    
    [self removeProgressTimer];
    [self addProgressTimer];
    // 添加歌词定时器
    [self removeLrcTimer];
    [self addLrcTimer];
    
    
}


#pragma mark - 播放时间进度条的处理

-(void)addProgressTimer
{
    [self upDateProgressInfo];
    self.progressTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(upDateProgressInfo) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:self.progressTimer forMode:NSRunLoopCommonModes];
}

-(void)removeProgressTimer
{
    [self.progressTimer invalidate];
    self.progressTimer = nil;
}

-(void)upDateProgressInfo
{
    // 1.更新播放的时间
    self.currentTimeLabel.text = [NSString stringWithTime:self.currentPlayer.currentTime];
    // 2.更新滑动条
    self.progressSlider.value = self.currentPlayer.currentTime / self.currentPlayer.duration;
}

#pragma mark - 歌词定时器
- (void)addLrcTimer
{
    self.lrcTiemr = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateLrcInfo)];
    [self.lrcTiemr addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)removeLrcTimer
{
    [self.lrcTiemr invalidate];
    self.lrcTiemr = nil;
}

#pragma mark  更新歌词
- (void)updateLrcInfo
{
    self.lrcScrollView.currentTime = self.currentPlayer.currentTime;
}


#pragma mark - 添加毛玻璃效果
//- (void)setupBlur
//{
//    // 1.初始化toolBar
//    UIToolbar *toolBar = [[UIToolbar alloc] init];
//    toolBar.frame = [UIScreen mainScreen].bounds;
//    toolBar.barStyle = UIBarStyleBlack;
//    [self.albumView addSubview:toolBar];
//
//}

#pragma mark - 添加iconView的动画
- (void)addIconViewAnimate
{
    CABasicAnimation *rotateAnimate = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotateAnimate.fromValue = @(0);
    rotateAnimate.toValue = @(M_PI * 2);
    rotateAnimate.repeatCount = NSIntegerMax;
    rotateAnimate.duration = 36;
    [self.iconView.layer addAnimation:rotateAnimate forKey:nil];
}

#pragma mark - 中间头像的布局
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    // .添加圆角
    self.iconView.layer.cornerRadius = self.iconView.bounds.size.width * 0.5;
    self.iconView.layer.masksToBounds = YES;
    self.iconView.layer.borderColor = CLColor(36, 36, 36, 1.0).CGColor;
    self.iconView.layer.borderWidth = 5;
}

#pragma mark - slider 事件处理

- (IBAction)startTouchSlider {
    [self removeProgressTimer];
}

- (IBAction)entTouchSlider {
    // 更新播放的时间
    self.currentPlayer.currentTime = self.progressSlider.value * self.currentPlayer.duration;
    [self addProgressTimer];
}

- (IBAction)progressValueChange:(id)sender {
    
    NSString *string = [NSString stringWithTime:self.progressSlider.value * self.currentPlayer.duration];
    self.currentTimeLabel.text = string;
}

- (IBAction)sliderClick:(UITapGestureRecognizer *)sender {
    
    // 获取点击到的点
    CGPoint point = [sender locationInView:sender.view];
    // 计算占全部长度的比例
    CGFloat num = point.x / self.progressSlider.frame.size.width;
    // 设置当前需要播放的时间
    self.currentPlayer.currentTime = num * self.currentPlayer.duration;
    // 更新slider
    [self upDateProgressInfo];
}

#pragma mark 底部开始上下首按钮的点击事件

- (IBAction)playWithPause:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (self.currentPlayer.playing) {
        // 1.暂停播放器
        [self.currentPlayer pause];
        // 2.移除定时器
        [self removeProgressTimer];
        // 3.暂停旋转动画
        [self.iconView.layer pauseAnimate];
    } else {
        // 1.开始播放
        [self.currentPlayer play];
        // 2.添加定时器
        [self addProgressTimer];
        // 3.恢复动画
        [self.iconView.layer resumeAnimate];
    }
}

- (IBAction)nextMusic {
    CLMusicModel *nsxtMusic = [CLMusicTool nextMusic];
    [self playMusicWithMusic:nsxtMusic];
}
- (IBAction)previousMusic {
    CLMusicModel *previousMusic = [CLMusicTool previousMusic];
    [self playMusicWithMusic:previousMusic];
}

- (void)playMusicWithMusic:(CLMusicModel *)muisc
{
    // 获取当前播放的音乐并停止
    CLMusicModel *playingMusic = [CLMusicTool playingMusic];
    [CLAVdioTool stopMusicWithMusicFileName:playingMusic.filename];
    
    // 设置下一首或者上一首为默认播放音乐
    [CLMusicTool setUpPlayingMusic:muisc];
    // 更新界面
    [self startPlayingMusic];
}
#pragma mark - scrollView代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offcetPoint = scrollView.contentOffset;
    
    CGFloat alpha = 1 - offcetPoint.x / self.view.frame.size.width;
    
    self.iconView.alpha = alpha;
    self.lrcLabel.alpha = alpha;
    
}


#pragma mark - 修改状态栏颜色
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
    
}


@end
