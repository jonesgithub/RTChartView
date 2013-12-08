//
//  AJKPriceChartView.m
//  LineView
//
//  Created by casa on 13-12-7.
//  Copyright (c) 2013年 casa. All rights reserved.
//

#import "AJKPriceChartView.h"
#import "RTChartView.h"
#import "RTVerticalDashedLine.h"

@interface AJKPriceChartView ()

@property (nonatomic, strong) RTChartView *chartView;
@property (nonatomic, strong) RTVerticalDashedLine *verticalDashedLine;

@end

@implementation AJKPriceChartView
#pragma mark - getters and setters
- (RTVerticalDashedLine *)verticalDashedLine
{
    if (_verticalDashedLine == nil) {
        _verticalDashedLine = [[RTVerticalDashedLine alloc] init];
    }
    return _verticalDashedLine;
}

#pragma mark - public method
- (void)configWithData:(NSDictionary *)data
{
    NSArray *dataArray = @[
                           @{@"time":@"1", @"price":@"10000"},
                           @{@"time":@"2", @"price":@"90000"},
                           @{@"time":@"1", @"price":@"20000"},
                           @{@"time":@"3", @"price":@"80000"},
                           @{@"time":@"1", @"price":@"30000"},
                           @{@"time":@"4", @"price":@"70000"},
                           @{@"time":@"1", @"price":@"40000"},
                           @{@"time":@"5", @"price":@"60000"},
                           @{@"time":@"1", @"price":@"50000"},
                           @{@"time":@"6", @"price":@"990000"},
                           @{@"time":@"1", @"price":@"10000"},
                           @{@"time":@"6", @"price":@"80000"},
                           @{@"time":@"1", @"price":@"20000"},
                           @{@"time":@"6", @"price":@"70000"},
                           @{@"time":@"1", @"price":@"30000"},
                           @{@"time":@"6", @"price":@"60000"},
                           @{@"time":@"1", @"price":@"40000"},
                           @{@"time":@"6", @"price":@"50000"},
                           @{@"time":@"1", @"price":@"10000"},
                           @{@"time":@"7", @"price":@"100000"},
                           @{@"time":@"1", @"price":@"30000"}
                           ];
    
    self.chartView = [[RTChartView alloc] initWithFrame:CGRectMake(0, 0, 1020, 200)];
    self.chartView.xMargin = 10.0f;
    self.chartView.yMargin = 10.0f;
    self.chartView.backgroundColor = [UIColor clearColor];
    self.chartView.delegate = self;
    [self.chartView configWithData:dataArray];
    
    self.contentSize = CGSizeMake(1020, 200);
    [self addSubview:self.chartView];
}

#pragma mark - RTChartViewEventDelegate
- (void)chartView:(RTChartView *)chartView dotDidClicked:(RTChartDotView *)dot
{
    self.verticalDashedLine.frame = CGRectMake(dot.center.x, 0, 0.5f, chartView.frame.size.height-chartView.yMargin-chartView.labelSize.height);
    if (![self.verticalDashedLine superview]) {
        [chartView addSubview:self.verticalDashedLine];
    }
}

@end
