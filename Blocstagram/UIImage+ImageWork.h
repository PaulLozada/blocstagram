//
//  UIImage+ImageWork.h
//  Blocstagram
//
//  Created by Paul Lozada on 2015-04-18.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageWork)

- (UIImage *) imageByScalingToSize:(CGSize)size andCroppingWithRect:(CGRect)rect;

@end
