//
//  ViewController.h
//  braindu-objc
//
//  Created by Steven Schofield on 11/08/2014.
//  Copyright (c) 2014 Double Digital. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *nodeContainer;
@property (weak, nonatomic) IBOutlet UIImageView *nodeImageRectLandscape;
@property (weak, nonatomic) IBOutlet UILabel *nodeLabel;
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UITextField *textField;

@property (strong, nonatomic) IBOutlet UITabBarItem *backButton;
@property (strong, nonatomic) IBOutlet UITabBarItem *forwardButton;
@property (strong, nonatomic) IBOutlet UITabBarItem *reloadButton;
@property (strong, nonatomic) IBOutlet UITabBarItem *stopButton;


@end

