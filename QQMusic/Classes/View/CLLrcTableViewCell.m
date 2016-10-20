//
//  CLLrcTableViewCell.m
//  QQMusic
//
//  Created by 杨博兴 on 16/10/19.
//  Copyright © 2016年 xx_cc. All rights reserved.
//

#import "CLLrcTableViewCell.h"
#import "CLLrcLabel.h"

@implementation CLLrcTableViewCell

+(CLLrcTableViewCell *)lrcCellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    CLLrcTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[CLLrcTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
    
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //创建cell label
        CLLrcLabel *lrcLabel = [[CLLrcLabel alloc]init];
        lrcLabel.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.contentView.frame.size.height);
        lrcLabel.textColor = [UIColor whiteColor];
        lrcLabel.textAlignment = NSTextAlignmentCenter;
        lrcLabel.font = [UIFont systemFontOfSize:14];
        self.lrcLabel = lrcLabel;
        [self.contentView addSubview:lrcLabel];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

@end
