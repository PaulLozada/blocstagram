//
//  BLCDatasource.h
//  Blocstagram
//
//  Created by Paul Lozada on 2015-03-27.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@class BLCMedia;

typedef void (^BLCNewItemCompletionBlock)(NSError *error);


@interface BLCDatasource : NSObject

extern NSString *const BLCImageFinishedNotification;


+(instancetype) sharedInstance;
+(NSString *) instagramClientID;


@property (nonatomic, strong, readonly) NSArray *mediaItems;
@property (nonatomic, strong, readonly) NSString *accessToken;

#pragma mark - Temporary

@property(nonatomic, strong,readonly) AFHTTPRequestOperationManager  *instagramOperationManager;



-(void)deleteMediaItem:(BLCMedia *)item;

-(void) requestNewItemsWithCompletionHandler: (BLCNewItemCompletionBlock)completionHandler;
- (void) requestOldItemsWithCompletionHandler:(BLCNewItemCompletionBlock)completionHandler;

-(void) downloadImageForMediaItem:(BLCMedia *)mediaItem;

- (void) toggleLikeOnMediaItem:(BLCMedia *)mediaItem;
- (void) commentOnMediaItem:(BLCMedia *)mediaItem withCommentText:(NSString *)commentText;



@end
