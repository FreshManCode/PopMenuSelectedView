//
//  PopSelectedMenuView.h
//  ImitateBaiduCourse
//
//  Created by FreshManCode on 2016/11/8.
//  Copyright © 2016年 FreshManCode. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, PopViewPosition) {
    //正常弹出 (箭头在左)
    PopViewPositionArrowLeft  = 1,
    //正常弹出 (箭头在右)
    PopViewPositionArrowRight = 2,
    //从反向弹出 (箭头在左)
    PopViewPositionReverseArrowLeft = 3,
    //从反向弹出 (箭头在右)
    PopViewPositionReverseArrowRight = 4,
};

@protocol PopSelectedMenuViewDelegate <NSObject>
- (void)didSelectedAccordingItem:(NSIndexPath *)indexPath;
@end


@interface PopSelectedMenuView : UIView
@property(nonatomic,assign) id <PopSelectedMenuViewDelegate> delegate;
- (id)initWithOrigin:(CGPoint)origin
            rowWidth:(CGFloat)width
           rowHeight:(CGFloat)height
           dataArray:(NSArray *)arrays
             popType:(PopViewPosition)type
            delegate:(id)delegate;

- (void)popCurrentView;
- (void)closeCurrentView;


@end
