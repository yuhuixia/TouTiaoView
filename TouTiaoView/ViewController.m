//
//  ViewController.m
//  TouTiaoView
//
//  Created by 于慧霞 on 16/7/3.
//  Copyright © 2016年 yuhuixia. All rights reserved.
//

#import "ViewController.h"
#import "VerticalView.h"
// 加上这两个宏 一定要加在导入Masonry.h 的前面
//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND
//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS

#import "Masonry/Masonry.h"

@interface ViewController ()<VerticalViewDelegate>


@property (nonatomic, strong) VerticalView *verticalView;
@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.verticalView) {
        [self.verticalView startRow];
    }
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    self.verticalView = [[VerticalView alloc] initWithFrame: CGRectMake(0, 100, self.view.frame.size.width, 44) itemsNumber:12 delegate:self image:[UIImage imageNamed:@"581"]];
    [self.verticalView startRow];
    [self.view addSubview:self.verticalView];
    
//    [self.verticalView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(100);
//        make.left.and.right.mas_equalTo(self.view);
//        make.height.mas_equalTo(30);
//    }];
    
   
}

- (UITableViewCell *)verticalView:(VerticalView *)verticalView tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"cell"];
    }
//    cell.contentView.backgroundColor = [UIColor redColor];
     cell.imageView.image = [UIImage imageNamed:@"喇叭"];
     cell.textLabel.text =[NSString stringWithFormat:@"这是%ld条",(long)indexPath.row];
     cell.textLabel.font = [UIFont systemFontOfSize:10];

     cell.textLabel.numberOfLines = 3;
    return cell;
}

- (void)vertialView:(VerticalView *)vertialView tableView:(UITableView *)tableView selectedRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld", (long)indexPath.row);
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
