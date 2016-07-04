//
//  PLTAxisX.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 28.01.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTAxisView.h"
#import "PLTAxisXView.h"

@interface PLTAxisXView ()

@property(nonatomic) CGFloat yAxisOffset;

@end

@implementation PLTAxisXView

@synthesize yAxisOffset;

# pragma mark - View lifecicle

- (void)setNeedsDisplay {
  [super setNeedsDisplay];
  PLTAxisStyle *newStyle = [[self.styleSource styleContainer] axisXStyle];
  if (newStyle) {
    self.style = newStyle;
  }
  if (self.dataSource){
    self.marksCount = [self.dataSource axisXMarksCount];
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
}

- (void)drawAxisLine:(CGRect)rect {
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSaveGState(context);
  
  CGContextSetLineWidth(context, self.style.axisLineWeight);
  CGContextSetStrokeColorWithColor(context, [self.style.axisColor CGColor]);
  
  // Coordinate system of view not match to Cartesian, I need to conver x-axis.
  // TODO: May be the best dision is incapsulation of all conversions in object.
  CGFloat leftEgdeX = CGRectGetMinX(rect);
  CGFloat leftEdgeY = CGRectGetMinY(rect);
  CGFloat width = CGRectGetWidth(rect);
  //CGFloat height = CGRectGetHeight(rect);
  CGPoint startPoint = CGPointMake(leftEgdeX, leftEdgeY);
  CGPoint endPoint = CGPointMake(startPoint.x + width, startPoint.y);
  
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
  CGFloat width = CGRectGetWidth(rect);
  CGFloat height = CGRectGetHeight(rect);
  
  NSArray<NSValue *> *arrowPoints = @[
                                        [NSValue valueWithCGPoint:
                                         CGPointMake(leftEgdeX + width - arrowLenght,
                                                     leftEdgeY + height - arrowWidth/2)],
                                        
                                        [NSValue valueWithCGPoint:
                                         CGPointMake(leftEgdeX + width,
                                                     leftEdgeY + height)],
                                        
                                        [NSValue valueWithCGPoint:
                                         CGPointMake(leftEgdeX + width - arrowLenght,
                                                     leftEdgeY + height + arrowWidth/2)]
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
  CGFloat leftEdgeY = CGRectGetMinY(rect);
  CGFloat width = CGRectGetWidth(rect);
  //CGFloat height = CGRectGetHeight(rect);
  
  // FIXME: вторая ветка if если self.style.isAutoformat = NO
  if (self.style.isAutoformat) {
    if (self.marksCount > 0) {
      CGFloat deltaX = width / self.marksCount;
      CGFloat startPointY = leftEdgeY;
      
      switch (self.style.marksType) {
        case PLTMarksTypeCenter:
          startPointY -= markerLenght/2;
          break;
        case PLTMarksTypeInside:
          startPointY -= markerLenght;
          break;          
        case PLTMarksTypeOutside:
          break;
      }
      
      NSMutableArray<NSValue *> *markerPoints = [NSMutableArray<NSValue *> arrayWithCapacity:self.marksCount];
      
      for (NSUInteger i = 1; i < self.marksCount; ++ i) {
        CGPoint markerPoint = CGPointMake(i*deltaX, startPointY);
        [markerPoints addObject: [NSValue valueWithCGPoint:markerPoint]];
      }
      
      CGContextRef context = UIGraphicsGetCurrentContext();
      CGContextSaveGState(context);
      
      CGContextSetLineWidth(context, self.style.axisLineWeight);
      CGContextSetStrokeColorWithColor(context, [self.style.axisColor CGColor]);
      
      for (NSValue *pointContainer in markerPoints) {
        CGPoint startPoint = [pointContainer CGPointValue];
        CGPoint endPoint = CGPointMake(startPoint.x, startPoint.y + markerLenght);
        CGContextMoveToPoint(context, startPoint.x, startPoint.y);
        CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
        CGContextStrokePath(context);
      }
      
      CGContextRestoreGState(context);
    }
  }
}


@end
