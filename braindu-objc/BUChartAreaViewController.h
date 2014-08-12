//
//  BUChartAreaViewController.h
//  braindu-objc
//
//  Created by Steven Schofield on 12/08/2014.
//  Copyright (c) 2014 Double Digital. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BUChartAreaViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIView *draggingView;
@property (nonatomic, weak) IBOutlet UIView *oneView;
@property (nonatomic, weak) IBOutlet UIView *twoView;
@property (nonatomic, weak) IBOutlet UIView *threeView;
@property (nonatomic, weak) IBOutlet UILabel *completionLabel;
@property (nonatomic, strong) IBOutlet UIPanGestureRecognizer *panRecognizer;

- (IBAction)handlePanRecognizer:(id)sender;

@end
