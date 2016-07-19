//
//  PLTGrid.m
//  PLOTKit
//
//  Created by ALEXEY ULENKOV on 28.01.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTGridView.h"
#import "PLTGridStyle.h"

typedef NSArray<NSNumber *> GridData;
typedef __kindof NSArray<NSValue *> GridPoints;

@interface PLTGridView ()

@property(nonatomic, strong, nonnull) PLTGridStyle *style;
@property(nonatomic, strong, nullable) GridData *xGridData;
@property(nonatomic, strong, nullable) GridData *yGridData;
@property(nonatomic, strong, readonly) GridPoints *xGridPoints;
@property(nonatomic, strong, readonly) GridPoints *yGridPoints;

@end


@implementation PLTGridView

@synthesize style = _style;
@synthesize xGridData;
@synthesize yGridData;

@synthesize xGridPoints = _xGridPoints;
@synthesize yGridPoints = _yGridPoints;

@synthesize xConstriction = _xConstriction;
@synthesize yConstriction = _yConstriction;

@synthesize styleSource;
@synthesize dataSource;

#pragma mark - Initialization

- (null_unspecified instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = [UIColor clearColor];
    
    _xConstriction = 0;
    _yConstriction = 0;
    _style = [PLTGridStyle blank];
  }
  return self;
}

- (null_unspecified instancetype)init {
  return [self initWithFrame: CGRectZero];
}

#pragma mark - View lifecycle
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wextra"
#pragma clang diagnostic ignored "-Wdirect-ivar-access"
- (void)setNeedsDisplay {
  [super setNeedsDisplay];
  PLTGridStyle *newStyle = [[self.styleSource styleContainer] gridStyle];
  if (newStyle) {
    self.style = newStyle;
  }
  if (self.dataSource) {
    self.xGridData = [self.dataSource xDataSet];
    self.yGridData = [self.dataSource yDataSet];
  }
  if (self.xGridData && self.yGridData) {
    _xGridPoints = [self computeXGridPoints];
    _yGridPoints = [self computeYGridPoints];
  }
}
#pragma mark - Custom properties

- (void)setXConstriction:(CGFloat)xConstriction{
  if(![@(_xConstriction)  isEqual: @(xConstriction)]){
    _xConstriction = xConstriction;
    [self setNeedsDisplay];
  }
}

- (void)setYConstriction:(CGFloat)yConstriction{
  if(![@(_yConstriction)  isEqual: @(yConstriction)]){
    _yConstriction = yConstriction;
    [self setNeedsDisplay];
  }
}

#pragma mark - Properties. Lazy initialization

- (GridPoints *)xGridPoints {
  if (_xGridPoints == nil) {
    _xGridPoints = [self computeXGridPoints];
  }
  return _xGridPoints;
}

- (GridPoints *)yGridPoints {
  if (_yGridPoints == nil) {
    _yGridPoints = [self computeYGridPoints];
  }
  return _yGridPoints;
}

#pragma clang diagnostic pop

- (GridPoints *)computeXGridPoints {
  CGRect rect = self.frame;
  NSUInteger gridLinesCount;
  
  gridLinesCount = self.xGridData.count - 1;
  GridPoints *gridPoints = [NSMutableArray<NSValue *> arrayWithCapacity:gridLinesCount];
  
  CGFloat width = CGRectGetWidth(rect) - self.xConstriction;
  CGFloat deltaXgrid = width / gridLinesCount;
  
  if (gridLinesCount > 0) {
    /*if (![@(self.xConstriction) isEqual:@(0)]) {
      CGPoint startPoint = CGPointMake(CGRectGetMinX(self.frame), 0.0);
      CGPoint endPoint = CGPointMake(CGRectGetMaxX(self.frame), 0.0);
      [gridPoints addObject:[NSValue valueWithCGPoint:startPoint]];
      [gridPoints addObject:[NSValue valueWithCGPoint:endPoint]];
    }*/
    for(NSUInteger i=0; i <= gridLinesCount; ++i) {
      CGPoint gridPoint = CGPointMake(self.xConstriction/2 + i*deltaXgrid, 0.0);
      [gridPoints addObject: [NSValue valueWithCGPoint:gridPoint]];
    }
  }
  else {
    CGPoint gridPoint = CGPointMake(self.xConstriction/2, 0.0);
    [gridPoints addObject: [NSValue valueWithCGPoint:gridPoint]];
  }
  
  return gridPoints;
}

- (GridPoints *)computeYGridPoints {
  CGRect rect = self.frame;
  NSUInteger gridLinesCount;
  
  gridLinesCount = self.yGridData.count - 1;
  GridPoints *gridPoints = [NSMutableArray<NSValue *> arrayWithCapacity:gridLinesCount];
  
  CGFloat height = CGRectGetHeight(rect);
  CGFloat deltaYgrid = height / gridLinesCount;
  
  for(NSUInteger i=0; i <= gridLinesCount; ++i) {
    CGPoint gridPoint = CGPointMake(0.0, i*deltaYgrid);
    [gridPoints addObject: [NSValue valueWithCGPoint:gridPoint]];
  }
  
  return gridPoints;
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
  if (self.xGridData && self.yGridData) {
    [self drawBackground:rect];
    
    //Draw vertical lines
    if (self.style.verticalGridlineEnable) {
      [self drawGridlinesWithPrepareBlock:^NSArray<NSValue *>* (CGContextRef context){
        CGContextSetStrokeColorWithColor(context, [self.style.verticalLineColor CGColor]);
        return self.xGridPoints;
      }
                                drawBlock:^(CGContextRef context, NSValue *pointContainer){
                                  CGPoint startPoint = [pointContainer CGPointValue];
                                  CGFloat height = CGRectGetHeight(rect);
                                  CGPoint endPoint = CGPointMake(startPoint.x, startPoint.y + height);
                                  CGContextMoveToPoint(context, startPoint.x, startPoint.y);
                                  CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
                                  CGContextStrokePath(context);
                                }];
    }
    
    //Draw horizontal lines
    if (self.style.horizontalGridlineEnable) {
      [self drawGridlinesWithPrepareBlock:^NSArray<NSValue *>* (CGContextRef context){
        CGContextSetStrokeColorWithColor(context, [self.style.horizontalLineColor CGColor]);
        return self.yGridPoints;
      }
                                drawBlock:^(CGContextRef context, NSValue *pointContainer){
                                  CGPoint startPoint = [pointContainer CGPointValue];
                                  CGFloat width = CGRectGetWidth(rect);
                                  CGPoint endPoint = CGPointMake(startPoint.x  + width, startPoint.y);
                                  CGContextMoveToPoint(context, startPoint.x, startPoint.y);
                                  CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
                                  CGContextStrokePath(context);
                                }];
    }
  }
}

- (void)drawBackground:(CGRect)rect {
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSetFillColorWithColor(context, [self.style.backgroundColor CGColor]);
  CGContextFillRect(context, rect);
}

- (void)drawGridlinesWithPrepareBlock:(NSArray * (^)(CGContextRef)) prepareBlock
                            drawBlock:(void (^)(CGContextRef,NSValue*)) drawBlock {
  
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSaveGState(context);
  CGContextSetLineWidth(context, self.style.lineWeight);
  
  switch (self.style.lineStyle) {
    case PLTLineStyleDash:
    {
      CGFloat dashes[] = {4,2};
      CGContextSetLineDash(context, 0.0, dashes, 2);
    }
      break;
    case PLTLineStyleDot:
    {
      CGFloat dashes[] = {2,2};
      CGContextSetLineDash(context, 0.0, dashes, 2);
    }
      break;
    case PLTLineStyleNone:
      break;
    case PLTLineStyleSolid:
      break;
  }
  NSArray *gridPoints = prepareBlock(context);

  for (NSValue *pointContainer in gridPoints) {
    drawBlock(context, pointContainer);
  }
  CGContextRestoreGState(context);
}

@end
