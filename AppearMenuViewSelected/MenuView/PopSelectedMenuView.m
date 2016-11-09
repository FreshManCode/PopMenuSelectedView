//
//  PopSelectedMenuView.m
//  ImitateBaiduCourse
//
//  Created by FreshManCode on 2016/11/8.
//  Copyright © 2016年 FreshManCode. All rights reserved.
//

#import "PopSelectedMenuView.h"
#import "PopSelectedMenuViewModel.h"

#define KSCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define KSCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define LKeftToViewSpace 10.f
#define KTopToViewSpace  10.f

@interface PopSelectedMenuView () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSArray *contentArray;
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,assign) CGPoint  origin;
@property (nonatomic,assign) CGFloat  width;
@property (nonatomic,assign) CGFloat  height;
@property (nonatomic,assign) PopViewPosition positionType;
@end



@implementation PopSelectedMenuView

static NSString *identifier = @"PopSelectedMenuViewCell";

- (id)initWithOrigin:(CGPoint)origin
            rowWidth:(CGFloat)width
           rowHeight:(CGFloat)height
           dataArray:(NSArray *)arrays
             popType:(PopViewPosition)type
            delegate:(id)delegate{
    if (self = [super initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_HEIGHT)]) {
        self.backgroundColor = [UIColor clearColor];
        self.origin = origin;
        self.width  = width;
        self.height = height;
        self.contentArray = [NSArray arrayWithArray:arrays];
        self.positionType = type;
        self.delegate = delegate;
        [self initSubViews];
    }
    return self;

}

- (void)initSubViews {
    switch (self.positionType) {
        case PopViewPositionArrowLeft:
            self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(self.origin.x, self.origin.y, self.width, self.height *self.contentArray.count) style:UITableViewStylePlain];
            break;
        case PopViewPositionArrowRight:
            self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(self.origin.x, self.origin.y, -self.width, self.height *self.contentArray.count) style:UITableViewStylePlain];
            break;
        case PopViewPositionReverseArrowLeft: {
            self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(self.origin.x, self.origin.y, self.width, -self.height*self.contentArray.count ) style:UITableViewStylePlain];
        }
            break;
        case PopViewPositionReverseArrowRight: {
            self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(self.origin.x, self.origin.y, -self.width, -self.height*self.contentArray.count) style:UITableViewStylePlain];
        }
            
            break;
        default:
            break;
    }
    _tableView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:1];
    _tableView.separatorColor  = [UIColor colorWithWhite:0.2 alpha:1];
    _tableView.dataSource = self;
    _tableView.delegate   = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    [self addSubview:_tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contentArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.selectionStyle   = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font   = [UIFont systemFontOfSize:15];
    cell.backgroundColor  = [UIColor clearColor];
    PopSelectedMenuViewModel *menuModel = self.contentArray[indexPath.row];
    cell.imageView.image  = [UIImage imageNamed:menuModel.imageName];
    cell.textLabel.text   = menuModel.title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedAccordingItem:)]) {
        [self.delegate didSelectedAccordingItem:indexPath];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self closeCurrentView];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_tableView setLayoutMargins:UIEdgeInsetsMake(0, 10, 0, 10)];
    }
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 10, 0, 10)];
    }
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef ref = UIGraphicsGetCurrentContext();
    CGFloat originX = self.origin.x;
    CGFloat originY = self.origin.y;
    switch (self.positionType) {
        case PopViewPositionArrowLeft: {
            CGContextMoveToPoint(ref, originX +25 , originY);
            CGContextAddLineToPoint(ref, originX + 30 , originY - 5);
            CGContextAddLineToPoint(ref, originX + 35 , originY);
        }
            break;
        case PopViewPositionArrowRight: {
            CGContextMoveToPoint(ref, originX - 25, originY);
            CGContextAddLineToPoint(ref, originX - 30, originY - 5);
            CGContextAddLineToPoint(ref, originX - 35, originY);
        }
            break;
        case PopViewPositionReverseArrowLeft: {
            CGContextMoveToPoint(ref, originX + 25, originY );
            CGContextAddLineToPoint(ref, originX + 30, originY + 5);
            CGContextAddLineToPoint(ref, originX + 35, originY );
        }
            break;
        case PopViewPositionReverseArrowRight: {
            CGContextMoveToPoint(ref, originX - 25, originY);
            CGContextAddLineToPoint(ref, originX - 30, originY +5);
            CGContextAddLineToPoint(ref, originX - 35, originY);
        }
            break;
        default:
            break;
    }
    
    CGContextClosePath(ref);
    [self.tableView.backgroundColor setFill];
    [self.tableView.backgroundColor setStroke];
    CGContextFillPath(ref);
}


- (void)popCurrentView {
    UIWindow *keyWindow = [[UIApplication sharedApplication]keyWindow];
    [keyWindow addSubview:self];
    self.alpha   = 0;
    CGRect frame = self.tableView.frame;
    self.tableView.frame = CGRectMake(frame.origin.x, frame.origin.y, 0, 0);
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 1;
        self.tableView.frame = frame;
    }];
}

- (void)closeCurrentView {
  [UIView animateWithDuration:0.2 animations:^{
      self.alpha = 0;
      self.tableView.frame = CGRectMake(self.origin.x, self.origin.y, 0, 0);
  } completion:^(BOOL finished) {
      if (finished) {
          [self removeFromSuperview];
      }
  }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if (![touch.view isEqual:self.tableView]) {
        [self closeCurrentView];
    }
}

@end
