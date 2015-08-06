//
//  Comment.m
//  Pix
//
//  Created by Joe Lucero on 8/4/15.
//  Copyright (c) 2015 Joe Lucero. All rights reserved.
//

#import "Comment.h"
#import "User.h"

@implementation Comment

- (instancetype) initWithDictionary: (NSDictionary *) commentDictionary {
//    @property (nonatomic, strong) User *from;
//    @property (nonatomic, strong) NSString *text;
    self = [super init];
    
    if (self) {
        self.idNumber = commentDictionary[@"id"];
        self.text = commentDictionary[@"text"];
        self.from = [[User alloc] initWithDictionary:commentDictionary[@"from"]];
    }
    
    return self;
}

@end
