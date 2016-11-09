//
//  PopSelectedMenuViewModel.h
//  ImitateBaiduCourse
//
//  Created by FreshManCode on 2016/11/8.
//  Copyright © 2016年 FreshManCode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PopSelectedMenuViewModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imageName;

- (instancetype)initWithItemTitle:(NSString *)title
                    itemImageName:(NSString *)imageName;

@end
