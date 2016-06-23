//
//  PLTAxisY.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 28.01.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTAxisView.h"
#import "PLTAxisYView.h"

@implementation PLTAxisYView

# pragma mark - View lifecicle

- (void)setNeedsDisplay {
  [super setNeedsDisplay];
  PLTAxisStyle *newStyle = [[self.styleSource styleContainer] axisYStyle];
  if (newStyle) {
    self.style = newStyle;
  }
  if (self.dataSource) {
    self.marksCount = [self.dataSource axisYMarksCount];
  }
}

# pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
  
  if(!self.style.hidden){
    
    [self drawAxisLine:rect];
    
    if(self.style.hasArrow){
      [self drawArrow:rect];
    }
  }

  if(self.style.hasMarks){
    [self drawMarks:rect];
  }
}

- (void)drawAxisLine:(CGRect)rect {
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSaveGState(context);
  
  CGContextSetLineWidth(context, self.style.axisLineWeight);
  CGContextSetStrokeColorWithColor(context, [self.style.axisColor CGColor]);
  
  CGFloat leftEgdeX = CGRectGetMinX(rect);
  CGFloat leftEdgeY = CGRectGetMinY(rect);
  CGFloat height = CGRectGetHeight(rect);
  
  CGPoint startPoint = CGPointMake(leftEgdeX + kPLTXOffset, leftEdgeY + kPLTYOffset);
  CGPoint endPoint = CGPointMake(startPoint.x, startPoint.y + height - 2*kPLTYOffset);
  
  CGContextMoveToPoint(context, startPoint.x, startPoint.y);
  CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
  CGContextStrokePath(context);
  
  CGContextRestoreGState(context);
}

- (void)drawArrow:(CGRect)rect {
  CGFloat arrowLenght =  12.0;
  CGFloat arrowWidth = 6.0;
  CGFloat leftEgdeX = CGRectGetMinX(rect);
  CGFloat leftEdgeY = CGRectGetMinY(rect);
  
  NSArray<NSValue *> *arrowPoints = @[
                                      [NSValue valueWithCGPoint:
                                       CGPointMake(leftEgdeX + kPLTXOffset - arrowWidth/2,
                                                   leftEdgeY + kPLTYOffset + arrowLenght)],
                                      
                                      [NSValue valueWithCGPoint:
                                       CGPointMake(leftEgdeX + kPLTXOffset,
                                                   leftEdgeY + kPLTYOffset)],
                                      
                                      [NSValue valueWithCGPoint:
                                       CGPointMake(leftEgdeX + kPLTXOffset + arrowWidth/2,
                                                   leftEdgeY + kPLTYOffset + arrowLenght)]
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
  CGFloat leftEgdeX = CGRectGetMinX(rect);
  CGFloat height = CGRectGetHeight(rect);

  if (self.style.isAutoformat) {
    if (self.marksCount > 0) {
      CGFloat deltaY = (height - 2*kPLTYOffset) / self.marksCount;
      CGFloat startPointX = leftEgdeX + kPLTXOffset;
      
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
        
        CGPoint markerPoint = CGPointMake(startPointX, i*deltaY + kPLTYOffset);
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

@end
