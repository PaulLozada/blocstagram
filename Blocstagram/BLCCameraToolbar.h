//
//  BLCCameraToolbar.h
//  Blocstagram
//
//  Created by Paul Lozada on 2015-04-16.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BLCCameraToolbar;

@protocol BLCCameraToolbarDelegate <NSObject>

-(void) leftButtonPressedOnToolbar: (BLCCameraToolbar *)toolbar;
-(void) rightButtonPressedOnToolbar: (BLCCameraToolbar *)toolbar;
-(void) cameraButtonPressedOnToolbar:(BLCCameraToolbar *)toolbar;


@end

@interface BLCCameraToolbar : UIView

- (instancetype) initWithImageNames:(NSArray *)imageNames;

@property (nonatomic, weak) NSObject <BLCCameraToolbarDelegate> *delegate;


@end
