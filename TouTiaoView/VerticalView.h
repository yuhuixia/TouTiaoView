//
//  VerticalView.h
//  TouTiaoView
//
//  Created by 于慧霞 on 16/7/3.
//  Copyright © 2016年 yuhuixia. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VerticalViewDelegate;

@interface VerticalView : UIView<UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong) UITableView *tableView;
// 左边显示的 icon
@property (nonatomic, strong) UIImageView *leftImageView;
// 左边显示的 icon
@property (nonatomic, strong) UIImage *leftImage;
// 定时器
@property (nonatomic, strong) NSTimer *timer;
// 代理属性
@property (nonatomic, assign) id<VerticalViewDelegate >delegate;

- (void)startRow;
- (void)stopRow;
- (instancetype)initWithFrame:(CGRect)frame itemsNumber:(NSInteger)number delegate:(id<VerticalViewDelegate>)delegate image:(UIImage *)image;

@end
@protocol VerticalViewDelegate <NSObject>

@optional
/**
 *  返回 cell 的点击事件

 */
- (void)vertialView:(VerticalView *)vertialView tableView:(UITableView *)tableView selectedRowAtIndexPath:(NSIndexPath *)indexPath;

@required
/**
 *  返回每一行显示的内容
 */
-(UITableViewCell *)verticalView:(VerticalView *)verticalView tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end