//
//  RTVerticalDashedLine.m
//  LineView
//
//  Created by casa on 13-12-8.
//  Copyright (c) 2013年 casa. All rights reserved.
//

#import "RTVerticalDashedLine.h"

@implementation RTVerticalDashedLine

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.lineColor = [UIColor blackColor];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, self.frame.size.width);
    CGContextSetStrokeColorWithColor(context, self.lineColor.CGColor);
    CGFloat lengths[] = {4,4};
    CGContextSetLineDash(context, 0, lengths, 2);
    CGContextMoveToPoint(context, 0.0f, 0.0f);
    CGContextAddLineToPoint(context, 0.0f, self.frame.size.height);
    CGContextStrokePath(context);
}

@end
