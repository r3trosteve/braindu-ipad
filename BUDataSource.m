//
//  BUDataSource.m
//  braindu-objc
//
//  Created by Steven Schofield on 12/08/2014.
//  Copyright (c) 2014 Double Digital. All rights reserved.
//

#import "BUDataSource.h"
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
        [self addRandomData];
    }
    
    return self;
}

- (void) addRandomData {
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



@end
