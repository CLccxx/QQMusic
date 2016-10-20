//
//  CLLrcView.m
//  QQMusic
//
//  Created by 杨博兴 on 16/10/19.
//  Copyright © 2016年 xx_cc. All rights reserved.
//

#import "CLLrcView.h"
#import "CLLrcTableViewCell.h"
#import "CLLrcTool.h"
#import "CLLrcLine.h"
#import "CLLrcLabel.h"

@interface CLLrcView ()<UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

/** 歌词数组 */
@property(nonatomic,strong)NSArray *lrcList;

/** 当前歌词的下标 */
@property (nonatomic,assign) NSInteger currentIndex;

@end

@implementation CLLrcView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
        // 初始化TableView
        [self setupTableView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 初始化TableView
        [self setupTableView];
    }
    return self;
}

#pragma mark - 初始化TableView
- (void)setupTableView
{
    // 1.初始化
    UITableView *tableView = [[UITableView alloc] init];
    [self addSubview:tableView];
    self.tableView = tableView;
    tableView.dataSource = self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.tableView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width, 0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 100 -150);
    
    // 2.改变tableView属性
    self.tableView.backgroundColor = [UIColor clearColor];
    // 去掉cell之间的线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 40;
    self.tableView.contentInset = UIEdgeInsetsMake(self.tableView.bounds.size.height * 0.5, 0, self.tableView.bounds.size.height * 0.5, 0);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.lrcList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CLLrcTableViewCell *cell = [CLLrcTableViewCell lrcCellWithTableView:tableView];
    
    if (self.currentIndex == indexPath.row) {
        cell.lrcLabel.font = [UIFont systemFontOfSize:20];
    } else {
        cell.lrcLabel.font = [UIFont systemFontOfSize:14];
        cell.lrcLabel.progress = 0;
    }
    
    // 获得当前播放的歌曲歌词模型
    CLLrcLine *lrcline = self.lrcList[indexPath.row];
    
    cell.lrcLabel.text = lrcline.text;
    
    return cell;
}


-(void)setLrcName:(NSString *)lrcName
{
    // 0.更新行数
    self.currentIndex = 0;
    
    // 1. 记录歌词名
    _lrcName = lrcName;
    // 解析歌词 使用自己创建歌词解析工具
    self.lrcList = [CLLrcTool lrcToolWithLrcName:lrcName];
    
    CLLrcLine *lrcLine = self.lrcList[0];
    self.lrcLabel.text = lrcLine.text;
    
    // 刷新表格
    [self.tableView reloadData];
}

#pragma mark - 当前播放时间
- (void)setCurrentTime:(NSTimeInterval)currentTime
{
    // 记录当前时间
    _currentTime = currentTime;
    // 获取歌词行数
    NSInteger count = self.lrcList.count;
    for (int i = 0; i < count; i ++) {
        // 获取i位置的歌词
        CLLrcLine *currentLrcLine = self.lrcList[i];
        // 获取下一句歌词
        NSInteger nextIndex = i + 1;
        // 先创建空的歌词模型
        CLLrcLine *nextLrcLine = nil;
        // 判断歌词是否存在
        if (nextIndex < self.lrcList.count) {
            // 说明存在
            nextLrcLine = self.lrcList[nextIndex];
        }
        // 用播放器的当前的时间和i位置歌词、i+1位置歌词的时间进行比较，如果大于等于i位置的时间并且小于等于i+1歌词的时间，说明应该显示i位置的歌词。
        // 并且如果正在显示的就是这行歌词则不用重复判断
        if (self.currentIndex != i && currentTime >= currentLrcLine.time && currentTime < nextLrcLine.time) {
            
            // 2.8设置主页上的歌词
            self.lrcLabel.text = currentLrcLine.text;
            
            // 将当前播放的歌词移动到中间
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            
            [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
            
            // 记录上一句位置，当移动到下一句时，上一句和当前这一句都需要进行更新行
            NSIndexPath *previousPath = [NSIndexPath indexPathForRow:self.currentIndex inSection:0];
            // 记录当前播放的下标。下次来到这里，currentIndex指的就是上一句
            self.currentIndex = i;
            
            [self.tableView reloadRowsAtIndexPaths:@[indexPath,previousPath] withRowAnimation:UITableViewRowAnimationNone];
        }
        if (self.currentIndex == i) {
            // 获取播放速度 已经播放的时间 / 播放整句需要的时间
            CGFloat progress = (currentTime - currentLrcLine.time) / (nextLrcLine.time - currentLrcLine.time);
            // 获取当前行数的cell
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            CLLrcTableViewCell *lrccell = [self.tableView cellForRowAtIndexPath:indexPath];
            lrccell.lrcLabel.progress = progress;
            self.lrcLabel.progress = progress;
        }
    }
}


@end
