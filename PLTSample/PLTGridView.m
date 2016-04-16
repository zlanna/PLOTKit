//
//  PLTGrid.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 28.01.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

#import "PLTGridView.h"
#import "PLTGridStyle.h"

const CGFloat PLT_X_OFFSET = 10.0;
const CGFloat PLT_Y_OFFSET = 10.0;

static NSString *const observerKeypath = @"self.frame";

typedef NSMutableArray<UILabel *> LabelsCollection;
typedef NSArray<NSNumber *> GridData;
typedef __kindof NSArray<NSValue *> GridPoints;

@interface PLTGridView ()

@property(nonatomic, strong) PLTGridStyle *style;
@property(nonatomic, strong) GridData *xGridData;
@property(nonatomic, strong) GridData *yGridData;
@property(nonatomic, strong, readonly) GridPoints *xGridPoints;
@property(nonatomic, strong, readonly) GridPoints *yGridPoints;
@property(nonatomic, strong) LabelsCollection *horizontalLabels;
@property(nonatomic, strong) LabelsCollection *verticalLabels;

@end


@implementation PLTGridView

@synthesize style = _style;
@synthesize xGridData = _xGridData;
@synthesize yGridData = _yGridData;

@synthesize xGridPoints = _xGridPoints;
@synthesize yGridPoints = _yGridPoints;
@synthesize horizontalLabels = _horizontalLabels;
@synthesize verticalLabels = _verticalLabels;

@synthesize delegate;

#pragma mark - Initialization

- (null_unspecified instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    _xGridData = @[@10,@20,@30,@40,@50,@60,@70,@80,@90,@100];
    _yGridData = @[@1,@2,@3,@4,@5,@6,@7,@8,@9,@10];
    _horizontalLabels = [[LabelsCollection alloc] initWithCapacity:20];
    _verticalLabels = [[LabelsCollection alloc] initWithCapacity:20];
    [self addObserver:self
           forKeyPath:observerKeypath
              options:NSKeyValueObservingOptionInitial
              context:nil];
  }
  return self;
}

- (null_unspecified instancetype)init {
  return [self initWithFrame:CGRectMake(0.0, 0.0, 100.0, 100.0)];
}

#pragma mark - View lifecycle

- (void)willMoveToSuperview:(UIView *)newSuperview{
  [super willMoveToSuperview: newSuperview];
  if(self.delegate){
    self.style = [self.delegate gridStyle];
  }
  else{
    //TODO: Выброс исключения или отладочный вывод
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
  if (object == self && [keyPath isEqualToString:@"self.frame"]) {
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

- (GridPoints *)computeXGridPoints {
  CGRect rect = self.frame;
  
  NSUInteger gridLinesCount = self.xGridData.count;
  GridPoints *gridPoints = [NSMutableArray<NSValue *> arrayWithCapacity:gridLinesCount];
  
  CGFloat width = CGRectGetWidth(rect);
  CGFloat deltaXgrid = (width - 2*PLT_X_OFFSET) / gridLinesCount;
  
  for(NSUInteger i=0; i <= gridLinesCount; ++i) {
    CGPoint gridPoint = CGPointMake(i*deltaXgrid + PLT_X_OFFSET, PLT_Y_OFFSET);
    [gridPoints addObject: [NSValue valueWithCGPoint:gridPoint]];
  }
  return gridPoints;
}

- (GridPoints *)computeYGridPoints {
  CGRect rect = self.frame;
  
  NSUInteger gridLinesCount = self.yGridData.count;
  GridPoints *gridPoints = [NSMutableArray<NSValue *> arrayWithCapacity:gridLinesCount];
  
  CGFloat height = CGRectGetHeight(rect);
  CGFloat deltaYgrid = (height - 2*PLT_Y_OFFSET) / gridLinesCount;
  
  for(NSUInteger i=0; i <= gridLinesCount; ++i) {
    CGPoint gridPoint = CGPointMake(PLT_X_OFFSET, i*deltaYgrid + PLT_Y_OFFSET);
    [gridPoints addObject: [NSValue valueWithCGPoint:gridPoint]];
  }
  return gridPoints;
}

#pragma mark - Drawing
//FIX: Проверить блоки на циклы удержания.

- (void)drawRect:(CGRect)rect {
  [self drawBackground:rect];
  //TODO: Prepare block сейчас выглядит плохо.
  
  //Draw vertical lines
  if (self.style.verticalGridlineEnable) {
        [self drawGridlinesWithPrepareBlock:^NSArray<NSValue *>* (CGContextRef context){
             CGContextSetStrokeColorWithColor(context, [self.style.verticalLineColor CGColor]);
             return self.xGridPoints;
           }
              drawBlock:^(CGContextRef context, NSValue *pointContainer){
                CGPoint startPoint = [pointContainer CGPointValue];
                CGFloat height = CGRectGetHeight(rect);
                CGPoint endPoint = CGPointMake(startPoint.x, startPoint.y + height - 2*PLT_Y_OFFSET);
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
                CGPoint endPoint = CGPointMake(startPoint.x  + width - 2*PLT_X_OFFSET, startPoint.y);
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

- (void)drawBackground:(CGRect)rect {
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSetFillColorWithColor(context, [self.style.backgroundColor CGColor]);
  CGContextFillRect(context, rect);
}

- (void)drawGridlinesWithPrepareBlock:(NSArray * (^)(CGContextRef)) prepareBlock
                            drawBlock:(void (^)(CGContextRef,NSValue*)) drawBlock {
  //TODO: Вариант. Эту часть переносим в drawBlock
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
  
  
  //TODO: Вариант. Цикл тоже в drawBlock
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
  
  //TODO: Умный код для подгона размеров
  UIFont *labelFont = [UIFont systemFontOfSize:9.0];
  CGFloat labelWidth = 12.0;
  CGFloat labelHeight = 12.0;
  
  for (NSUInteger i=0; i < self.yGridPoints.count - 1; ++i) {
    CGPoint currentPoint = [self.yGridPoints[i] CGPointValue];
    CGRect markerLabelFrame = CGRectMake(currentPoint.x - labelWidth + horizontalOffset,
                                         currentPoint.y - labelHeight/2,
                                         labelWidth,
                                         labelHeight);
    UILabel *markerLabel = [[UILabel alloc] initWithFrame: markerLabelFrame];
    markerLabel.text = [self.yGridData[self.yGridData.count - i - 1] stringValue];
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
  
  //TODO: Умный код для подгона размеров
  UIFont *labelFont = [UIFont systemFontOfSize:9.0];
  CGFloat labelWidth = 12.0;
  CGFloat labelHeight = 12.0;
  
  for (NSUInteger i=1; i < self.xGridPoints.count-1; ++i) {
    CGPoint currentPoint = [self.xGridPoints[i] CGPointValue];
    CGRect markerLabelFrame = CGRectMake(currentPoint.x - labelWidth/2,
                                         currentPoint.y - labelHeight + verticalOffset,
                                         labelWidth,
                                         labelHeight);
    UILabel *markerLabel = [[UILabel alloc] initWithFrame: markerLabelFrame];
    markerLabel.text = [self.xGridData[i-1] stringValue];
    markerLabel.textColor = self.style.labelFontColor;
    markerLabel.font = labelFont;
    [self addSubview:markerLabel];
    [self.verticalLabels addObject:markerLabel];
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
