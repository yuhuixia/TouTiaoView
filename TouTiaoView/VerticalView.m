//
//  VerticalView.m
//  TouTiaoView
//
//  Created by 于慧霞 on 16/7/3.
//  Copyright © 2016年 yuhuixia. All rights reserved.
//

#import "VerticalView.h"
#define line_time 2.0f // 时间

//加入这个宏，可以省略所有 mas_ （除了mas_equalTo）
#define MAS_SHORTHAND
//加入这个宏，那么mas_equalTo就和equalTo一样的了
#define MAS_SHORTHAND_GLOBALS
//上面的两个宏一定要在这句之前
#import "Masonry/Masonry.h"


@interface VerticalView ()
{
    NSInteger cellsNumber;
     CGFloat cell_height;
}
@end
@implementation VerticalView


- (instancetype)initWithFrame:(CGRect)frame itemsNumber:(NSInteger)number delegate:(id<VerticalViewDelegate>)delegate image:(UIImage *)image
{
    self = [super initWithFrame:frame];
    if (self) {
        cellsNumber = 0;
        cell_height = 44;
        _leftImage = image;
        cellsNumber = number;
        self.delegate = delegate;
        [self creatVerticalView:self.bounds];
        
    }
    return self;
}

- (void)creatVerticalView:(CGRect)frame{
    
    //添加左边的icon
    _leftImageView = [[UIImageView alloc] init];
    _leftImageView.image = self.leftImage;
    [self addSubview:_leftImageView];
    [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.and.left.mas_equalTo(self);
        make.left.mas_equalTo(self);
        make.centerY.mas_equalTo(self);
    }];
    
  
//    //中间的竖线
//    UIView * lineView_01 = [[UIView alloc] init];
//    lineView_01.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:.8f];
//    [self addSubview:lineView_01];
//    [lineView_01 mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//         make.left.mas_equalTo(self.leftImageView.mas_right).offset(4);
//        make.top.mas_equalTo(self).offset(0);
//        make.height.mas_equalTo(self.mas_height);
//        make.width.mas_equalTo(0.5f);
//    }];
    

    
    // 右边的 UITableView
    // 使用约束布局，将frame置为CGRectZero
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.scrollEnabled = NO;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone; // 去除分割线
    [self addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        //头部相对于父视图
        make.top.equalTo(self);
        if (self.leftImage) {
            make.left.mas_equalTo(self.leftImageView.mas_right).offset(5);
        } else {
            make.left.mas_equalTo(self);
        }
        make.right.equalTo(self);
        //底部相对于父视图
        make.bottom.equalTo(self);
    }];
    
  
}
#pragma mark tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return cellsNumber+1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"heightForRowAtIndexPath*******");
    return cell_height;
}
/**
 * 返回每一行的估计高度
 * 只要返回了估计高度，那么就会先调用tableView:cellForRowAtIndexPath:方法创建cell，再调用tableView:heightForRowAtIndexPath:方法获取cell的真实高度
 *  先给一个估算的高度 能提高性能 就会先走返回 cell 的 方法 然后再走返回高度的方法
 */
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"estimatedHeightForRowAtIndexPath----");
    return 43;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cellForRowAtIndexPath&&&&&&&&&");
    //最后一个显示第一个内容
    if ([self.delegate respondsToSelector:@selector(verticalView:tableView:cellForRowAtIndexPath:)]) {
        if (indexPath.row == cellsNumber) {
            NSIndexPath * index = [NSIndexPath indexPathForRow:0 inSection:0];
            UITableViewCell * cell = [self.delegate verticalView:self tableView:tableView cellForRowAtIndexPath:index];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }else{
            UITableViewCell * cell = [self.delegate verticalView:self tableView:tableView cellForRowAtIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    return [UITableViewCell new];
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //返回cell的点击事件
    if ([self.delegate respondsToSelector:@selector(vertialView:tableView:selectedRowAtIndexPath:)]) {
        
        // 点击停止定时器
//         [self stopRow];
        
        [self.delegate  vertialView:self tableView:tableView selectedRowAtIndexPath:indexPath];
    }
}

//- (void)setLeftImage:(UIImage *)leftImage
//{
//    // 设置左边的 view
//    _leftImage = leftImage;
//    _leftImageView.image = _leftImage;
//    
//}
/**
 *  开始滚动，添加定时器
 */
-(void)startRow
{
    if (cellsNumber != 0) {
        //添加定时器
        if (self.timer) {
            [self stopRow];
        }
        self.timer = [NSTimer scheduledTimerWithTimeInterval:line_time target:self selector:@selector(action:) userInfo:nil repeats:YES];
        //主线程等待，但让出主线程时间片；有事件到达就返回，比如点击UI等
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];

    }
}
-(void)action:(NSTimer *)timer
{
   NSLog(@"哈哈哈哈%f",_tableView.contentSize.height);
//    
//    //获取当前的_tableView 的位置
    NSLog(@"%f",_tableView.contentOffset.y);
    
      [UIView animateWithDuration:line_time-0.5f delay:0 options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState animations:^{
        CGPoint old = _tableView.contentOffset;
        old.y = old.y+cell_height;
        if (_tableView.contentOffset.y >= cell_height*cellsNumber) {
            _tableView.contentOffset = CGPointMake(0, 0);
        }else _tableView.contentOffset = old;
    } completion:^(BOOL finished) {
        if (_tableView.contentOffset.y >= cell_height*cellsNumber)
            _tableView.contentOffset = CGPointMake(0, 0);
    }];
}
/**
 *  停止滚动，销毁定时器
 */
-(void)stopRow
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}
-(void)dealloc
{
    [self stopRow];
}

@end
