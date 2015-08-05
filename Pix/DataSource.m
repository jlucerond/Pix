//
//  DataSource.m
//  Pix
//
//  Created by Joe Lucero on 8/4/15.
//  Copyright (c) 2015 Joe Lucero. All rights reserved.
//

#import "DataSource.h"
#import "User.h"
#import "Media.h"
#import "Comment.h"

@interface DataSource () {
    NSMutableArray *_mediaItems;
}

@property (nonatomic, strong, readwrite) NSArray *mediaItems;
@property (nonatomic, assign) BOOL isRefreshing;
@property (nonatomic, assign) BOOL isLoadingOlderItems;

@end

@implementation DataSource

#pragma mark - Public Methods

- (void) deleteMediaItem:(Media *) item {
    NSMutableArray *mutableArrayWithKVO = [self mutableArrayValueForKey:@"mediaItems"];
    [mutableArrayWithKVO removeObject:item];
}

- (void) requestNewItemsWithCompletionHandler:(NewItemCompletionBlock)completionHandler {
    if (self.isRefreshing == NO){
        self.isRefreshing = YES;
        
        // create new media item
        Media *media = [[Media alloc] init];
        media.user = [self randomUser];
        NSUInteger randomNumber = arc4random_uniform(10) +1;
        media.image = [UIImage imageNamed:[NSString stringWithFormat:@"%lu.jpg", randomNumber]];
        media.caption = [self randomSentence];
        media.comments = [self randomComments];
        
        NSMutableArray *mutableArrayWithKVO = [self mutableArrayValueForKey:@"mediaItems"];
        [mutableArrayWithKVO insertObject:media atIndex:0];
        
        self.isRefreshing = NO;
        
        if (completionHandler) {
            completionHandler(nil);
        }
    }
}

- (void) requestOldItemsWithCompletionHandler: (NewItemCompletionBlock) completionHandler{
    if (self.isLoadingOlderItems == FALSE){
        self.isLoadingOlderItems = TRUE;
        
        // create new media item
        Media *media = [[Media alloc] init];
        media.user = [self randomUser];
        NSUInteger randomNumber = arc4random_uniform(10) +1;
        media.image = [UIImage imageNamed:[NSString stringWithFormat:@"%lu.jpg", randomNumber]];
        media.caption = [self randomSentence];
        media.comments = [self randomComments];
        
        NSMutableArray *mutableArrayWithKVO = [self mutableArrayValueForKey:@"mediaItems"];
        [mutableArrayWithKVO addObject:media];
        
        self.isLoadingOlderItems = FALSE;
        
        if (completionHandler) {
            completionHandler(nil);
        }

    }
}

+ (NSString *) instagramClientID {
    return @"b6252ae8899f46729a82ecab577ab72e";
}

#pragma mark - Load/Initialize/Layout
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

#pragma mark - Helper Methods

- (void) addRandomData {
    NSMutableArray *randomMediaItems = [NSMutableArray array];
    
    for (int i = 1; i <= 10; i++) {
        NSString *imageName = [NSString stringWithFormat:@"%i.jpg", i];
        UIImage *image = [UIImage imageNamed:imageName];
        if (image) {
            Media *media = [[Media alloc] init];
            media.user = [self randomUser];
            media.image = image;
            media.caption = [self randomSentence];
            media.comments = [self randomComments];
            
            [randomMediaItems addObject:media];
        }
    }
    
    self.mediaItems = randomMediaItems;
}

- (User *) randomUser {
    User *user = [[User alloc] init];
    
    user.userName = [self randomStringOfLength:arc4random_uniform(5) + 5];
    NSString *firstName = [self randomStringOfLength:arc4random_uniform(7) + 3];
    NSString *lastName = [self randomStringOfLength:arc4random_uniform(5) + 5];
    user.fullName = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
    
    return user;
}

- (NSMutableArray *)randomComments {
    NSUInteger commentCount = arc4random_uniform(8) + 2;
    NSMutableArray *randomComments = [NSMutableArray array];
    
    for (int i = 0; i <= commentCount; i++) {
        Comment *randomComment = [self randomComment];
        [randomComments addObject:randomComment];
    }
    return randomComments;
}

- (Comment *) randomComment {
    Comment *comment = [[Comment alloc] init];
    comment.from = [self randomUser];
    comment.text = [self randomSentence];
    
    return comment;
}

- (NSString *) randomSentence {
    NSUInteger wordCount = arc4random_uniform(15) + 5;
    NSMutableString *randomSentence = [[NSMutableString alloc] init];
    
    for (int i = 0; i < wordCount; i++){
        NSString *randomWord = [self randomStringOfLength:arc4random_uniform(8) + 2];
        [randomSentence appendFormat:@"%@ ", randomWord];
    }
    
    return randomSentence;
}

- (NSString *) randomStringOfLength: (NSUInteger) len {
    NSString *alphabet = @"abcdefghijklmnopqrstuvwxyz";
    
    NSMutableString *s = [NSMutableString string];
    for (NSUInteger i = 0u; i < len; i++){
        u_int32_t r = arc4random_uniform((u_int32_t)[alphabet length]);
        unichar c = [alphabet characterAtIndex:r];
        [s appendFormat:@"%C", c];
    }
    
    return [NSString stringWithString:s];
    
}

#pragma mark - Key/Value Observing

- (NSUInteger) countOfMediaItems {
    return self.mediaItems.count;
}

- (id) objectInMediaItemsAtIndex:(NSUInteger)index {
    return [self.mediaItems objectAtIndex:index];
}

- (NSArray *) mediaItemsAtIndexes:(NSIndexSet *)indexes {
    return [self.mediaItems objectsAtIndexes:indexes];
}

- (void) insertObject:(Media *)object inMediaItemsAtIndex:(NSUInteger)index {
    [_mediaItems insertObject:object atIndex:index];
}

- (void) removeObjectFromMediaItemsAtIndex:(NSUInteger)index {
    [_mediaItems removeObjectAtIndex:index];
}

- (void) replaceObjectInMediaItemsAtIndex:(NSUInteger)index withObject:(id)object {
    [_mediaItems replaceObjectAtIndex:index withObject:object];
}

@end
