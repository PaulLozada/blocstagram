//
//  BLCCropImageViewController.h
//  Blocstagram
//
//  Created by Paul Lozada on 2015-04-27.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "BLCMediaFullScreenViewController.h"
#import <UIKit/UIKit.h>


@class BLCCropImageViewController;

@protocol BLCCropImageViewControllerDelegate <NSObject>

-(void) cropControllerFinishedWithImage : (UIImage *)croppedImage;

@end

@interface BLCCropImageViewController : BLCMediaFullScreenViewController


-(instancetype) initWithImage: (UIImage *) sourceImage;

@property (nonatomic,weak) NSObject <BLCCropImageViewControllerDelegate> *delegate;


@end
