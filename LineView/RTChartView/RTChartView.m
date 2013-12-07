//
//  RTChartView.m
//  LineView
//
//  Created by casa on 13-12-7.
//  Copyright (c) 2013年 casa. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>

#import "RTChartView.h"
#import "RTChartDotView.h"

@interface RTChartView ()

@property (nonatomic, strong, readwrite) NSArray *priceArray;

@property (nonatomic, strong) NSMutableArray *timeLabelArray;
@property (nonatomic, strong) NSMutableArray *dotArray;

@property (nonatomic, copy) NSArray *dataArray;

@property (nonatomic) CGFloat xGap;
@property (nonatomic) CGFloat yGap;

@property (nonatomic) CGFloat maxPrice;
@property (nonatomic) CGFloat minPrice;

@end

@implementation RTChartView

#pragma mark - getters and setters
- (NSMutableArray *)timeLabelArray
{
    if (_timeLabelArray == nil) {
        _timeLabelArray = [[NSMutableArray alloc] init];
    }
    return _timeLabelArray;
}

- (NSMutableArray *)dotArray
{
    if (_dotArray == nil) {
        _dotArray = [[NSMutableArray alloc] init];
    }
    return _dotArray;
}

#pragma mark - public methods
- (void)configWithData:(NSArray *)dataArray;
{
    [self configDefaultParams];
    CGFloat yAxisFactor = self.yAxisItemCount - 1.0f;
    
    self.dataArray = dataArray;
    
    self.xGap = (self.frame.size.width - self.xMargin * 2) / ([self.dataArray count] - 1);
    self.yGap = (self.frame.size.height - self.yMargin * 2 ) / yAxisFactor;
    
    NSMutableArray *timeArray = [[NSMutableArray alloc] init];
    
    CGFloat minPrice = CGFLOAT_MAX;
    CGFloat maxPrice = CGFLOAT_MIN;
    CGFloat currentPrice = 0;
    
    for (NSDictionary *info in self.dataArray) {
        currentPrice = [info[@"price"] floatValue];
        if (currentPrice > maxPrice) {
            maxPrice = currentPrice;
        }
        if (currentPrice < minPrice) {
            minPrice = currentPrice;
        }
        
        [timeArray addObject:info[@"time"]];
    }
    
    self.maxPrice = (self.yDataGap - ((NSInteger)maxPrice % self.yDataGap)) + maxPrice;
    self.minPrice = minPrice - ((NSInteger)minPrice % self.yDataGap);
    NSInteger priceGap = (self.maxPrice - self.minPrice) / yAxisFactor;
    
    NSMutableArray *priceArray = [[NSMutableArray alloc] init];
    for (int i=0; i <= yAxisFactor; i++) {
        [priceArray addObject:@( minPrice + (i * priceGap) )];
    }
    self.priceArray = priceArray;
    
    //tune the time label axis and dots.
    for (UILabel *timeLabel in self.timeLabelArray) {
        [timeLabel removeFromSuperview];
        [self.timeLabelArray removeObject:timeLabel];
    }
    
    for (RTChartDotView *dot in self.dotArray) {
        [dot removeFromSuperview];
        [self.dotArray removeObject:dot];
    }
    
    NSInteger counter = 0;
    for (NSDictionary *data in self.dataArray) {
        //add time label
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.labelSize.width, self.labelSize.height)];
        timeLabel.center = CGPointMake(self.xMargin+counter*self.xGap, self.frame.size.height-self.labelSize.height);
        timeLabel.text = data[@"time"];
        timeLabel.textAlignment = NSTextAlignmentCenter;
        [self.timeLabelArray addObject:timeLabel];
        [self addSubview:timeLabel];
        
        //add dots
        RTChartDotView *dot = [[RTChartDotView alloc] init];
        dot.radius = self.dotRadius;
        dot.lineColor = self.dotLineColor;
        dot.lineWidth = self.dotLineWidth;
        dot.backgroundColor = [UIColor clearColor];
        dot.frame = CGRectMake(0, 0, 10, 10);
        [dot configWithData:data];
        [dot addTarget:self action:@selector(dotDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.dotArray addObject:dot];
        [self addSubview:dot];
        counter++;
    }
    
    [self setNeedsDisplay];
}

#pragma mark - self methods
- (void)configDefaultParams
{
    if (self.yAxisItemCount == 0) {
        self.yAxisItemCount = 6;
    }
    
    if (self.yDataGap == 0) {
        self.yDataGap = 1000.0f;
    }
    
    if (self.labelSize.width == 0 && self.labelSize.height == 0) {
        self.labelSize = CGSizeMake(40, 20);
    }
    
    if (self.lineWidth == 0) {
        self.lineWidth = 0.5f;
    }
    
    if (self.lineColor == nil) {
        self.lineColor = [UIColor blackColor];
    }
    
}


- (void)drawRect:(CGRect)rect
{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, self.lineWidth);
    CGContextSetStrokeColorWithColor(context, self.lineColor.CGColor);
    
    NSUInteger counter = 0;
    for (NSDictionary *info in self.dataArray) {
        CGFloat price = [info[@"price"] floatValue];
        CGFloat xOffset = self.xMargin+counter*self.xGap;
        CGFloat yOffset = (self.maxPrice - price)/(self.maxPrice - self.minPrice)*(self.frame.size.height - self.labelSize.height - self.yMargin*2)+self.yMargin;
        if (counter == 0) {
            CGContextMoveToPoint(context, xOffset, yOffset);
        } else {
            CGContextAddLineToPoint(context, xOffset, yOffset);
        }
        
        RTChartDotView *dot = self.dotArray[counter];
        dot.center = CGPointMake(xOffset, yOffset);
        
        counter++;
    }
    
    CGContextStrokePath(context);
    
}

- (void)dotDidClicked:(RTChartDotView *)dot
{
    
}
@end
