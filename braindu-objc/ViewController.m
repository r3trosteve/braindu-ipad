//
//  ViewController.m
//  braindu-objc
//
//  Created by Steven Schofield on 11/08/2014.
//  Copyright (c) 2014 Double Digital. All rights reserved.
//

#import "ViewController.h"
#import "BUObject.h"

@interface ViewController () <UIWebViewDelegate, UITextFieldDelegate>

@property (nonatomic, assign) NSUInteger frameCount;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView.delegate = self;
    self.loadState = WebViewMinimised;
    
    self.tabBar.delegate = self;
    self.textField.delegate = self;
    
    UIView *spacerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 10)];
    [self.textField setLeftViewMode:UITextFieldViewModeAlways];
    [self.textField setLeftView:spacerView];
    
    UIBarButtonItem *reduceBrowserButton = [[UIBarButtonItem alloc] initWithTitle:@"Reduce" style:UIBarButtonItemStylePlain target:self action:@selector(reduceWebViewWasPressed:)];
    self.navigationItem.rightBarButtonItem = reduceBrowserButton;
    
    UIBarButtonItem *fullScreenBrowserButton = [[UIBarButtonItem alloc] initWithTitle:@"Full Screen" style:UIBarButtonItemStylePlain target:self action:@selector(fullscreenWebViewWasPressed:)];
    self.navigationItem.rightBarButtonItem = fullScreenBrowserButton;
    
    for (UITabBarItem *tabBarItem in @[self.backButton, self.forwardButton, self.reloadButton, self.stopButton]) {
        
        tabBarItem.titlePositionAdjustment = UIOffsetMake(0.f, 50.f);
    }
    
    //self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.activityIndicator];
    
    self.activityIndicator.hidden = YES;
    
    NSLog(@"Load state is:%ld", self.loadState);
}

#pragma mark - Objects

//-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    UITouch *touch = [[event allTouches] anyObject];
//    CGPoint location = [touch locationInView:touch.view];
//    self.nodeContainer.center = location;
//}
//
//-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
//    [self touchesBegan:touches withEvent:event];
//}



#pragma mark - Web Browser

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    NSString *URLString = textField.text;
    NSString *query = nil;
    
    NSRange whiteSpaceRange = [URLString rangeOfCharacterFromSet:[NSCharacterSet whitespaceCharacterSet]];
    if (whiteSpaceRange.location != NSNotFound) {
        NSLog(@"Found White Space");
        query =[URLString stringByReplacingOccurrencesOfString:@" " withString:@"+"];
        NSLog(@"query is: %@", query);
    }
    
    NSURL *URL = [NSURL URLWithString:URLString];
    
    if (query) {
        URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://google.com/search?q=%@", query]];
        NSLog(@"URL is %@", [URL scheme]);
        NSLog(@"URL is %@", [URL host]);
        NSLog(@"URL is %@", [URL query]);
    }
    
    if (!URL.scheme && !query) {
        // The user didn't type http: or https:
        URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@", URLString]];
    }
    
    if (URL) {
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        [self.webView loadRequest:request];
    }
    
    return NO;
}


#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    self.frameCount++;
    [self updateButtonsAndTitle];
    [self fitContentForWebviewResize];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.frameCount--;
    [self updateButtonsAndTitle];
    [self fitContentForWebviewResize];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    if (error.code != -999) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", @"Error") message:[error localizedDescription] delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
        
        [alert show];
    }
    
    [self updateButtonsAndTitle];
    self.frameCount--;
}

- (void) updateButtonsAndTitle {
        NSString *webpageTitle = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
        if (webpageTitle) {
                self.title = webpageTitle;
            } else {
                    self.title = self.webView.request.URL.absoluteString;
                }
    
        if (self.frameCount > 0) {
            self.activityIndicator.hidden = NO;
               [self.activityIndicator startAnimating];
            } else {
                    [self.activityIndicator stopAnimating];
                self.activityIndicator.hidden = YES;
                }
    
        self.backButton.enabled = [self.webView canGoBack];
        self.forwardButton.enabled = [self.webView canGoForward];
        self.stopButton.enabled = self.frameCount > 0;
        self.reloadButton.enabled = !self.frameCount == 0;
}

- (void) resetWebView {
    
    self.textField.text = nil;
    [self updateButtonsAndTitle];
}

- (void) fitContentForWebviewResize {
    [self.webView stringByEvaluatingJavaScriptFromString:
     [NSString stringWithFormat:
      @"document.querySelector('meta[name=viewport]').setAttribute('content', 'width=%d;', false); ",
      (int)self.webView.frame.size.width]];
}

- (void)resizeWebView:(UIWebView *)webView {
    
    CGFloat statusHeight = 20.0;
    CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
    CGFloat totalTopBarHeight = statusHeight + navHeight;
    CGFloat viewWidth = self.view.frame.size.width;
    CGFloat viewHeight = self.view.frame.size.height;
    CGFloat textFieldHeight = self.textField.frame.size.height;
    CGFloat tabBarHeight = self.tabBar.frame.size.height;
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationCurveEaseInOut animations:^{
     
        
        self.webViewContainer.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + totalTopBarHeight, viewWidth, viewHeight);
        
        NSLog(@"resized container");
        
        //self.fullScreenBrowserButton.hidden = YES;
    } completion:^(BOOL finished) {
        NSLog(@"resize everything complete");

            self.webView.frame = CGRectMake(self.webViewContainer.frame.origin.x, self.webViewContainer.frame.origin.y - textFieldHeight, self.webViewContainer.frame.size.width, self.webViewContainer.frame.size.height - textFieldHeight);
            self.textField.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.webViewContainer.frame.size.width, self.textField.frame.size.height);
        self.tabBar.frame = CGRectMake(self.webViewContainer.frame.origin.x, CGRectGetMaxY(self.webViewContainer.frame) - (tabBarHeight * 2), viewWidth, tabBarHeight);
        NSLog(@"tabbar is located at x:%f y:%f", self.tabBar.frame.origin.x, self.tabBar.frame.origin.y);
        
    }];
    [self.navigationItem.rightBarButtonItem setTitle:@"Reduce"];
    [self.navigationItem.rightBarButtonItem setAction:@selector(reduceWebView:)];
    self.loadState = WebViewMaximised;
    
    NSLog(@"Load state is:%ld", self.loadState);
}

- (void)reduceWebView:(UIWebView *)webView {
    
    CGFloat statusHeight = 20.0;
    CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
    CGFloat totalTopBarHeight = statusHeight + navHeight;
    CGFloat viewHeight = self.view.frame.size.height;
    CGFloat reducedWidth = 320.0;
    //CGPoint framePosition = self.view.frame.origin;
    CGFloat defaultOrigin = CGRectGetMaxX(self.view.frame) - reducedWidth;
    CGFloat webViewContainerPadding = 5.0;
    CGFloat textFieldHeight = self.textField.frame.size.height;
    CGFloat tabBarHeight = self.tabBar.frame.size.height;
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationCurveEaseInOut animations:^{
    
        self.webViewContainer.frame = CGRectMake(defaultOrigin, self.view.frame.origin.y + totalTopBarHeight, reducedWidth, viewHeight);
        
    } completion:^(BOOL finished) {
        NSLog(@"reduce animation complete");
        
        self.webView.frame = CGRectMake(self.webViewContainer.frame.origin.x, self.webViewContainer.frame.origin.y - textFieldHeight, self.webViewContainer.frame.size.width, self.webViewContainer.frame.size.height - textFieldHeight);
        self.textField.frame = CGRectMake(self.webViewContainer.frame.origin.x, self.webViewContainer.frame.origin.y, self.webViewContainer.frame.size.width - webViewContainerPadding, self.textField.frame.size.height);
        self.tabBar.frame = CGRectMake(self.webViewContainer.frame.origin.x, CGRectGetMaxY(self.webViewContainer.frame), self.webViewContainer.frame.size.width - webViewContainerPadding, tabBarHeight);
        
        [self.webViewContainer insertSubview:self.webView atIndex:0];
        [self.webViewContainer insertSubview:self.textField aboveSubview:self.webView];
        [self.webViewContainer insertSubview:self.searchIconImage aboveSubview:self.textField];
        
        NSLog(@"webview origin x is %f", self.webView.frame.origin.x);
        NSLog(@"webview origin y is %f", self.webView.frame.origin.y);
        NSLog(@"textfield origin x is %f", self.textField.frame.origin.x);
        NSLog(@"textfield origin y is %f", self.textField.frame.origin.y);
    }];
     
    
    [self.navigationItem.rightBarButtonItem setTitle:@"Full Screen"];
    [self.navigationItem.rightBarButtonItem setAction:@selector(resizeWebView:)];
    self.loadState = WebViewMinimised;
    NSLog(@"Load state is:%ld", self.loadState);
}

#pragma mark - Actions

- (IBAction)fullscreenWebViewWasPressed:(id)sender {
    [self resizeWebView:self.webView];
}

- (IBAction)reduceWebViewWasPressed:(id)sender {
    [self reduceWebView:self.webView];
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    NSLog(@"Item title is %@", item.title);
    if([item.title isEqualToString:@"back"]) {
        // do something for this specific button
    } else if ([item.title isEqualToString:@"forward"]) {
        // do something for this specific button
    } else if ([item.title isEqualToString:@"reload"]) {
        // do something for this specific button
    } else if ([item.title isEqualToString:@"stop"]) {
        // do something for this specific button
    }
}



@end
