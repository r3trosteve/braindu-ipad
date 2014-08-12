//
//  ViewController.h
//  braindu-objc
//
//  Created by Steven Schofield on 11/08/2014.
//  Copyright (c) 2014 Double Digital. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WebViewLoadState) {
    WebViewClosed               = 0,
    WebViewMinimised            = 1,
    WebViewMaximised            = 2
};

@interface ViewController : UIViewController <UITabBarDelegate>

@property (strong, nonatomic) IBOutlet UIBarButtonItem *fullScreenButton;

@property (strong, nonatomic) IBOutlet UIView *nodeContainer;
@property (weak, nonatomic) IBOutlet UIImageView *nodeImageRectLandscape;
@property (weak, nonatomic) IBOutlet UILabel *nodeLabel;
@property (strong, nonatomic) IBOutlet UIView *webViewContainer;
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UIImageView *searchIconImage;

@property (strong, nonatomic) IBOutlet UITabBar *tabBar;
@property (strong, nonatomic) IBOutlet UITabBarItem *backButton;
@property (strong, nonatomic) IBOutlet UITabBarItem *forwardButton;
@property (strong, nonatomic) IBOutlet UITabBarItem *reloadButton;
@property (strong, nonatomic) IBOutlet UITabBarItem *stopButton;

@property (nonatomic, assign) WebViewLoadState loadState;

- (IBAction)fullscreenWebViewWasPressed:(id)sender;

@end

