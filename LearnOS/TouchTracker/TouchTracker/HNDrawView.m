//
//  HNDrawView.m
//  TouchTracker
//
//  Created by 王籽涵 on 2020/7/6.
//  Copyright © 2020 Hahn Tech. All rights reserved.
//

#import "HNDrawView.h"
#import "HNLine.h"

@interface HNDrawView ()

//@property(nonatomic, strong) HNLine *currentLine;
@property(nonatomic, strong) NSMutableDictionary *linesInProgress;
@property(nonatomic, strong) NSMutableArray *finishedLines;

@end

@implementation HNDrawView

//init
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.linesInProgress = [[NSMutableDictionary alloc] init];
        self.finishedLines = [[NSMutableArray alloc] init];
        self.backgroundColor = [UIColor grayColor];
        self.multipleTouchEnabled = YES;
    }
    return self;
}


// === ges ===
- (void)strokeLine:(HNLine *)line {
    UIBezierPath *bp = [UIBezierPath bezierPath];
    bp.lineWidth = 10;
    bp.lineCapStyle = kCGLineCapRound;
    [bp moveToPoint:line.begin];
    [bp addLineToPoint:line.end];
    [bp stroke];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [[UIColor blackColor] set];
    for (HNLine *line in self.finishedLines) {
        [self strokeLine:line];
    }
    
    //check out time profiler
    float f = 0.0;
    for (int i = 0; i < 1000000; i++) {
        f = f + sin(sin(time(NULL) + i));
    }
    NSLog(@"f = %f", f);
    
    
//    if (self.currentLine) {
//        [[UIColor redColor] set];
//        [self strokeLine:self.currentLine];
//    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //check out the order
    NSLog(@"%@", NSStringFromSelector(_cmd));
    for (UITouch *t in touches) {
        CGPoint location = [t locationInView:self];
        HNLine *line = [[HNLine alloc] init];
        line.begin = location;
        line.end = location;
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        self.linesInProgress[key] = line;
    }
    
//    UITouch *t = [touches anyObject];
//    CGPoint location = [t locationInView:self];
//    self.currentLine = [[HNLine alloc] init];
//    self.currentLine.begin = location;
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //check out the order
    NSLog(@"%@", NSStringFromSelector(_cmd));
    for (UITouch *t in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        HNLine *line = self.linesInProgress[key];
        line.end = [t locationInView:self];
    }
    
//    UITouch *t = [touches anyObject];
//    CGPoint location = [t locationInView:self];
//    self.currentLine.end = location;
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //check out the order
    NSLog(@"%@", NSStringFromSelector(_cmd));
    for (UITouch *t in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        HNLine *line = self.linesInProgress[key];
        [self.finishedLines addObject:line];
        [self.linesInProgress removeObjectForKey:key];
        //check out leaks
        line.containArray = self.finishedLines;
    }
    
//    [self.finishedLines addObject:self.currentLine];
//    self.currentLine = nil;
    [self setNeedsDisplay];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    for (UITouch *t in touches) {
        NSValue *key = [NSValue valueWithNonretainedObject:t];
        [self.linesInProgress removeObjectForKey:key];
    }
    [self setNeedsDisplay];
}

- (void)doubleTap:(UIGestureRecognizer *)gr {
    NSLog(@"Recognized Double Tap");
    [self.linesInProgress removeAllObjects];
//    [self.finishedLines removeAllObjects];
    self.finishedLines = [[NSMutableArray alloc] init];
    [self setNeedsDisplay];
}

//check out analyze
- (int)numberOfLines {
    int count = 0;
    if (self.linesInProgress && self.finishedLines) {
        count = [self.linesInProgress count] + [self.finishedLines count];
    }
    return count;
}

@end
