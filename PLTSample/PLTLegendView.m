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

@interface PLTLegendView ()

@property(nonatomic, copy, nullable) NSDictionary<NSString *, NSDictionary*> *legendData;
@property(nonatomic, strong, nonnull) NSMutableArray<UIButton *> *buttonsContainer;
@property(nonatomic, copy, nullable) NSString *selectedChartName;

@end


@implementation PLTLegendView

@synthesize buttonsContainer = _buttonsContainer;

@synthesize dataSource;
@synthesize legendData;
@synthesize selectedChartName;


- (nonnull instancetype)init {
  self = [super initWithFrame:CGRectZero];
  if (self) {
    self.backgroundColor = [UIColor clearColor];
    //self.backgroundColor = [UIColor lightGrayColor];
    _buttonsContainer = [[NSMutableArray<UIButton *> alloc] init];
  }
  return self;
}

// TODO: Конечно пересоздавать контейнер с вложенными вью не нужно, если legendData не изменилась,
// но пока целесообразно сделать по тупому, ума позже добавлю

- (void)setNeedsDisplay {
  [super setNeedsDisplay];
  self.legendData = [self.dataSource chartViewsLegend];
  [self createButtonContainer];
  self.frame = [self calculateNewFrame:self.frame];
  NSLog(@"%@", NSStringFromCGRect(self.frame));
}

- (void)layoutIfNeeded {
  [super layoutIfNeeded];
  self.legendData = [self.dataSource chartViewsLegend];
  [self createButtonContainer];
  self.frame = [self calculateNewFrame:self.frame];
  NSLog(@"%@", NSStringFromCGRect(self.frame));
}

- (void)createButtonContainer {
  for (UIButton *button in self.buttonsContainer) {
    [button removeFromSuperview];
  }
  [self.buttonsContainer removeAllObjects];
  
  if (self.legendData && self.legendData.count>0) {
    for (NSString *chartName in self.legendData) {
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

- (CGRect)layoutButtonsInRect:(CGRect)rect {
  CGFloat width = CGRectGetWidth(rect);
  CGFloat originX = CGRectGetMinX(rect);
  CGFloat originY = CGRectGetMinY(rect);
  
  CGFloat space = 20;
  CGFloat layoutStartX = space;
  CGFloat layoutStartY = space;
  __block CGFloat height = space;
  
  NSMutableArray<NSValue *> *buttonPlaces = [[NSMutableArray alloc] init];
  [buttonPlaces addObject:[NSValue valueWithCGPoint:CGPointMake(layoutStartX, layoutStartY)]];
  
  // FIXME: Magic numbers
  
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
        height = height + buttonSize.height + space + 10;
        [buttonPlaces addObject:[NSValue valueWithCGPoint:CGPointMake(layoutStartX, height + buttonSize.height + space)]];
      }
    }
  }
  height = height + space;
  return CGRectMake(originX, originY, width, height);
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wextra"

- (void)drawRect:(CGRect)rect {
  for (UIButton *button in self.buttonsContainer){
    [self addSubview:button];
  }
}

#pragma clang diagnostic pop

@end
