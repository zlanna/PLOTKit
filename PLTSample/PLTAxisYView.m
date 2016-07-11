//
//  PLTAxisYView.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 28.01.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTAxisView.h"
#import "PLTAxisYView.h"
#import "PLTAxisYStyle.h"

typedef NSArray<NSNumber *> Data;
typedef __kindof NSArray<NSValue *> Points;

@interface PLTAxisYView ()

@property(nonatomic, strong, nullable) Data *data;
@property(nonatomic, strong, readonly) Points *points;

@end


@implementation PLTAxisYView

@synthesize data;
@synthesize points = _points;

# pragma mark - Initialization

- (null_unspecified instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.style = [PLTAxisYStyle blank];
  }
  return self;
}

# pragma mark - View lifecicle

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wextra"
#pragma clang diagnostic ignored "-Wdirect-ivar-access"
- (void)setNeedsDisplay {
  [super setNeedsDisplay];
  PLTAxisYStyle *newStyle = [[self.styleSource styleContainer] axisYStyle];
  if (newStyle) {
    self.style = newStyle;
  }
  if (self.dataSource){
    self.marksCount = [self.dataSource axisYMarksCount];
    self.data = [self.dataSource yDataSet];
  }
  if (self.data) {
    _points = [self computePoints];
    
  }
}
#pragma clang diagnostic pop

#pragma mark - Properties. Lazy initialization

- (Points *)points {
  if (_points == nil) {
    _points = [self points];
  }
  return _points;
}

- (Points *)computePoints {
  CGRect rect = self.frame;
  NSUInteger labelsCount;
  
  labelsCount = self.data.count - 1;
  Points *points = [NSMutableArray<NSValue *> arrayWithCapacity:labelsCount];
  
  CGFloat height = CGRectGetHeight(rect);
  CGFloat deltaYgrid = height / labelsCount;
  
  for(NSUInteger i=0; i <= labelsCount; ++i) {
    CGPoint point = CGPointMake(0.0, i*deltaYgrid);
    [points addObject: [NSValue valueWithCGPoint:point]];
  }
  
  return points;
}

# pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
  
  if (!self.style.hidden) {
    
    [self drawAxisLine:rect];
    
    if (self.style.hasArrow) {
      [self drawArrow:rect];
    }
  }

  if (self.style.hasMarks) {
    [self drawMarks:rect];
  }
  if (self.style.hasLabels) {
    [self drawLabels:rect];
  }
  [self drawAxisName];
}

- (void)drawAxisName {
  [self.axisNameLabel removeFromSuperview];
  if (self.axisName) {
    self.axisNameLabel = [[UILabel alloc] init];
    self.axisNameLabel.backgroundColor = [UIColor clearColor];
    self.axisNameLabel.textAlignment = NSTextAlignmentCenter;
    self.axisNameLabel.text = self.axisName;
    self.axisNameLabel.font = self.axisNameLabelFont;
    self.axisNameLabel.textColor = [UIColor blackColor];
    CGSize labelSize = [self.axisName sizeWithAttributes:@{NSFontAttributeName : (UILabel *_Nonnull)self.axisNameLabel.font}];
    
    CGFloat space = 10;
    CGFloat maxWidth = CGRectGetHeight(self.frame) - 2*space;
    if (labelSize.width>maxWidth) {
      labelSize.width = maxWidth;
    }
    
    self.axisNameLabel.frame = CGRectMake(0, 0, labelSize.width, labelSize.height);
    self.axisNameLabel.transform = CGAffineTransformMakeRotation(-M_PI_2);
    self.axisNameLabel.center = CGPointMake(CGRectGetMinX(self.bounds) + labelSize.height/2,
                                            CGRectGetMidY(self.bounds));
    [self addSubview: (UILabel *_Nonnull)self.axisNameLabel];
  }
}

- (void)drawAxisLine:(CGRect)rect {
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSaveGState(context);
  
  CGContextSetLineWidth(context, self.style.axisLineWeight);
  CGContextSetStrokeColorWithColor(context, [self.style.axisColor CGColor]);
  
  CGFloat rightEgdeX = CGRectGetMaxX(rect);
  CGFloat rightEdgeY = CGRectGetMinY(rect);
  CGFloat height = CGRectGetHeight(rect);
  
  CGPoint startPoint = CGPointMake(rightEgdeX, rightEdgeY);
  CGPoint endPoint = CGPointMake(startPoint.x, startPoint.y + height);
  
  CGContextMoveToPoint(context, startPoint.x, startPoint.y);
  CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
  CGContextStrokePath(context);
  
  CGContextRestoreGState(context);
}

// FIXME: Починить стрелку 
- (void)drawArrow:(CGRect)rect {
  CGFloat arrowLenght =  12.0;
  CGFloat arrowWidth = 6.0;
  CGFloat leftEgdeX = CGRectGetMinX(rect);
  CGFloat leftEdgeY = CGRectGetMinY(rect);
  
  NSArray<NSValue *> *arrowPoints = @[
                                      [NSValue valueWithCGPoint:
                                       CGPointMake(leftEgdeX - arrowWidth/2, leftEdgeY + arrowLenght)],
                                      
                                      [NSValue valueWithCGPoint:
                                       CGPointMake(leftEgdeX, leftEdgeY)],
                                      
                                      [NSValue valueWithCGPoint:
                                       CGPointMake(leftEgdeX + arrowWidth/2, leftEdgeY + arrowLenght)]
                                      ];
  
  CGContextRef ctx = UIGraphicsGetCurrentContext();
  CGContextBeginPath(ctx);
  
  CGContextMoveToPoint   (ctx, arrowPoints[0].CGPointValue.x, arrowPoints[0].CGPointValue.y);  // top left
  CGContextAddLineToPoint(ctx, arrowPoints[1].CGPointValue.x, arrowPoints[1].CGPointValue.y);  // mid right
  CGContextAddLineToPoint(ctx, arrowPoints[2].CGPointValue.x, arrowPoints[2].CGPointValue.y);  // bottom left
  
  CGContextClosePath(ctx);
  CGContextSetFillColorWithColor(ctx, [self.style.axisColor CGColor]);
  CGContextFillPath(ctx);
}

- (void)drawMarks:(CGRect)rect {
  CGFloat markerLenght = 6.0;
  CGFloat rightEgdeX = CGRectGetMaxX(rect);
  CGFloat height = CGRectGetHeight(rect);

  if (self.style.isAutoformat) {
    if (self.marksCount > 0) {
      CGFloat deltaY = height  / self.marksCount;
      CGFloat startPointX = rightEgdeX;
      
      switch (self.style.marksType) {
        case PLTMarksTypeCenter:
          startPointX -= markerLenght/2;
          break;
        case PLTMarksTypeInside:
          break;          
        case PLTMarksTypeOutside:
          startPointX -= markerLenght;
          break;
      }
      
      NSMutableArray<NSValue *> *markerPoints = [NSMutableArray<NSValue *> arrayWithCapacity:self.marksCount];
      
      for (NSUInteger i = 1; i < self.marksCount; ++ i) {
        
        CGPoint markerPoint = CGPointMake(startPointX, i*deltaY);
        [markerPoints addObject: [NSValue valueWithCGPoint:markerPoint]];
        
      }

      CGContextRef context = UIGraphicsGetCurrentContext();
      CGContextSaveGState(context);
      
      CGContextSetLineWidth(context, self.style.axisLineWeight);
      CGContextSetStrokeColorWithColor(context, [self.style.axisColor CGColor]);
      
      for (NSValue *pointContainer in markerPoints) {
        CGPoint startPoint = [pointContainer CGPointValue];
        CGPoint endPoint = CGPointMake(startPoint.x + markerLenght, startPoint.y);
        CGContextMoveToPoint(context, startPoint.x, startPoint.y);
        CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
        CGContextStrokePath(context);
      }
      
      CGContextRestoreGState(context);
    }
  }
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wextra"
- (void)drawLabels:(CGRect)rect {
 // PLTAxisYStyle *style = (PLTAxisYStyle *)self.style;
  
  CGFloat horizontalOffset = 0.0;
  /*switch (style.labelPosition) {
    case PLTAxisYLabelPositionLeft:
      horizontalOffset = 0.0;
      break;
    case PLTAxisYLabelPositionRight:
      horizontalOffset = CGRectGetWidth(rect);
      break;
    case PLTAxisYLabelPositionNone:
      break;
  }*/
  
  [self removeOldLabels: self.labels];
  
  UIFont *labelFont = [UIFont systemFontOfSize:9.0];
  CGFloat xRightEdge = CGRectGetMaxX(rect);
  
  // Создание массива индексированного фреймов
  NSMutableArray *indexingFrames = [[NSMutableArray alloc] initWithCapacity:self.points.count];
  for (NSUInteger i=0; i < self.points.count; ++i) {
    CGPoint currentPoint = [self.points[i] CGPointValue];
    NSString *labelText = [self.data[self.data.count - i - 1] stringValue];
    CGSize labelSize = [labelText sizeWithAttributes:@{NSFontAttributeName : self.axisLabelsFont}];
    labelSize.width = [self limitedWidth:labelSize.width];
    CGRect markerLabelFrame = CGRectMake(xRightEdge - labelSize.width + horizontalOffset - kPLTLabelToAxisOffset/2,
                                         currentPoint.y - labelSize.height/2,
                                         labelSize.width,
                                         labelSize.height);
    [indexingFrames addObject: [NSArray arrayWithObjects:@(i), [NSValue valueWithCGRect:markerLabelFrame],nil]];
  }
  
  // Проходим по массиву и удаляем перекрытия
  BOOL isScanAllValues = NO;
  while (!isScanAllValues && indexingFrames.count>1) {
    
    for (NSUInteger i=0; i < indexingFrames.count-1; ++i) {
      CGRect currentFrame = [indexingFrames[i][1] CGRectValue];
      CGRect nextFrame = [indexingFrames[i+1][1] CGRectValue];
      if (CGRectGetMaxY(currentFrame)>CGRectGetMinY(nextFrame)) {
        break;
      }
      if (i == indexingFrames.count-2) {
        isScanAllValues = YES;
      }
    }
    
    if (!isScanAllValues) {
      @autoreleasepool {
        NSMutableArray *tmp = [NSMutableArray arrayWithCapacity:indexingFrames.count/2];
        for (NSUInteger i=0; i<indexingFrames.count; ++i){
          if(i%2 == 0) {
            [tmp addObject:indexingFrames[i]];
          }
        }
        [indexingFrames setArray:tmp];
      }
    }
  }
  
  for (NSArray *container in indexingFrames){
    NSUInteger labelIndex = [container[0] unsignedIntegerValue];
    CGRect markerLabelFrame = [container[1] CGRectValue];
    UILabel *markerLabel = [[UILabel alloc] initWithFrame: markerLabelFrame];
    markerLabel.textAlignment = NSTextAlignmentRight;
    markerLabel.text = [self.data[self.data.count - labelIndex - 1] stringValue];
    markerLabel.textColor = self.style.labelFontColor;
    markerLabel.font = labelFont;
    [self addSubview:markerLabel];
    [self.labels addObject:markerLabel];
  }
}
#pragma clang diagnostic pop

- (CGFloat)limitedWidth:(CGFloat)width {
  CGFloat newWidth = (width>kPLTMaxAxisLabelWidth)?kPLTMaxAxisLabelWidth:width;
  return newWidth;
}

#pragma mark - Label drawing helper

- (void)removeOldLabels:(LabelsCollection *)collection {
  for(UILabel *label in collection) {
    [label removeFromSuperview];
  }
  [collection removeAllObjects];
}

#pragma mark - PLTAutolayoutWidth

static CGFloat const minWidth = 10.0;

- (CGFloat)viewRequaredWidth {
  CGFloat width = minWidth;
  if (self.style.hasLabels) {
    width += [self maxLabelWidth];
  }
  if (self.axisName) {
    CGSize labelSize = [self.axisName sizeWithAttributes:@{NSFontAttributeName : self.axisNameLabelFont}];
    width += labelSize.height;
  }
  return width;
}

- (CGFloat)maxLabelWidth {
  CGFloat maxWidth = 0;
  if (self.dataSource) {
     self.data = [self.dataSource yDataSet];
  }
  for (NSNumber *value in self.data) {
    CGFloat currentWidth = [[value stringValue] sizeWithAttributes:@{NSFontAttributeName : self.axisLabelsFont}].width;
    maxWidth = maxWidth>currentWidth?maxWidth:currentWidth;
  }
  return maxWidth;
}

@end
