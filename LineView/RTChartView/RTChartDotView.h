//
//  RTChartDotView.h
//  LineView
//
//  Created by casa on 13-12-8.
//  Copyright (c) 2013年 casa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTChartDotView : UIControl

@property (nonatomic) CGFloat radius;
@property (nonatomic) CGFloat lineWidth;
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, strong) UIColor *centerColor;

@property (nonatomic, readonly) NSDictionary *info;

- (void)configWithData:(NSDictionary *)data;

@end
