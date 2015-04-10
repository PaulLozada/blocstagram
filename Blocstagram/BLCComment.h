//
//  BLCComment.h
//  Blocstagram
//
//  Created by Paul Lozada on 2015-03-27.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BLCUser;


<<<<<<< HEAD
@interface BLCComment : NSObject<NSCoding>
=======
@interface BLCComment : NSObject <NSCoding>
>>>>>>> full-screen-images

@property (nonatomic, strong) NSString *idNumber;
@property (nonatomic, strong) BLCUser *from;
@property (nonatomic, strong) NSString *text;

- (instancetype) initWithDictionary:(NSDictionary *)commentDictionary;

@end
