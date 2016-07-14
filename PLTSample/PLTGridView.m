//
//  PLTGrid.m
//  PLTSample
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

@synthesize styleSource;
@synthesize dataSource;

#pragma mark - Initialization

- (null_unspecified instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = [UIColor clearColor];
    
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
// TODO: Nil
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

// TODO: Дублирование, можно избавиться параметризировав функцию
- (GridPoints *)computeXGridPoints {
  CGRect rect = self.frame;
  NSUInteger gridLinesCount;

  gridLinesCount = self.xGridData.count - 1;
  GridPoints *gridPoints = [NSMutableArray<NSValue *> arrayWithCapacity:gridLinesCount];
  
  CGFloat width = CGRectGetWidth(rect);
  CGFloat deltaXgrid = width / gridLinesCount;
  
  // FIXME: Разобраться с конструкцией CGPoint gridPoint
  if (gridLinesCount > 0) {
    
    for(NSUInteger i=0; i <= gridLinesCount; ++i) {
      CGPoint gridPoint = CGPointMake(i*deltaXgrid, 0.0);
      [gridPoints addObject: [NSValue valueWithCGPoint:gridPoint]];
    }
  }
  else {
    CGPoint gridPoint = CGPointMake(0.0, 0.0);
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
// FIXME: Проверить блоки на циклы удержания.

- (void)drawRect:(CGRect)rect {
  if (self.xGridData && self.yGridData) {
    [self drawBackground:rect];
    // TODO: Prepare block сейчас выглядит плохо.
    
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
  // TODO: Вариант. Эту часть переносим в drawBlock
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
  
  
  // TODO: Вариант. Цикл тоже в drawBlock
  //Draw gridlines
  for (NSValue *pointContainer in gridPoints) {
    drawBlock(context, pointContainer);
  }
  
  //Restore
  CGContextRestoreGState(context);
  
}

// TODO: И здесь, и при построении линий сетки используются одни и теже рассчеты, но может не быть меток, либо линий
// сетки, либо ни того, ни другого. Следовательно рассчеты:
// а) либо дублируются;
// б) либо можно эти точки упаковать в частное свойство и повесить на него ленивую инициализацию.

- (void)drawHorizontalLabels:(CGRect) rect {
  
  CGFloat horizontalOffset = 0.0;
  switch (self.style.horizontalLabelPosition) {
    case PLTGridLabelHorizontalPositionLeft:
      horizontalOffset = 0.0;
      break;
    case PLTGridLabelHorizontalPositionRight:
      horizontalOffset = CGRectGetWidth(rect);
      break;
    case PLTGridLabelHorizontalPositionNone:
      break;
  }

  [self removeOldLabels: self.horizontalLabels];
  
  UIFont *labelFont = [UIFont systemFontOfSize:9.0];
  
  // Создание массива индексированного фреймов
  //TODO: Формат вывода чисел на оси (в расчете фрейма и выводе)
  NSMutableArray *indexingFrames = [[NSMutableArray alloc] initWithCapacity:self.yGridPoints.count];
  for (NSUInteger i=0; i < self.yGridPoints.count; ++i) {
    CGPoint currentPoint = [self.yGridPoints[i] CGPointValue];
    NSString *labelText = [self.yGridData[self.yGridData.count - i - 1] stringValue];
    CGSize labelSize = [labelText sizeWithAttributes:@{NSFontAttributeName : labelFont}];
    CGRect markerLabelFrame = CGRectMake(currentPoint.x - labelSize.width + horizontalOffset,
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
    markerLabel.text = [NSString stringWithFormat:@"%0.0f", [self.yGridData[self.yGridData.count - labelIndex - 1] doubleValue]];
    markerLabel.textColor = self.style.labelFontColor;
    markerLabel.font = labelFont;
    [self addSubview:markerLabel];
    [self.horizontalLabels addObject:markerLabel];
  }
}

- (void)drawVerticalLabels:(CGRect) rect {
 
  CGFloat verticalOffset = 0.0;
  switch (self.style.verticalLabelPosition) {
    case PLTGridLabelVerticalPositionTop:
      verticalOffset = 0.0;
      break;
    case PLTGridLabelVerticalPositionBottom:
      verticalOffset = CGRectGetHeight(rect);
      break;
    case PLTGridLabelVerticalPositionNone:
      break;
  }
  
  [self removeOldLabels: self.verticalLabels];
  
  UIFont *labelFont = [UIFont systemFontOfSize:9.0];
  
  //TODO: Incapsulate with logic in object
  if (self.xGridPoints.count > 0) {
    // Создание массива индексированного фреймов
    NSMutableArray *indexingFrames = [[NSMutableArray alloc] initWithCapacity:self.xGridPoints.count];
    for (NSUInteger i=0; i < self.xGridPoints.count; ++i) {
      CGPoint currentPoint = [self.xGridPoints[i] CGPointValue];
      NSString *labelText = [self.xGridData[i] stringValue];
      CGSize labelSize = [labelText sizeWithAttributes:@{NSFontAttributeName : labelFont}];
      CGRect markerLabelFrame = CGRectMake(currentPoint.x - labelSize.width/2,
                                           currentPoint.y - labelSize.height + verticalOffset,
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
        if (CGRectGetMaxX(currentFrame)>CGRectGetMinX(nextFrame)) {
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
      markerLabel.textAlignment = NSTextAlignmentCenter;
      markerLabel.text = [self.xGridData[labelIndex] stringValue];
      markerLabel.textColor = self.style.labelFontColor;
      markerLabel.font = labelFont;
      [self addSubview:markerLabel];
      [self.verticalLabels addObject:markerLabel];
    }
  }
}

#pragma mark - Label drawing helber

- (void)removeOldLabels:(LabelsCollection *)collection {
  for(UILabel *label in collection) {
    [label removeFromSuperview];
  }
  [collection removeAllObjects];
}

#pragma mark - Dealloc (remove observer)

-(void)dealloc {
  [self removeObserver:self forKeyPath:observerKeypath];
}

@end
