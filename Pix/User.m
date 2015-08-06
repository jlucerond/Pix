//
//  User.m
//  Pix
//
//  Created by Joe Lucero on 8/4/15.
//  Copyright (c) 2015 Joe Lucero. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype) initWithDictionary: (NSDictionary *) userDictionary{
    self = [super init];
    
    if (self) {
//        @property (nonatomic, strong) NSString *idNumber;
//        @property (nonatomic, strong) NSString *userName;
//        @property (nonatomic, strong) NSString *fullName;
//        @property (nonatomic, strong) NSURL *profilePictureURL;
//        @property (nonatomic, strong) UIImage *profilePicture;
        
        self.idNumber = userDictionary[@"id"];
        self.userName = userDictionary[@"username"];
        self.fullName = userDictionary[@"full_name"];
        
        NSString *profileURLString = userDictionary[@"profile_picture"];
        NSURL *profileURL = [NSURL URLWithString:profileURLString];
        
        if (profileURL) {
            self.profilePictureURL = profileURL;
        }
    }
    
    return self;
}

@end
