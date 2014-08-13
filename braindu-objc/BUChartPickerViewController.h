//
//  BUChartPickerViewController.h
//  braindu-objc
//
//  Created by Steven Schofield on 13/08/2014.
//  Copyright (c) 2014 Double Digital. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BUChart;

@protocol ChartPickerDelegate <NSObject>

@required
-(void)selectChart:(BUChart *)newChart;
@end

@interface BUChartPickerViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *chartNames;
@property (nonatomic, weak) id<ChartPickerDelegate> delegate;

@end
