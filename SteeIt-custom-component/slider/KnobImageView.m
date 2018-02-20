//
//  KnobImageView.m
//  tet
//
//  Created by Jung Eun Su on 2017. 12. 30..
//  Copyright © 2017년 Jung Eun Su. All rights reserved.
//

#import "KnobImageView.h"
@interface KnobImageView()
{
    CGSize maxTrackSize;
}
@end

@implementation KnobImageView
@synthesize delegate;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithImage:(nullable UIImage *)image
{
    self = [super initWithImage:image];
    if(self){
        NSLog(@"KnobImage-init-in");
        // custom init code
    }
    return self;
}

#pragma mark - Instance Methods

-(void)setMaxTrackSize:(CGSize)size
{
    maxTrackSize = size;
}

#pragma mark - Overidden Methods

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self moveKnob:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self moveKnob:touches withEvent:event];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self moveKnob:touches withEvent:event];
}

#pragma mark - private methods

/**
 델리게이트 nil 체크 후 Knob의 Rect 생성 및 Knob UI 업데이트
 @see updateUi()
 */
-(void)moveKnob:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesMoved");
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:[self superview]];
    
    CGRect rect ;
    rect.origin.x = point.x - self.bounds.size.width / 2;
    rect.origin.y =self.bounds.origin.y;
    rect.size = self.bounds.size;

    if(rect.origin.x < self.bounds.origin.x)
    {
        NSLog(@"limited min:%f", self.bounds.origin.x - self.bounds.size.width / 2);
        if(delegate != nil)
        {
            CGRect rect ;
            rect.origin.x = 0.f;
            rect.origin.y =self.bounds.origin.y;
            rect.size = self.bounds.size;
            [self updateUi:rect UIEvent:event];
        }
        return;
    }

    if(rect.origin.x > maxTrackSize.width)
    {
        NSLog(@"limited max:%f", self.bounds.origin.x);
        if(delegate != nil)
        {
            CGRect rect ;
            rect.origin.x = maxTrackSize.width;
            rect.origin.y =self.bounds.origin.y;
            rect.size = self.bounds.size;
            [self updateUi:rect UIEvent:event];
        }
        return;
    }
    
    if(delegate != nil) [self updateUi:rect  UIEvent:event];
}

/**
 Knob ui 업데이트 & 델리게이트 호출
 */
-(void)updateUi:(CGRect) rect UIEvent:(UIEvent *)event
{
    //UITouch *touch = [[event allTouches] anyObject];

    [self.delegate didTouchesMove:rect.origin.x UIEvent:event];
    [self setFrame:rect];
}

@end
