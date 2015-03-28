//
//  BLCDatasource.h
//  Blocstagram
//
//  Created by Paul Lozada on 2015-03-27.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BLCMedia;

@interface BLCDatasource : NSObject

+(instancetype) sharedInstance;

@property (nonatomic, strong, readonly) NSArray *mediaItems;

-(void)deleteMediaItem:(BLCMedia *)item;



@end
