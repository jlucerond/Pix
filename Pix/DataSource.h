//
//  DataSource.h
//  Pix
//
//  Created by Joe Lucero on 8/4/15.
//  Copyright (c) 2015 Joe Lucero. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Media;

typedef void (^NewItemCompletionBlock)(NSError *error);

@interface DataSource : NSObject

@property (nonatomic, strong, readonly) NSArray *mediaItems;
@property (nonatomic, strong, readonly) NSString *accessToken;

+(instancetype) sharedInstance;
+(NSString *) instagramClientID;
- (void) deleteMediaItem:(Media *)item;
- (void) downloadImageForMediaItem: (Media *)mediaItem;
- (void) toggleLikeOnMediaItem:(Media *)mediaItem withCompletionHandler:(void (^)(void))completionHandler;
- (void) commentOnMediaItem: (Media *)mediaItem withCommentText: (NSString *)commentText;
- (void) requestNewItemsWithCompletionHandler: (NewItemCompletionBlock) completionHandler;
- (void) requestOldItemsWithCompletionHandler: (NewItemCompletionBlock) completionHandler;

@end
