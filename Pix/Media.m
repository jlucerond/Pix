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
            self.downloadState = MediaDownloadStateNeedsImage;
        }
        else self.downloadState = MediaDownloadStateNonRecoverableError;
        
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
        
        BOOL userHasLiked = [mediaDictionary[@"user_has_liked"] boolValue];
        self.likeState = userHasLiked ? LikeStateLiked : LikeStateNotLiked;
        
        NSDictionary *likesDictionary = mediaDictionary[@"likes"];
        id numberOfLikes = likesDictionary[@"count"];
        NSInteger hopefullyWorks = [numberOfLikes integerValue];
        self.numberOfLikes = hopefullyWorks;
    }
    
    return self;
}

#pragma mark - NSCoding

- (instancetype) initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    
    if (self) {
        self.idNumber = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(idNumber))];
        self.user = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(user))];
        self.mediaURL = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(mediaURL))];
        self.image = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(image))];
        if (self.image) {
            self.downloadState = MediaDownloadStateHasImage;
        }
        else if (self.mediaURL){
            self.downloadState = MediaDownloadStateNeedsImage;
        }
        else {
            self.downloadState = MediaDownloadStateNonRecoverableError;
        }
        self.caption = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(caption))];
        self.comments = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(comments))];
        self.likeState = [aDecoder decodeIntegerForKey:NSStringFromSelector(@selector(likeState))];
        self.numberOfLikes = [aDecoder decodeIntegerForKey:NSStringFromSelector(@selector(numberOfLikes))];
    }
    
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.idNumber forKey:NSStringFromSelector(@selector(idNumber))];
    [aCoder encodeObject:self.user forKey:NSStringFromSelector(@selector(user))];
    [aCoder encodeObject:self.mediaURL forKey:NSStringFromSelector(@selector(mediaURL))];
    [aCoder encodeObject:self.caption forKey:NSStringFromSelector(@selector(caption))];
    [aCoder encodeObject:self.comments forKey:NSStringFromSelector(@selector(comments))];
    [aCoder encodeInteger:self.likeState forKey:NSStringFromSelector(@selector(likeState))];
    [aCoder encodeInteger:self.numberOfLikes forKey:NSStringFromSelector(@selector(numberOfLikes))];
}

@end
