//
//  PLTLegendView.m
//  PLTSample
//
//  Created by ALEXEY ULENKOV on 28.01.16.
//  Copyright © 2016 Alexey Ulenkov. All rights reserved.
//

@import QuartzCore;

#import "PLTLegendView.h"
#import "UIImage+ImageFromColor.h"
#import "PLTLinearChartStyle.h"

@interface PLTLegendView ()

@property(nonatomic, copy, nullable) NSDictionary<NSString *, PLTLinearChartStyle*> *chartStylesForLegend;
@property(nonatomic, strong, nonnull) NSMutableArray<UIButton *> *buttonsContainer;
@property(nonatomic, copy, nullable) NSString *selectedChartName;

@end


@implementation PLTLegendView

@synthesize buttonsContainer = _buttonsContainer;

@synthesize dataSource;
@synthesize chartStylesForLegend;
@synthesize selectedChartName;


- (nonnull instancetype)init {
  self = [super initWithFrame:CGRectZero];
  if (self) {
    self.backgroundColor = [UIColor clearColor];
    
    _buttonsContainer = [[NSMutableArray<UIButton *> alloc] init];
  }
  return self;
}

// TODO: Конечно пересоздавать контейнер с вложенными вью не нужно, если legendData не изменилась,
// но пока целесообразно сделать по тупому, ума позже добавлю

- (void)setNeedsDisplay {
  [super setNeedsDisplay];
  self.chartStylesForLegend = [self.dataSource chartViewsLegend];
}

- (void)layoutIfNeeded {
  [super layoutIfNeeded];
  [self createButtonContainer];
  self.frame = [self calculateNewFrame:self.frame];
}

- (void)createButtonContainer {
  for (UIButton *button in self.buttonsContainer) {
    [button removeFromSuperview];
  }
  [self.buttonsContainer removeAllObjects];
  
  if (self.chartStylesForLegend && self.chartStylesForLegend.count>0) {
    for (NSString *chartName in self.chartStylesForLegend) {
      UIButton *legendChartButton = [self configButtonWithTitle:chartName];
      [self.buttonsContainer addObject:legendChartButton];
    }
  }
}

- (UIButton *)configButtonWithTitle:(nullable NSString *)title {
  UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
  button.titleLabel.text = title;
  [button setTitle:title forState:UIControlStateNormal];
  [button setTitle:title forState:UIControlStateSelected];
  [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
  [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
  [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
  [button setBackgroundImage:[UIImage plt_imageFromColor:[UIColor whiteColor]] forState:UIControlStateNormal];
  [button setBackgroundImage:[UIImage plt_imageFromColor:[UIColor blueColor]] forState:UIControlStateSelected];
  [button setBackgroundImage:[UIImage plt_imageFromColor:[UIColor blueColor]] forState:UIControlStateHighlighted];
  button.layer.cornerRadius = 5;
  button.layer.masksToBounds = YES;
  if (self.selectedChartName) {
    if ([title compare: (NSString *_Nonnull)self.selectedChartName] == NSOrderedSame) {
      button.selected = YES;
    }
    else {
      button.selected = NO;
    }
  }
  [button addTarget:self action:@selector(selectChart:) forControlEvents:UIControlEventTouchUpInside];
  return button;
}

// FIXME: Не нравится семантика селектора
- (void)selectChart:(UIButton *)sender {
  NSString *chartName = sender.titleLabel.text;
  for (UIButton *button in self.buttonsContainer){
    if ([button.titleLabel.text compare:(NSString *_Nonnull)chartName] != NSOrderedSame) {
      button.selected = NO;
    }
  }
  sender.selected = YES;
  self.selectedChartName = chartName;
  [self.dataSource selectChart: chartName];
  
}

- (CGRect)calculateNewFrame:(CGRect)frame {
  if (self.buttonsContainer && self.buttonsContainer.count>0) {
    return [self layoutButtonsInRect:frame];
  }
  else {
    return CGRectZero;
  }
}

// FIXME: Починить магические числа и вообще стоит поправить конфигурацию с пробелами

- (CGRect)layoutButtonsInRect:(CGRect)rect {
  CGFloat width = self.superview.frame.size.width;
  CGFloat originX = CGRectGetMinX(rect);
  CGFloat originY = CGRectGetMinY(rect);
  
  CGFloat space = 20;
  CGFloat layoutStartX = space;
  CGFloat layoutStartY = space/2;
  CGFloat height = space/2;
  
  NSMutableArray<NSValue *> *buttonPlaces = [[NSMutableArray alloc] init];
  [buttonPlaces addObject:[NSValue valueWithCGPoint:CGPointMake(layoutStartX, layoutStartY)]];
  
  BOOL isCalcFirstTime = NO;
  
  for (UIButton *button in self.buttonsContainer) {
    CGSize buttonSize = [button.titleLabel.text sizeWithAttributes:@{NSFontAttributeName : button.titleLabel.font}];
  
    // FIXME: Horror
    if (!isCalcFirstTime) {
      height = height + buttonSize.height + 10;
      isCalcFirstTime = YES;
    }
    
    if (buttonSize.width > (width - 2*space)) {
      buttonSize.width = width - 2*space;
    }
    for (NSUInteger i=0; i<buttonPlaces.count; ++i) {
      NSValue *pointContainer = buttonPlaces[i];
      CGPoint placedPoint = [pointContainer CGPointValue];
      CGFloat freeSpace = width - space - placedPoint.x;
      if (buttonSize.width < freeSpace) {
        button.frame = CGRectMake(placedPoint.x, placedPoint.y, buttonSize.width + 10, buttonSize.height + 10);
        placedPoint.x = placedPoint.x + space + buttonSize.width + 5;
        buttonPlaces[i] = [NSValue valueWithCGPoint:placedPoint];
      }
      else if (i == buttonPlaces.count-1) {
        [buttonPlaces addObject:[NSValue valueWithCGPoint:CGPointMake(layoutStartX, height + space/2)]];
        height = height + buttonSize.height + space/2;
      }
    }
  }
  height = height + space;
  return CGRectMake(originX, originY, width, height);
}

// FIXME: Magic numbers
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wextra"

- (void)drawRect:(CGRect)rect {
  CGContextRef context = UIGraphicsGetCurrentContext();
  for (UIButton *button in self.buttonsContainer){
    [self addSubview:button];
    if (self.chartStylesForLegend) {
      NSString *chartName = button.titleLabel.text;
      PLTLinearChartStyle *chartStyle = self.chartStylesForLegend[chartName];
      
      CGContextSaveGState(context);
      CGContextSetStrokeColorWithColor(context, [chartStyle.chartColor CGColor]);
      CGContextSetLineWidth(context, chartStyle.lineWeight);
      
      CGFloat buttonOriginX = CGRectGetMinX(button.frame);
      CGFloat buttonOriginY = CGRectGetMinY(button.frame);
      CGFloat buttonHeight = CGRectGetHeight(button.frame);
      CGFloat legendWidth = 15;
      CGRect legendContainedRect = CGRectMake(buttonOriginX - legendWidth + 1, buttonOriginY,
                                              legendWidth - 1, buttonHeight);
      CGContextMoveToPoint(context, CGRectGetMinX(legendContainedRect), CGRectGetMidY(legendContainedRect));
      CGContextAddLineToPoint(context, CGRectGetMaxX(legendContainedRect), CGRectGetMidY(legendContainedRect));
      CGContextStrokePath(context);
      
      if (chartStyle.hasMarkers) {
        PLTMarker *marker = [PLTMarker markerWithType:chartStyle.markerType];
        marker.color = chartStyle.chartColor;
        marker.size = 2*chartStyle.lineWeight;
        
        CGImageRef cgMarkerImage = marker.markerImage.CGImage;
        CGRect markerRect = CGRectMake(CGRectGetMidX(legendContainedRect) - marker.size,
                                       CGRectGetMidY(legendContainedRect) - marker.size,
                                       2*marker.size,
                                       2*marker.size);
        CGContextDrawImage(context, markerRect, cgMarkerImage);
      }
      CGContextRestoreGState(context);
    }
  }
}

#pragma clang diagnostic pop

#pragma mark - PLTAutolayoutHeight

// FIXME: Это прототип, только в целях иллюстрации работы механизма
- (CGFloat)viewRequaredHeight{
  self.chartStylesForLegend = [self.dataSource chartViewsLegend];
  [self createButtonContainer];
  self.frame = [self calculateNewFrame:self.frame];
  return self.frame.size.height;
}

@end
