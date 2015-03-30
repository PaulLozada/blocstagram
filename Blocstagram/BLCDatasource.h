//
//  BLCDatasource.h
//  Blocstagram
//
//  Created by Paul Lozada on 2015-03-27.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BLCMedia;

typedef void (^BLCNewItemCompletionBlock)(NSError *error);


@interface BLCDatasource : NSObject

+(instancetype) sharedInstance;
+(NSString *) instagramClientID;


@property (nonatomic, strong, readonly) NSArray *mediaItems;
@property (nonatomic, strong, readonly) NSString *accessToken;


-(void)deleteMediaItem:(BLCMedia *)item;

-(void) requestNewItemsWithCompletionHandler: (BLCNewItemCompletionBlock)completionHandler;
- (void) requestOldItemsWithCompletionHandler:(BLCNewItemCompletionBlock)completionHandler;



@end
