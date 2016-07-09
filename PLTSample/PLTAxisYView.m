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


@implementation PLTAxisYView

@dynamic axisName;

# pragma mark - Initialization

- (null_unspecified instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.style = [PLTAxisYStyle blank];
  }
  return self;
}

# pragma mark - View lifecicle

- (void)setNeedsDisplay {
  [super setNeedsDisplay];
  PLTAxisYStyle *newStyle = [[self.styleSource styleContainer] axisYStyle];
  if (newStyle) {
    self.style = newStyle;
  }
  if (self.dataSource) {
    self.marksCount = [self.dataSource axisYMarksCount];
  }
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

- (void)drawLabels:(CGRect)rect {
  PLTAxisYStyle *style = (PLTAxisYStyle *)self.style;
  
  CGFloat horizontalOffset = 0.0;
  switch (style.labelPosition) {
    case PLTAxisYLabelPositionLeft:
      horizontalOffset = 0.0;
      break;
    case PLTAxisYLabelPositionRight:
      horizontalOffset = CGRectGetWidth(rect);
      break;
    case PLTAxisYLabelPositionNone:
      break;
  }
  
  [self removeOldLabels: self.labels];
  
  UIFont *labelFont = [UIFont systemFontOfSize:9.0];
  
  // Создание массива индексированного фреймов
  NSMutableArray *indexingFrames = [[NSMutableArray alloc] initWithCapacity:self.yGridPoints.count];
  for (NSUInteger i=0; i < self.yGridPoints.count; ++i) {
    CGPoint currentPoint = [self.yGridPoints[i] CGPointValue];
    NSString *labelText = [self.yGridData[self.yGridData.count - i - 1] stringValue];
    CGSize labelSize = [labelText sizeWithAttributes:@{NSFontAttributeName : labelFont}];
    CGRect markerLabelFrame = CGRectMake(currentPoint.x - labelSize.width + horizontalOffset - 10,
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
    markerLabel.text = [self.yGridData[self.yGridData.count - labelIndex - 1] stringValue];
    markerLabel.textColor = self.style.labelFontColor;
    markerLabel.font = labelFont;
    [self addSubview:markerLabel];
    [self.labels addObject:markerLabel];
  }
}

#pragma mark - Label drawing helber

- (void)removeOldLabels:(LabelsCollection *)collection {
  for(UILabel *label in collection) {
    [label removeFromSuperview];
  }
  [collection removeAllObjects];
}

@end
