//
//  BLCMedia.h
//  Blocstagram
//
//  Created by Paul Lozada on 2015-03-27.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BLCLikeButton.h"

typedef NS_ENUM(NSInteger, BLCMediaDownloadState) {
    BLCMediaDownloadStateNeedsImage                     = 0,
    BLCMediaDownloadStateDownloadInProgress         = 1,
    BLCMediaDownloadStateNonRecoverableError        = 2,
    BLCMediaDownloadStateHasImage                          = 3
};


@class BLCUser;

@interface BLCMedia : NSObject <NSCoding>

@property (nonatomic, strong) NSString *idNumber;
@property (nonatomic, strong) BLCUser *user;
@property (nonatomic, strong) NSURL *mediaURL;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) BLCMediaDownloadState downloadState;
@property (nonatomic, strong) NSString *caption;
@property (nonatomic, strong) NSArray *comments;
@property (nonatomic, assign) BLCLikeState likeState;
@property (nonatomic, strong) NSString *temporaryComment;
@property (nonatomic,strong) UILabel *numberOfLikesLabel;
@property (nonatomic,assign) NSInteger likeCount;

- (instancetype) initWithDictionary:(NSDictionary *)mediaDictionary;

@end
