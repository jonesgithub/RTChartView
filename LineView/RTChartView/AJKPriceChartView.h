//
//  AJKPriceChartView.h
//  LineView
//
//  Created by casa on 13-12-7.
//  Copyright (c) 2013年 casa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTChartView.h"

@interface AJKPriceChartView : UIScrollView<RTChartViewEventDelegate>

- (void)configWithData:(NSDictionary *)data;

@end
