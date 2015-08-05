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

+(instancetype) sharedInstance;
+(NSString *) instagramClientID;
- (void) deleteMediaItem:(Media *)item;
- (void) requestNewItemsWithCompletionHandler: (NewItemCompletionBlock) completionHandler;
- (void) requestOldItemsWithCompletionHandler: (NewItemCompletionBlock) completionHandler;

@end
