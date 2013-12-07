//
//  ViewController.m
//  LineView
//
//  Created by casa on 13-12-7.
//  Copyright (c) 2013年 casa. All rights reserved.
//

#import "ViewController.h"
#import "AJKPriceChartView.h"

@interface ViewController ()

@property (nonatomic, strong) AJKPriceChartView *priceChartView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.priceChartView = [[AJKPriceChartView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
    [self.priceChartView configWithData:nil];
    [self.view addSubview:self.priceChartView];
}

@end
