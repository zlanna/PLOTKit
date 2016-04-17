//
//  PLTAxisX.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 28.01.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTAxisView.h"
#import "PLTAxisXView.h"
#import "PLTAxisStyle.h"

@interface PLTAxisXView ()

@property(nonatomic) NSUInteger marksCount;
@property(nonatomic, strong, nullable) PLTAxisStyle *style;

@end


@implementation PLTAxisXView

@synthesize marksCount;
@synthesize style;

# pragma mark - View lifecicle

- (void)willMoveToSuperview:(UIView *)newSuperview {
  [super willMoveToSuperview:newSuperview];
  self.style = [[self.delegate styleContainer] axisXStyle];
  //???: С этой проверкой могут быть проблемы
  if ([self.delegate respondsToSelector: @selector(axisXMarksCount)]) {
    self.marksCount = [self.delegate axisXMarksCount];
  }
  else {
    //TODO: Возможно тут стоит выбросить исключение, либо какой-то другой сценарий обработки
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
  
  // Так координаты view не совпадают с декартовыми нужно перенести ось x "вниз".
  // TODO: Возможно стоит все преобразования инкапсулировать в объект
  CGFloat leftEgdeX = CGRectGetMinX(rect);
  CGFloat leftEdgeY = CGRectGetMinY(rect);
  CGFloat width = CGRectGetWidth(rect);
  CGFloat height = CGRectGetHeight(rect);
  CGPoint startPoint = CGPointMake(leftEgdeX + PLT_X_OFFSET, leftEdgeY + height - PLT_Y_OFFSET);
  CGPoint endPoint = CGPointMake(startPoint.x + width - 2*PLT_X_OFFSET, startPoint.y);
  
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
  CGFloat width = CGRectGetWidth(rect);
  CGFloat height = CGRectGetHeight(rect);
  
  NSArray<NSValue *> *arrowPoints = @[
                                        [NSValue valueWithCGPoint:
                                         CGPointMake(leftEgdeX + width - PLT_X_OFFSET - arrowLenght,
                                                     leftEdgeY + height - PLT_Y_OFFSET - arrowWidth/2)],
                                        
                                        [NSValue valueWithCGPoint:
                                         CGPointMake(leftEgdeX + width - PLT_X_OFFSET,
                                                     leftEdgeY + height - PLT_Y_OFFSET)],
                                        
                                        [NSValue valueWithCGPoint:
                                         CGPointMake(leftEgdeX + width - PLT_X_OFFSET - arrowLenght,
                                                     leftEdgeY + height - PLT_Y_OFFSET + arrowWidth/2)]
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
  CGFloat height = CGRectGetHeight(rect);
  
  if (self.style.isAutoformat) {
    self.marksCount = [self.delegate axisXMarksCount];
    
    CGFloat deltaX = (width - 2*PLT_X_OFFSET) / self.marksCount;
    CGFloat startPointY = leftEdgeY + height - PLT_Y_OFFSET;
    
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
      
        CGPoint markerPoint = CGPointMake(i*deltaX + PLT_X_OFFSET, startPointY);
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


@end
