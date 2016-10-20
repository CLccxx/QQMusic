//
//  CLLrcTableViewCell.h
//  QQMusic
//
//  Created by 杨博兴 on 16/10/19.
//  Copyright © 2016年 xx_cc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLLrcLabel;
@interface CLLrcTableViewCell : UITableViewCell

/** 歌词的Label */
@property (nonatomic, weak) CLLrcLabel *lrcLabel;
+(CLLrcTableViewCell *)lrcCellWithTableView:(UITableView *)tableView;

@end
