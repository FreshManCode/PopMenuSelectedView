//
//  ProductViewController.m
//  AppearMenuViewSelected
//
//  Created by 巴巴罗萨 on 2016/11/8.
//  Copyright © 2016年 FreshManCode. All rights reserved.
//

#import "ProductViewController.h"
#define SCREENWIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

@interface ProductViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation ProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDataArray];
}

- (void)initDataArray {
    _dataArray = [[NSMutableArray alloc]initWithCapacity:0];
    for (int i =0;i<20;i++ ) {
        [_dataArray addObject:[NSString stringWithFormat:@"测试数据:%d",(i +1)]];
    }
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREENWIDTH, SCREENHEIGHT ) style:UITableViewStyleGrouped];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 44;
    [self.view addSubview:_tableView];
    [_tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text   = _dataArray[indexPath.row];
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
