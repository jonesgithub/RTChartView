//
//  RTChartView.h
//  LineView
//
//  Created by casa on 13-12-7.
//  Copyright (c) 2013年 casa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTChartView : UIView

@property (nonatomic, strong, readonly) NSArray *priceArray;

@property (nonatomic) CGFloat xMargin;
@property (nonatomic) CGFloat yMargin;
@property (nonatomic) CGFloat yAxisItemCount;
@property (nonatomic) NSInteger yDataGap;
@property (nonatomic) CGSize labelSize;
@property (nonatomic) CGFloat lineWidth;
@property (nonatomic) UIColor *lineColor;

- (void)configWithData:(NSArray *)data;

@end