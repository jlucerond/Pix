//
//  Media.m
//  Pix
//
//  Created by Joe Lucero on 8/4/15.
//  Copyright (c) 2015 Joe Lucero. All rights reserved.
//

#import "Media.h"
#import "User.h"
#import "Comment.h"

@implementation Media

- (instancetype) initWithDictionary: (NSDictionary *) mediaDictionary{
    self = [super init];
    
    if (self) {
        self.idNumber = mediaDictionary[@"id"];
        self.user = [[User alloc] initWithDictionary:mediaDictionary[@"user"]];
        NSString *standardResolutionImageURLString = mediaDictionary[@"images"][@"standard_resolution"][@"url"];
        NSURL *standardResolutionImageURL = [NSURL URLWithString:standardResolutionImageURLString];
        
        if (standardResolutionImageURL){
            self.mediaURL = standardResolutionImageURL;
        }
        
        NSDictionary *captionDictionary = mediaDictionary[@"caption"];
        if ([captionDictionary isKindOfClass:[NSDictionary class]]){
            self.caption = captionDictionary[@"text"];
        }
        else self.caption = @"";
        
        NSMutableArray *commentsArray = [NSMutableArray array];
        
        for (NSDictionary *commentDictionary in mediaDictionary[@"comments"][@"data"]){
            Comment *newComment = [[Comment alloc] initWithDictionary:commentDictionary];
            [commentsArray addObject:newComment];
        }
        
        self.comments = commentsArray;
        
    }
    
    return self;
}

@end
