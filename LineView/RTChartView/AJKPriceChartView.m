//
//  AJKPriceChartView.m
//  LineView
//
//  Created by casa on 13-12-7.
//  Copyright (c) 2013年 casa. All rights reserved.
//

#import "AJKPriceChartView.h"
#import "RTChartView.h"

@interface AJKPriceChartView ()

@property (nonatomic, strong) RTChartView *chartView;

@end

@implementation AJKPriceChartView

- (void)configWithData:(NSDictionary *)data
{
    NSArray *dataArray = @[
                           @{@"time":@"1", @"price":@"10000"},
                           @{@"time":@"2", @"price":@"30000"},
                           @{@"time":@"3", @"price":@"10000"},
                           @{@"time":@"4", @"price":@"30000"},
                           @{@"time":@"5", @"price":@"10000"},
                           @{@"time":@"6", @"price":@"30000"},
                           @{@"time":@"7", @"price":@"10000"}
                           ];
    
    self.chartView = [[RTChartView alloc] initWithFrame:CGRectMake(0, 0, 520, 200)];
    self.chartView.xMargin = 40.0f;
    self.chartView.yMargin = 40.0f;
    self.chartView.backgroundColor = [UIColor whiteColor];
    [self.chartView configWithData:dataArray];
    
    self.contentSize = CGSizeMake(520, 200);
    [self addSubview:self.chartView];
}

@end
