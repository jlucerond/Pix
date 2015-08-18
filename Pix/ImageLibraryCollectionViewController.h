//
//  ImageLibraryCollectionViewController.h
//  Blocstagram
//
//  Created by Joe Lucero on 6/3/15.
//  Copyright (c) 2015 Joe Lucero. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ImageLibraryCollectionViewController;

@protocol ImageLibraryCollectionViewControllerDelegate <NSObject>

- (void) imageLibraryViewController: (ImageLibraryCollectionViewController *)imageLibraryCollectionViewController didCompleteWithImage:(UIImage *)image;

@end

@interface ImageLibraryCollectionViewController : UICollectionViewController

@property (nonatomic, weak) NSObject <ImageLibraryCollectionViewControllerDelegate> *delegate;

@end
