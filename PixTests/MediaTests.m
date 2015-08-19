//
//  MediaTests.m
//  Pix
//
//  Created by Joe Lucero on 8/19/15.
//  Copyright (c) 2015 Joe Lucero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Media.h"
#import "Comment.h"
#import "User.h"

@interface MediaTests : XCTestCase

@end

@implementation MediaTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void) testInitializer {
    NSArray *randomMediaItems = [self addRandomData];
    NSLog(@"%ld", randomMediaItems.count);
    for (Media *mediaItem in randomMediaItems){
        XCTAssertNotNil(mediaItem.user);
    }
}

# pragma  mark - creates random data for testing purposes
- (NSArray *) addRandomData {
    NSMutableArray *randomMediaItems = [NSMutableArray array];

    for (int i = 1; i <= 10; i++) {

            Media *media = [[Media alloc] init];
            media.user = [self randomUser];
            media.caption = [self randomSentence];

            NSUInteger commentCount = arc4random_uniform(10) + 2;
            NSMutableArray *randomComments = [NSMutableArray array];

            for (int i  = 0; i <= commentCount; i++) {
                Comment *randomComment = [self randomComment];

                [randomComments addObject:randomComment];
            }

            media.comments = randomComments;

            [randomMediaItems addObject:media];
    }

    return randomMediaItems;
}

- (User *) randomUser {
    User *user = [[User alloc] init];

    user.userName = [self randomStringOfLength:arc4random_uniform(10) + 2];

    NSString *firstName = [self randomStringOfLength:arc4random_uniform(7) + 2];
    NSString *lastName = [self randomStringOfLength:arc4random_uniform(12) + 2];
    user.fullName = [NSString stringWithFormat:@"%@ %@", firstName, lastName];

    return user;
}

- (Comment *) randomComment {
    Comment *comment = [[Comment alloc] init];

    comment.from = [self randomUser];

    NSUInteger wordCount = arc4random_uniform(20) + 2;

    NSMutableString *randomSentence = [[NSMutableString alloc] init];

    for (int i  = 0; i <= wordCount; i++) {
        NSString *randomWord = [self randomStringOfLength:arc4random_uniform(12) + 2];
        [randomSentence appendFormat:@"%@ ", randomWord];
    }

    comment.text = randomSentence;

    return comment;
}

- (NSString *) randomSentence {
    NSUInteger wordCount = arc4random_uniform(20) + 2;

    NSMutableString *randomSentence = [[NSMutableString alloc] init];

    for (int i  = 0; i <= wordCount; i++) {
        NSString *randomWord = [self randomStringOfLength:arc4random_uniform(12) + 2];
        [randomSentence appendFormat:@"%@ ", randomWord];
    }

    return randomSentence;
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
