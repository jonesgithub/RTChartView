//
//  RTChartView.m
//  LineView
//
//  Created by casa on 13-12-7.
//  Copyright (c) 2013年 casa. All rights reserved.
//

#import "RTChartView.h"
#import <CoreGraphics/CoreGraphics.h>

@interface RTChartView ()

@property (nonatomic, strong, readwrite) NSArray *priceArray;
@property (nonatomic, strong) NSMutableArray *timeLabelArray;

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
    
    //tune the time label axis.
    for (UILabel *timeLabel in self.timeLabelArray) {
        [timeLabel removeFromSuperview];
    }
    
    self.timeLabelArray = nil;
    
    NSInteger counter = 0;
    for (NSString *time in timeArray) {
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.labelSize.width, self.labelSize.height)];
        timeLabel.center = CGPointMake(self.xMargin+counter*self.xGap, self.frame.size.height-self.labelSize.height);
        timeLabel.text = time;
        timeLabel.textAlignment = NSTextAlignmentCenter;
        [self.timeLabelArray addObject:timeLabel];
        [self addSubview:timeLabel];
        counter++;
    }
    
    [self setNeedsDisplay];
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
        counter++;
    }
    
    CGContextStrokePath(context);
    
}

@end
