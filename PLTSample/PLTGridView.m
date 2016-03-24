//
//  PLTGrid.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 28.01.16.
//  Copyright © 2016 Alexey Ulenkov (FBSoftware). All rights reserved.
//

#import "PLTGridView.h"
#import "PLTGridStyle.h"
#import "PLTConstants.h"

const CGFloat PLT_X_OFFSET = 10.0f;
const CGFloat PLT_Y_OFFSET = 10.0f;

@interface PLTGridView ()

@property(nonatomic, strong) PLTGridStyle *style;
@property(nonatomic, strong) NSArray<NSNumber *> *xGridData;
@property(nonatomic, strong) NSArray<NSNumber *> *yGridData;
@property(nonatomic, strong, readonly) NSArray<NSValue *> *xGridPoints;
@property(nonatomic, strong, readonly) NSArray<NSValue *> *yGridPoints;

@end


@implementation PLTGridView

@synthesize style = _style;
@synthesize xGridData;
@synthesize yGridData;

@synthesize xGridPoints = _xGridPoints;
@synthesize yGridPoints = _yGridPoints;

@synthesize delegate;

#pragma mark - Initialization

//TODO: Перегрузить инициализаторы по умолчанию
//TODO: Разобраться с использование self в init, когда можно, а когда нельзя

- (nonnull instancetype)initWithStyle:(PLTGridStyle *) gridStyle{
  if(self = [super initWithFrame:CGRectZero]){
    self.style = gridStyle;
    self.xGridData = @[@10,@20,@30,@40,@50,@60,@70,@80,@90,@100];
    self.yGridData = @[@1,@2,@3,@4,@5,@6,@7,@8,@9,@10];
    self.contentMode = UIViewContentModeRedraw;
  }
  return self;
}

#pragma mark - View lifecycle

- (void)willMoveToSuperview:(UIView *)newSuperview{
  [super willMoveToSuperview: newSuperview];
  //TODO: В общем тут скорее всего должна быть некоторая проверка на существование делегата и генерация исключения
  //TODO:Подумать как передать frame без делегата
  self.frame = [self.delegate gridViewFrame];
}

#pragma mark - Properties. Lazy initialization

- (NSArray<NSValue *> *)xGridPoints {
  if (_xGridPoints == nil) {
    CGRect rect = self.frame;
    
    NSUInteger gridLinesCount = self.xGridData.count;
    NSMutableArray<NSValue *> *gridPoints = [NSMutableArray<NSValue *> arrayWithCapacity:gridLinesCount];
    
    float deltaXgrid = (rect.size.width - 2*PLT_X_OFFSET) / gridLinesCount;
    
    for(NSUInteger i=0; i <= gridLinesCount; ++i) {
      CGPoint gridPoint = CGPointMake(i*deltaXgrid + PLT_X_OFFSET, PLT_Y_OFFSET);
      [gridPoints addObject: [NSValue valueWithCGPoint:gridPoint]];
    }
    
    _xGridPoints = gridPoints;
  }
  return _xGridPoints;
}

- (NSArray<NSValue *> *)yGridPoints {
  if (_yGridPoints == nil) {
    CGRect rect = self.frame;
    
    NSUInteger gridLinesCount = self.yGridData.count;
    NSMutableArray<NSValue *> *gridPoints = [NSMutableArray<NSValue *> arrayWithCapacity:gridLinesCount];
    
    float deltaYgrid = (rect.size.height - 2*PLT_Y_OFFSET) / gridLinesCount;
    
    for(NSUInteger i=0; i <= gridLinesCount; ++i) {
      CGPoint gridPoint = CGPointMake(PLT_X_OFFSET, i*deltaYgrid + PLT_Y_OFFSET);
      [gridPoints addObject: [NSValue valueWithCGPoint:gridPoint]];
    }
    
    _yGridPoints = gridPoints;
  }
  return _yGridPoints;
}


#pragma mark - Drawing

- (void)drawRect:(CGRect)rect{
  [self drawBackground:rect];
  //TODO: Prepare block сейчас вообще как говно.
  
  //Draw vertical lines
  if (self.style.verticalGridlineEnable) {
    [self drawGridlines:rect
           prepareBlock:^NSArray<NSValue *>* (CGRect rect, CGContextRef context){
             CGContextSetStrokeColorWithColor(context, [self.style.verticalLineColor CGColor]);

             
             return self.xGridPoints;
           }
              drawBlock:^(CGRect rect, CGContextRef context, NSValue *pointContainer){
                CGPoint startPoint = [pointContainer CGPointValue];
                CGPoint endPoint = CGPointMake(startPoint.x, startPoint.y + rect.size.height - 2*PLT_Y_OFFSET);
                CGContextMoveToPoint(context, startPoint.x, startPoint.y);
                CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
                CGContextStrokePath(context);
              }];
  }
  
  //Draw horizontal lines
  if (self.style.horizontalGridlineEnable) {
    [self drawGridlines:rect
           prepareBlock:^NSArray<NSValue *>* (CGRect rect, CGContextRef context){
             CGContextSetStrokeColorWithColor(context, [self.style.horizontalLineColor CGColor]);
             
             return self.yGridPoints;
           }
              drawBlock:^(CGRect rect, CGContextRef context, NSValue *pointContainer){
                CGPoint startPoint = [pointContainer CGPointValue];
                CGPoint endPoint = CGPointMake(startPoint.x  + rect.size.width - 2*PLT_X_OFFSET, startPoint.y);
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

- (void)drawGridlines:(CGRect)rect
         prepareBlock:(NSArray * (^)(CGRect, CGContextRef)) prepareBlock
            drawBlock:(void (^)(CGRect, CGContextRef,NSValue*)) drawBlock {
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
    default:
      break;
  }
  NSArray *gridPoints = prepareBlock(rect, context);
  
  
  //TODO: Вариант. Цикл тоже в drawBlock
  //Draw gridlines
  for (NSValue *pointContainer in gridPoints) {
    drawBlock(rect, context, pointContainer);
  }
  
  //Restore
  CGContextRestoreGState(context);
  
}

// TODO: И здесь, и при построении линий сетки используются одни и теже рассчеты, но может не быть меток, либо линий
// сетки, либо ни того, ни другого. Следовательно рассчеты:
// а) либо дублируются;
// б) либо можно эти точки упаковать в частное свойство и повесить на него ленивую инициализацию.

- (void)drawHorizontalLabels:(CGRect) rect {
  
  CGFloat horizontalOffset = 0.0f;
  
  switch (self.style.horizontalLabelPosition) {

    case PLTGridLabelHorizontalPositionLeft:
      horizontalOffset = 0.0f;
      break ;
      
    case PLTGridLabelHorizontalPositionRight:
      horizontalOffset = rect.size.width;
      break ;

    default:
      break;
  }

  //TODO: Умный код для подгона размеров
  UIFont *labelFont = [UIFont systemFontOfSize:9.0f];
  CGFloat labelWidth = 12.0f;
  CGFloat labelHeight = 12.0f;
  
  for (NSUInteger i=0; i < self.yGridPoints.count - 1; ++i) {
    //TODO: Нужен ли здесь autoreleasepool
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
  }

}

- (void)drawVerticalLabels:(CGRect) rect{
 
  CGFloat verticalOffset = 0.0f;
  
  switch (self.style.verticalLabelPosition) {
      
    case PLTGridLabelVerticalPositionTop:
      verticalOffset = 0.0f;
      break ;
      
    case PLTGridLabelVerticalPositionBottom:
      verticalOffset = rect.size.height;
      break ;
      
    default:
      break;
  }
  
  //TODO: Умный код для подгона размеров
  UIFont *labelFont = [UIFont systemFontOfSize:9.0f];
  CGFloat labelWidth = 12.0f;
  CGFloat labelHeight = 12.0f;
  
  for (NSUInteger i=1; i < self.xGridPoints.count-1; ++i) {
    //TODO: Нужен ли здесь autoreleasepool
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
  }
  
}

@end
