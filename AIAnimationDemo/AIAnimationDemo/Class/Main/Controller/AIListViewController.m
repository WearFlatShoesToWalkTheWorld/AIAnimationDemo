//
//  AIMainViewController.m
//  AIAnimationDemo
//
//  Created by 艾泽鑫 on 16/9/26.
//  Copyright © 2016年 艾泽鑫. All rights reserved.
//

#import "AIListViewController.h"
#import "AIListModel.h"
#import "AIListTableViewCell.h"
#import "AIPop1ViewController.h"
#import "AIPopSpringAnimationViewController.h"
#import "AIMarqueeViewController.h"
#import "GCD.h"
#import "AISpringScaleViewController.h"   //pop缩放动画
#import "AIBaiduLoadHUDViewController.h"  //防百度加载提示
@interface AIListViewController ()<UITableViewDelegate,UITableViewDataSource>
/** 主要的tableView*/
@property(nonatomic,strong)UITableView *tableView;
/** 数据源*/
@property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,assign,getter=isTableViewLoadData)BOOL tableViewLoadData;
@end

@implementation AIListViewController

#pragma mark ----lazy
-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        NSArray *array = @[[AIListModel initWithTitle:@"衰减动画" andTargetVC:[AIPop1ViewController class]],
                           [AIListModel initWithTitle:@"弹簧动画" andTargetVC:[AIPopSpringAnimationViewController class]],
                           [AIListModel initWithTitle:@"跑马灯效果" andTargetVC:[AIMarqueeViewController class]],
                           [AIListModel initWithTitle:@"Pop缩放动画" andTargetVC:[AISpringScaleViewController class]],
                           [AIListModel initWithTitle:@"防百度加载提示" andTargetVC:[AIBaiduLoadHUDViewController class]],
                           [AIListModel initWithTitle:@"弹簧动画" andTargetVC:[AIPopSpringAnimationViewController class]],
                           [AIListModel initWithTitle:@"弹簧动画" andTargetVC:[AIPopSpringAnimationViewController class]],
                           [AIListModel initWithTitle:@"弹簧动画" andTargetVC:[AIPopSpringAnimationViewController class]],
                           [AIListModel initWithTitle:@"弹簧动画" andTargetVC:[AIPopSpringAnimationViewController class]],
                           [AIListModel initWithTitle:@"弹簧动画" andTargetVC:[AIPopSpringAnimationViewController class]],
                           [AIListModel initWithTitle:@"弹簧动画" andTargetVC:[AIPopSpringAnimationViewController class]],
                           [AIListModel initWithTitle:@"弹簧动画" andTargetVC:[AIPopSpringAnimationViewController class]],
                           [AIListModel initWithTitle:@"弹簧动画" andTargetVC:[AIPopSpringAnimationViewController class]],
                           [AIListModel initWithTitle:@"弹簧动画" andTargetVC:[AIPopSpringAnimationViewController class]],
                           [AIListModel initWithTitle:@"弹簧动画" andTargetVC:[AIPopSpringAnimationViewController class]],
                           [AIListModel initWithTitle:@"弹簧动画" andTargetVC:[AIPopSpringAnimationViewController class]],
                           [AIListModel initWithTitle:@"弹簧动画" andTargetVC:[AIPopSpringAnimationViewController class]],
                           [AIListModel initWithTitle:@"弹簧动画" andTargetVC:[AIPopSpringAnimationViewController class]],
                           [AIListModel initWithTitle:@"弹簧动画" andTargetVC:[AIPopSpringAnimationViewController class]],
                           [AIListModel initWithTitle:@"弹簧动画" andTargetVC:[AIPopSpringAnimationViewController class]],
                           [AIListModel initWithTitle:@"弹簧动画" andTargetVC:[AIPopSpringAnimationViewController class]],
                           [AIListModel initWithTitle:@"弹簧动画" andTargetVC:[AIPopSpringAnimationViewController class]],
                           [AIListModel initWithTitle:@"弹簧动画" andTargetVC:[AIPopSpringAnimationViewController class]],
                           [AIListModel initWithTitle:@"弹簧动画" andTargetVC:[AIPopSpringAnimationViewController class]],
                           [AIListModel initWithTitle:@"弹簧动画" andTargetVC:[AIPopSpringAnimationViewController class]],
                           [AIListModel initWithTitle:@"弹簧动画" andTargetVC:[AIPopSpringAnimationViewController class]],
                           [AIListModel initWithTitle:@"弹簧动画" andTargetVC:[AIPopSpringAnimationViewController class]],
                           [AIListModel initWithTitle:@"弹簧动画" andTargetVC:[AIPopSpringAnimationViewController class]]
                           ];
        _dataSource = [array copy];
    }
    return _dataSource;
}

#pragma mark ----life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

#pragma mark ----UI
/**设置ui*/
-(void)setUI{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,MainSize.width , MainSize.height)
                                                 style:(UITableViewStylePlain)];
    //去掉自带分割线
    [_tableView setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
    [GCDQueue executeInMainQueue:^{
        // Load data.
        NSMutableArray *indexPaths = [NSMutableArray array];
        for (int i = 0; i < self.dataSource.count; i++) {
            
            [indexPaths addObject:[NSIndexPath indexPathForItem:i inSection:0]];
        }
        self.tableViewLoadData = YES;
        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    } afterDelaySecs:0.25f];
}

#pragma mark -UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 立即取消选中
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    AIListModel *model = self.dataSource[indexPath.row];
    UIViewController *targetVC = [[model.targetVC alloc]init];
    [self.navigationController pushViewController:targetVC  animated:YES];
}

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.isTableViewLoadData ? self.dataSource.count:0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AIListTableViewCell *cell = [AIListTableViewCell createTableViewCellWithTableView:tableView];
    cell.model = self.dataSource[indexPath.row];
    return cell;
}

@end