//
//  BLCMediaFullScreenAnimator.h
//  Blocstagram
//
//  Created by Paul Lozada on 2015-03-31.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BLCMediaFullScreenAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@property(nonatomic,assign) BOOL presenting;
@property(nonatomic,weak) UIImageView *cellImageView;


@end
