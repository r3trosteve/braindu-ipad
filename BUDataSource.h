//
//  BUDataSource.h
//  braindu-objc
//
//  Created by Steven Schofield on 12/08/2014.
//  Copyright (c) 2014 Double Digital. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BUDataSource : NSObject

+(instancetype) sharedInstance;
@property (nonatomic, strong, readonly) NSArray *objects;

@end
