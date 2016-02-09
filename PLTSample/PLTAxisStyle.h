//
//  PLTAxisStyle.h
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 04.02.16.
//  Copyright © 2016 Alexey Ulenkov (FBSoftware). All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef enum PLTMarksType{
  PLTMarksTypeCenter,
  PLTMarksTypeInside,
  PLTMarksTypeOutside
}PLTMarksType;


@interface PLTAxisStyle : NSObject

@property(nonatomic) BOOL hidden;
@property(nonatomic) BOOL hasArrow;
@property(nonatomic) BOOL hasName;
@property(nonatomic) BOOL hasMarks;
@property(nonatomic) BOOL isAutoformat;
@property(nonatomic) PLTMarksType marksType;
@property(nonatomic, strong, nullable) UIColor *axisColor;
@property(nonatomic) float axisLineWeight;

+ (nonnull PLTAxisStyle *)defaultStyle;

@end
