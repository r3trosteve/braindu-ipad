//
//  BUDataSource.m
//  braindu-objc
//
//  Created by Steven Schofield on 12/08/2014.
//  Copyright (c) 2014 Double Digital. All rights reserved.
//

#import "BUDataSource.h"
#import "BUUser.h"
#import "BUChart.h"
#import "BUCard.h"

@interface BUDataSource ()

@property (nonatomic, strong) NSArray *cards;

@end

@implementation BUDataSource

+ (instancetype) sharedInstance {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype) init {
    self = [super init];
    
    if (self) {
        [self addRandomCharts];
    }
    
    return self;
}

- (void) addRandomCharts {
    NSMutableArray *randomCharts = [NSMutableArray array];
    
    for (int i = 1; i <= 10; i++) {
        NSString *imageName = [NSString stringWithFormat:@"%d.jpg", i];
        UIImage *image = [UIImage imageNamed:imageName];
    
        if (image) {
            BUChart *chart = [[BUChart alloc] init];
            chart.title = [NSString stringWithFormat:@"Test Chart %d", i];
            chart.image = image;
            chart.description = @"this is an example of a card Note";
        
            [randomCharts addObject:chart];
        
        }
    }
}

- (void) addRandomCards {
    NSMutableArray *randomCards = [NSMutableArray array];
    
    for (int i = 1; i <= 10; i++) {
        NSString *imageName = [NSString stringWithFormat:@"%d.jpg", i];
        UIImage *image = [UIImage imageNamed:imageName];
        
        if (image) {
            BUCard *card = [[BUCard alloc] init];
            card.title = [NSString stringWithFormat:@"Test Object %d", i];
            card.image = image;
            card.note = @"this is an example of a card Note";
            
            [randomCards addObject:card];
            
        }
        
        
    }
    
    self.cards = randomCards;
}

- (BUUser *) randomUser {
    BUUser *user = [[BUUser alloc] init];
    
    user.userName = [self randomStringOfLength:arc4random_uniform(10)];
    
    NSString *firstName = [self randomStringOfLength:arc4random_uniform(7)];
    NSString *lastName = [self randomStringOfLength:arc4random_uniform(12)];
    user.fullName = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
    
    return user;
}

- (NSString *) randomStringOfLength:(NSUInteger) len {
    NSString *alphabet = @"abcdefghijklmnopqrstuvwxyz";
    
    NSMutableString *s = [NSMutableString string];
    for (NSUInteger i = 0U; i < len; i++) {
        u_int32_t r = arc4random_uniform((u_int32_t)[alphabet length]);
        unichar c = [alphabet characterAtIndex:r];
        [s appendFormat:@"%C", c];
    }
    return [NSString stringWithString:s];
}



@end
