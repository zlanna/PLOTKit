//
//  PLTMarker.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 28.01.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTMarker.h"
#import "PLTCircleMarker.h"
#import "PLTSquareMarker.h"
#import "PLTTriangleMarker.h"
#import "PLTCrossMarker.h"

NSString *_Nonnull pltStringFromMarkerType(PLTMarkerType markerType){
  switch(markerType){
    case PLTMarkerCircle: {
      return @"PLTMarkerCircle";
    }
    case PLTMarkerSquare: {
      return @"PLTMarkerSquare";
    }
    case PLTMarkerTriangle: {
      return @"PLTMarkerTriangle";
    }
    case PLTMarkerCross: {
      return @"PLTMarkerCross";
    }
  }
}

@interface PLTMarker ()

@property(nonnull, nonatomic, strong) UIImage *markerImage;

@end


@implementation PLTMarker

@synthesize markerImage = _markerImage;
@synthesize color = _color;
@synthesize size = _size;

#pragma mark - Initialization

- (instancetype)init {
  self = [super init];
  if (self) {
    _color = [UIColor greenColor];
    _size = 4.0;
  }
  return self;
}

#pragma mark - Custom property getter

- (UIImage *)markerImage {
  if(_markerImage == nil){
    self.markerImage = [self createImage];
  }
  return _markerImage;
}

- (UIImage *)createImage {
  /*
    - (UIImage *)createImage never call directly from PLTMarker cause
    PLTMarker instance never create .
  */
  /*
   Sample of createImage code, that used in child classes.
   
  CGSize markerSize = CGSizeMake( 2*self.size, 2*self.size);
  
  UIGraphicsBeginImageContext(markerSize);
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSaveGState(context);
  
  CGContextSetFillColorWithColor(context, [self.color CGColor]);
  CGRect markerRect = CGRectMake(0.0, 0.0, 2*self.size, 2*self.size);
  
  CGContextAddEllipseInRect(context, markerRect);
  CGContextFillPath(context);
  
  UIImage *markerImage = UIGraphicsGetImageFromCurrentImageContext();
  CGContextRestoreGState(context);
  UIGraphicsEndImageContext();
  
  return markerImage;
  */
  return nil;
}

#pragma mark - Markers

+ (nonnull instancetype)markerWithType:(PLTMarkerType)markerType {
  PLTMarker *marker;
  switch (markerType) {
    case PLTMarkerCircle: {
      marker = [PLTCircleMarker new];
      break;
    }
    case PLTMarkerSquare: {
      marker = [PLTSquareMarker new];
      break;
    }
    case PLTMarkerTriangle: {
      marker = [PLTTriangleMarker new];
      break;
    }
    case PLTMarkerCross: {
      marker = [PLTCrossMarker new];
      break;
    }
  }
  return marker;
}

@end
