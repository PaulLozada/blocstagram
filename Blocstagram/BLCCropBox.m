//
//  BLCCropBox.m
//  Blocstagram
//
//  Created by Paul Lozada on 2015-04-27.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "BLCCropBox.h"

@interface BLCCropBox ( )

@property (nonatomic,strong) NSArray *horiztonalLines;
@property (nonatomic,strong) NSArray *verticalLines;


@end


@implementation BLCCropBox



-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        self.userInteractionEnabled = NO;
        
        // Initialization code
        
        NSArray *lines = [self.horiztonalLines arrayByAddingObjectsFromArray:self.verticalLines];
        for (UIView *lineView in lines) {
            [self addSubview:lineView];
            
        }
    }
    
    return self;
    
}

-(NSArray *) horiztonalLines {
    if (!_horiztonalLines) {
        _horiztonalLines  = [self newArrayOfFourWhiteViews];
    }
    
    return _horiztonalLines;
}

-(NSArray *)verticalLines{
    if (!_verticalLines) {
        _verticalLines = [self newArrayOfFourWhiteViews];
    }
    return _verticalLines;
}

-(NSArray *) newArrayOfFourWhiteViews{
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (int i = 0; i  < 4; i++) {
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        [array addObject:view];
    }
    
    return array;
    
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat thirdOfWidth = width / 3;
    
    for (int i = 0 ; i < 4; i++) {
        
        UIView *horizontalLine = self.horiztonalLines[i];
        UIView *verticalLine = self.verticalLines[i];
        
        horizontalLine.frame = CGRectMake(0, (i * thirdOfWidth), width, 0.5);
        
        CGRect verticalFrame = CGRectMake(i * thirdOfWidth, 0, 0.5, width);
        
        if (i == 3) {
            verticalFrame.origin.x -= 0.5;
            
        }
        
        verticalLine.frame = verticalFrame;
        
    }
}

@end
