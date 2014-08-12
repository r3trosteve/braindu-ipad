//
//  BUChart.h
//  braindu-objc
//
//  Created by Steven Schofield on 12/08/2014.
//  Copyright (c) 2014 Double Digital. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class BUUser;

@interface BUChart : NSObject

@property (strong, nonatomic) NSString *idNumber;
 @property (nonatomic, strong) BUUser *user;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) UIImage *image;

@end
