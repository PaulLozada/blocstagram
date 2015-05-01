//
//  BLCImageLibraryViewController.h
//  Blocstagram
//
//  Created by Paul Lozada on 2015-04-28.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BLCImageLibraryViewController;

@protocol BLCImageLibraryViewControllerDelegate <NSObject>

-(void) imageLibraryViewController : (BLCImageLibraryViewController *)imageLibraryViewController didCompleteWithImage:(UIImage*)image;


@end

@interface BLCImageLibraryViewController : UICollectionViewController

@property(nonatomic,weak) NSObject <BLCImageLibraryViewControllerDelegate> *delegate;

@end
