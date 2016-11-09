//
//  ViewController.m
//  AppearMenuViewSelected
//
//  Created by FreshManCode on 2016/11/8.
//  Copyright © 2016年 FreshManCode. All rights reserved.
//

#import "ViewController.h"
#import "PopSelectedMenuView.h"
#import "PopSelectedMenuViewModel.h"
#import "ProductViewController.h"


#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController () <PopSelectedMenuViewDelegate>
@property (nonatomic,strong) NSArray * dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"菜单选择器";
    [self initDataArray];
    [self initFourChoiceDifferentButton];
}

- (void)initDataArray {
    PopSelectedMenuViewModel *modelOne = [[PopSelectedMenuViewModel alloc]initWithItemTitle:@"店铺" itemImageName:@"type_brand"];
    PopSelectedMenuViewModel *modelTwo = [[PopSelectedMenuViewModel alloc]initWithItemTitle:@"商家" itemImageName:@"type_good"];
    PopSelectedMenuViewModel *modelThree = [[PopSelectedMenuViewModel alloc]initWithItemTitle:@"贸易" itemImageName:@"type_trade"];
    _dataArray = [NSArray arrayWithObjects:modelOne,modelTwo,modelThree, nil];
}

- (void)initFourChoiceDifferentButton {
    CGFloat offSetX = 20;
    CGFloat offSetY = 20;
    CGFloat width   = (SCREENWIDTH - 3*offSetX) / 2.0;
    CGFloat height  = 30;
    NSArray *arrays = [NSArray arrayWithObjects:@"正常方式箭头在左",@"正常方式箭头在右",@"倒序方式箭头在左",@"倒序方式箭头在右", nil];
    for (int i =0;i<arrays.count;i++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake((i  %2)* (offSetX +width) +offSetX, self.view.center.y + (offSetY +height)*(i/2) + offSetY, width, height)];
        [button setTitle:arrays[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor redColor]];
        button.tag = 1+i;
        [button addTarget:self action:@selector(appearMenuTablView:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
}

- (void)appearMenuTablView:(UIButton *)sender {
    CGFloat x = sender.center.x;
    CGFloat y = sender.frame.size.height +sender.frame.origin.y +5;
    if (sender.tag >2) {
        y = sender.frame.origin.y - 5;
    }
    CGFloat height = 44;
    CGFloat width  = 100;
    PopSelectedMenuView *muenuView = [[PopSelectedMenuView alloc]initWithOrigin:CGPointMake(x, y) rowWidth:width rowHeight:height dataArray:self.dataArray popType:sender.tag delegate:self];
    [muenuView popCurrentView];
}

- (void)didSelectedAccordingItem:(NSIndexPath *)indexPath {
    PopSelectedMenuViewModel *selectedModel = _dataArray[indexPath.row];
    ProductViewController *productVC        = [[ProductViewController alloc]init];
    productVC.title = selectedModel.title;
    [self.navigationController pushViewController:productVC animated:YES];
    NSLog(@"选择的商品标题是:%@",selectedModel.title);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


@end
