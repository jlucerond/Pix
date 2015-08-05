//
//  Comment.h
//  Pix
//
//  Created by Joe Lucero on 8/4/15.
//  Copyright (c) 2015 Joe Lucero. All rights reserved.
//

#import <Foundation/Foundation.h>

@class  User;

@interface Comment : NSObject

@property (nonatomic, strong) User *from;
@property (nonatomic, strong) NSString *text;

@end
