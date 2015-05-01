//
//  BLCMediaFullScreenViewController.h
//  Blocstagram
//
//  Created by Paul Lozada on 2015-03-31.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BLCMedia;

@interface BLCMediaFullScreenViewController : UIViewController


@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic,strong) BLCMedia *media;


-(instancetype) initWithMedia : (BLCMedia *)media;

-(void)centerScrollView;

-(void)recalculateZoomScale;

@end
