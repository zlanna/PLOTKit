//
//  PLTLinearChart.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 06.02.16.
//  Copyright © 2016 Alexey Ulenkov (FBSoftware). All rights reserved.
//

#import "PLTLinearChart.h"
#import "PLTLinearChartStyle.h"
#import "PLTConstants.h"


//TODO: Подумать над именами ключей
NSString const *kX = @"X";
NSString const *kY = @"Y";

@interface PLTLinearChart ()

@property(nonatomic, strong) PLTLinearChartStyle *chartStyle;
@property(nonatomic, strong) NSArray<NSValue *> *chartPoints;

@end


@implementation PLTLinearChart

@synthesize delegate;
@synthesize chartData = _chartData;
@synthesize chartStyle = _chartStyle;
@synthesize chartPoints;

#pragma mark - Initialization

//TODO: Перегрузить инициализаторы по умолчанию

- (nonnull instancetype)initWithStyle:(nonnull PLTLinearChartStyle *) style {

  if (self = [super initWithFrame:CGRectZero]) {
    _chartStyle = style;
    self.backgroundColor = [UIColor clearColor];
    //Fake data
    _chartData = @{
                    kX:@[@0,@10,@20,@30,@40,@50,@60,@70,@80,@90,@100],
                    kY:@[@0,@3,@5,@5,@2,@2,@2,@3,@3,@3,@1]
                   };
  }

  return self;
}

#pragma mark - View lifecycle

- (void)willMoveToSuperview:(UIView *)newSuperview {
  [super willMoveToSuperview:newSuperview];
  self.frame = [self.delegate chartFrame];
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
  
  if (self.chartData != nil) {
    
    [self drawLine:rect];
    
    if (self.chartStyle.hasFilling) {
      [self drawFill:rect];
    }
    
    if (self.chartStyle.hasMarkers) {
      [self drawMarkers];
    }
    
  }
  
}

- (void)drawLine:(CGRect)rect {
  self.chartPoints = [self prepareChartPoints:rect];
  
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSaveGState(context);
  
  CGContextSetStrokeColorWithColor(context, [self.chartStyle.chartLineColor CGColor]);
  CGContextSetLineWidth(context, 2.0f);
  
  CGPoint currentPoint = [self.chartPoints[0] CGPointValue];
  CGContextMoveToPoint(context, currentPoint.x, currentPoint.y);
  
  for (NSValue *pointContainer in self.chartPoints) {
    CGPoint nextPoint = [pointContainer CGPointValue];
    //Тут можно вставить код для интерполяции
    //CGContextAddQuadCurveToPoint(context, 0.0, 0.0, nextPoint.x, nextPoint.y);
    CGContextAddLineToPoint(context, nextPoint.x, nextPoint.y);
  }
  
  CGContextStrokePath(context);
  CGContextRestoreGState(context);
}

- (NSArray<NSValue *> *)prepareChartPoints:(CGRect) rect{
  
  NSArray<NSNumber *> *xComponents = self.chartData[kX];
  NSArray<NSNumber *> *yComponents = self.chartData[kY];
  
  //TODO: Вот где-то здесь прячется автоформатирование
  NSUInteger gridCountY = 10;
  NSUInteger gridCountX = 10;
  
  CGFloat deltaX = (rect.size.width - 2*PLT_X_OFFSET) / gridCountX;
  CGFloat deltaY = (rect.size.height - 2*PLT_Y_OFFSET) / gridCountY;
  
  CGFloat axisXstartPoint = ([xComponents[0] floatValue] / gridCountX)*deltaX;
  
  NSMutableArray<NSValue *> *points = [NSMutableArray<NSValue *> arrayWithCapacity:xComponents.count];
  
  if (xComponents.count == yComponents.count) {
    for (NSUInteger i=0; i < xComponents.count; ++i) {
      [points addObject:
       [NSValue valueWithCGPoint:
        CGPointMake(axisXstartPoint + i*deltaX + PLT_X_OFFSET,
          rect.size.height - ([yComponents[i] floatValue]*deltaY + PLT_Y_OFFSET))]];
    }
  }
  else {
    //TODO: Добавить выброс исключения
    /*
    @throw [NSException exceptionWithName:
     */
  }
  return points;
}

- (void)drawFill:(CGRect)rect {

  CGColorRef startColor = [[[UIColor whiteColor] colorWithAlphaComponent:0.5]CGColor];
  CGColorRef endColor = [[self.chartStyle.chartLineColor colorWithAlphaComponent:0.5]CGColor];
  
  const CGFloat *startColorComponents = CGColorGetComponents(startColor);
  const CGFloat *endColorComponents = CGColorGetComponents(endColor);
  
  CGFloat colors[] = {
    startColorComponents[0], startColorComponents[1], startColorComponents[2], startColorComponents[3],
    endColorComponents[0], endColorComponents[1], endColorComponents[2], endColorComponents[3]
  };
  
  CGColorSpaceRef baseSpace = CGColorSpaceCreateDeviceRGB();
  CGGradientRef gradient = CGGradientCreateWithColorComponents(baseSpace, colors, NULL, 2);
  CGColorSpaceRelease(baseSpace), baseSpace = NULL;
  
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  CGContextSaveGState(context);
  
  CGContextBeginPath(context);
  
  CGContextMoveToPoint(context, [self.chartPoints[0] CGPointValue].x,
                       rect.origin.y + rect.size.height - PLT_Y_OFFSET);
  
  for (NSValue *pointContainer in self.chartPoints) {
    //TODO: nextPoint неудачное имя для текущей точки
    CGPoint nextPoint = [pointContainer CGPointValue];
    CGContextAddLineToPoint(context, nextPoint.x, nextPoint.y);
  }
  
  CGContextAddLineToPoint(context, [self.chartPoints.lastObject CGPointValue].x,
                          rect.origin.y + rect.size.height - PLT_Y_OFFSET);
  CGContextClosePath(context);
  
  CGContextClip(context);
  
  CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
  CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
  
  CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
  CGGradientRelease(gradient), gradient = NULL;
  
  CGContextRestoreGState(context);
  
}

- (void)drawMarkers {
  
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  CGContextSaveGState(context);
  CGContextSetFillColorWithColor(context, [self.chartStyle.chartLineColor CGColor]);

  
  CGFloat markerRadius = 4.0f;
  
  for (NSUInteger i = 1; i < self.chartPoints.count; ++i) {

    CGPoint currentPoint = [self.chartPoints[i] CGPointValue];
    CGRect markerRect = CGRectMake(currentPoint.x - markerRadius,
                                   currentPoint.y - markerRadius,
                                   2*markerRadius,
                                   2*markerRadius);
    
    CGContextAddEllipseInRect(context, markerRect);
    CGContextFillPath(context);

  }
  
  CGContextRestoreGState(context);
}


#pragma mark - Interaction
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  
  NSSet *allTouches = [event allTouches];
  UITouch *touch = allTouches.allObjects[0];
  CGPoint touchLocation = [touch locationInView:self];

#ifdef DEBUG
  NSLog(@"touchesBegan");
  NSLog(@"Количество контактов: %lu", (unsigned long)allTouches.count);
  NSLog(@"Количество касаний: %lu", (unsigned long)touch.tapCount);
  NSLog(@"x=%f y=%f", touchLocation.x, touchLocation.y);
  NSLog(@"%@", touch.view);
#endif
}
 
@end
