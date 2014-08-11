//
//  ViewController.m
//  braindu-objc
//
//  Created by Steven Schofield on 11/08/2014.
//  Copyright (c) 2014 Double Digital. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate, UITextFieldDelegate>

@property (nonatomic, assign) NSUInteger frameCount;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@end

@implementation ViewController

    

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView.delegate = self;
    self.textField.delegate = self;
    
    UIView *spacerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 10)];
    [self.textField setLeftViewMode:UITextFieldViewModeAlways];
    [self.textField setLeftView:spacerView];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.activityIndicator];
    
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:touch.view];
    self.nodeContainer.center = location;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchesBegan:touches withEvent:event];
}

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
               [self.activityIndicator startAnimating];
            } else {
                    [self.activityIndicator stopAnimating];
                }
    
        self.backButton.enabled = [self.webView canGoBack];
        self.forwardButton.enabled = [self.webView canGoForward];
        self.stopButton.enabled = self.frameCount > 0;
        self.reloadButton.enabled = !self.frameCount == 0;
}

- (void) resetWebView {
    [self.webView removeFromSuperview];
    
    UIWebView *newWebView = [[UIWebView alloc] init];
    newWebView.delegate = self;
    [self.view addSubview:newWebView];
    
    self.webView = newWebView;
    
    self.textField.text = nil;
    [self updateButtonsAndTitle];
}

- (void) fitContentForWebviewResize {
    [self.webView stringByEvaluatingJavaScriptFromString:
     [NSString stringWithFormat:
      @"document.querySelector('meta[name=viewport]').setAttribute('content', 'width=%d;', false); ",
      (int)self.webView.frame.size.width]];
}



@end
