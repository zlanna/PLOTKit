//
//  PLTGrid.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 28.01.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTGridView.h"
#import "PLTGridStyle.h"

const CGFloat kPLTXOffset = 10.0;
const CGFloat kPLTYOffset = 10.0;

static NSString *const observerKeypath = @"self.frame";

typedef NSMutableArray<UILabel *> LabelsCollection;
typedef NSArray<NSNumber *> GridData;
typedef __kindof NSArray<NSValue *> GridPoints;

@interface PLTGridView ()

@property(nonatomic, strong, nonnull) PLTGridStyle *style;
@property(nonatomic, strong, nullable) GridData *xGridData;
@property(nonatomic, strong, nullable) GridData *yGridData;
@property(nonatomic, strong, readonly) GridPoints *xGridPoints;
@property(nonatomic, strong, readonly) GridPoints *yGridPoints;
@property(nonatomic, strong) LabelsCollection *horizontalLabels;
@property(nonatomic, strong) LabelsCollection *verticalLabels;

@end


@implementation PLTGridView

@synthesize style = _style;
@synthesize xGridData;
@synthesize yGridData;

@synthesize xGridPoints = _xGridPoints;
@synthesize yGridPoints = _yGridPoints;
@synthesize horizontalLabels = _horizontalLabels;
@synthesize verticalLabels = _verticalLabels;

@synthesize styleSource;
@synthesize dataSource;

#pragma mark - Initialization

- (null_unspecified instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = [UIColor clearColor];
    
    _style = [PLTGridStyle blank];
    _horizontalLabels = [[LabelsCollection alloc] initWithCapacity:10];
    _verticalLabels = [[LabelsCollection alloc] initWithCapacity:10];
    [self addObserver:self
           forKeyPath:observerKeypath
              options:NSKeyValueObservingOptionInitial
              context:nil];
  }
  return self;
}

- (null_unspecified instancetype)init {
  return [self initWithFrame: kPLTDefaultFrame];
}

#pragma mark - View lifecycle

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
}

#pragma mark - KVO

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wextra"
#pragma clang diagnostic ignored "-Wdirect-ivar-access"

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
  if (object == self
      && [keyPath isEqualToString:@"self.frame"]
      && self.xGridData
      && self.yGridData) {
    _xGridPoints = [self computeXGridPoints];
    _yGridPoints = [self computeYGridPoints];
  }
}

#pragma clang diagnostic pop

#pragma mark - Properties. Lazy initialization

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdirect-ivar-access"

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
  CGFloat deltaXgrid = (width - 2*kPLTXOffset) / gridLinesCount;
  
  if (gridLinesCount > 0) {
    
    for(NSUInteger i=0; i <= gridLinesCount; ++i) {
      CGPoint gridPoint = CGPointMake(i*deltaXgrid + kPLTXOffset, kPLTYOffset);
      [gridPoints addObject: [NSValue valueWithCGPoint:gridPoint]];
    }
  }
  else {
    CGPoint gridPoint = CGPointMake(kPLTXOffset, kPLTYOffset);
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
  CGFloat deltaYgrid = (height - 2*kPLTYOffset) / gridLinesCount;
  
  for(NSUInteger i=0; i <= gridLinesCount; ++i) {
    CGPoint gridPoint = CGPointMake(kPLTXOffset, i*deltaYgrid + kPLTYOffset);
    [gridPoints addObject: [NSValue valueWithCGPoint:gridPoint]];
  }
 
  return gridPoints;
}

#pragma mark - Drawing
// FIX: Проверить блоки на циклы удержания.

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
                                  CGPoint endPoint = CGPointMake(startPoint.x, startPoint.y + height - 2*kPLTYOffset);
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
                                  CGPoint endPoint = CGPointMake(startPoint.x  + width - 2*kPLTXOffset, startPoint.y);
                                  CGContextMoveToPoint(context, startPoint.x, startPoint.y);
                                  CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
                                  CGContextStrokePath(context);
                                }];
    }
    
    if (self.style.verticalLabelPosition != PLTGridLabelVerticalPositionNone) {
      [self drawVerticalLabels:rect];
    }
    
    if (self.style.verticalLabelPosition != PLTGridLabelVerticalPositionNone) {
      [self drawHorizontalLabels:rect];
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
      break ;
      
    case PLTGridLabelHorizontalPositionRight:
      horizontalOffset = CGRectGetWidth(rect);
      break ;
      
    case PLTGridLabelHorizontalPositionNone:
      break;
  }

  [self removeOldLabels: self.horizontalLabels];
  
  // TODO: Умный код для подгона размеров
  UIFont *labelFont = [UIFont systemFontOfSize:9.0];
  CGFloat labelWidth = 50.0;
  CGFloat labelHeight = 12.0;
  
  for (NSUInteger i=0; i < self.yGridPoints.count; ++i) {
    CGPoint currentPoint = [self.yGridPoints[i] CGPointValue];
    CGRect markerLabelFrame = CGRectMake(currentPoint.x - labelWidth + horizontalOffset,
                                         currentPoint.y - labelHeight/2,
                                         labelWidth,
                                         labelHeight);
    UILabel *markerLabel = [[UILabel alloc] initWithFrame: markerLabelFrame];
    markerLabel.textAlignment = NSTextAlignmentRight;
    // FIX: Здесь задается формат точности. Собственно в этом месте и стоит делать всю обраюотку
    markerLabel.text =  [NSString stringWithFormat:@"%.00f", [self.yGridData[self.yGridData.count - i - 1] doubleValue]];
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
      break ;
      
    case PLTGridLabelVerticalPositionBottom:
      verticalOffset = CGRectGetHeight(rect);
      break ;
      
    case PLTGridLabelVerticalPositionNone:
      break;
  }
  
  [self removeOldLabels: self.verticalLabels];
  
  // TODO: Умный код для подгона размеров
  UIFont *labelFont = [UIFont systemFontOfSize:9.0];
  CGFloat labelWidth = 20.0;
  CGFloat labelHeight = 12.0;
  
  if (self.xGridPoints.count > 0) {
    for (NSUInteger i=0; i < self.xGridPoints.count; ++i) {
      CGPoint currentPoint = [self.xGridPoints[i] CGPointValue];
      CGRect markerLabelFrame = CGRectMake(currentPoint.x - labelWidth/2,
                                           currentPoint.y - labelHeight + verticalOffset,
                                           labelWidth,
                                           labelHeight);
      UILabel *markerLabel = [[UILabel alloc] initWithFrame: markerLabelFrame];
      markerLabel.textAlignment = NSTextAlignmentCenter;
      markerLabel.text = [self.xGridData[i] stringValue];
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
