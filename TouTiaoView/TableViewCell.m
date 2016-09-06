//
//  TableViewCell.m
//  TouTiaoView
//
//  Created by 于慧霞 on 16/7/4.
//  Copyright © 2016年 yuhuixia. All rights reserved.
//

#import "TableViewCell.h"

@interface TableViewCell ()
// icon
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
// 内容
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
@implementation TableViewCell

/** xib加载 cell*/
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *identifier = @"cell";
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}
//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    
//}
- (void)awakeFromNib {
    [super awakeFromNib];
//    [self layoutIfNeeded];
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
