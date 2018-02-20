//
//  SliderProgressHybrid.m
//
//
//  Created by Jung Eun Su on 2017. 12. 29..
//  Copyright © 2017년 Jung Eun Su. All rights reserved.
//

#import "JesSlider.h"
#import "KnobImageView.h"

#define MIN_RATIO 1

@interface JesSlider()
@property (nonatomic, strong) UIImageView *maxTrackIv, *minTrackIv;
@property (nonatomic, strong) KnobImageView *knobIv;
@property (nonatomic) UIPanGestureRecognizer *recog;
@property (nonatomic, retain) UIViewController *vc;
@property (nonatomic) CGRect selfRect;
@property (nonatomic) CGFloat selfMovedValue;
@end

@implementation JesSlider
@synthesize delegate, progressValue;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame viewController:(UIViewController *)viewController
{
    CGRect reFrame;
    reFrame.size.width = frame.size.width + frame.size.height;
    reFrame.size.height = frame.size.height;
    reFrame.origin.x = frame.origin.x - frame.size.height / 2;
    reFrame.origin.y = frame.origin.y;
    
    if (!(self = [super initWithFrame:reFrame])) return nil;
    _vc = viewController;
    [self setUp];
    return self;
}

/**
set up ui
 */
-(void)setUp {
    [self setUserInteractionEnabled:YES];
    
    //maxtrack
    _maxTrackIv = [[UIImageView alloc] init];
    _maxTrackIv.contentMode = UIViewContentModeScaleToFill;

    CGRect maxRec;
    maxRec.origin.x = self.bounds.origin.x + self.bounds.size.height / 2;
    maxRec.origin.y = self.bounds.origin.y;
    maxRec.size.width = self.bounds.size.width - self.bounds.size.height;
    maxRec.size.height = self.bounds.size.height;
    
    [_maxTrackIv setFrame:maxRec];
    [_maxTrackIv setUserInteractionEnabled:YES];

    //konb ImageView
    _knobIv = [[KnobImageView alloc] init];
    _knobIv.delegate = self;

    CGRect knobRect;
    knobRect.size.height = self.bounds.size.height;
    knobRect.size.width = self.bounds.size.height;
    knobRect.origin.x = _maxTrackIv.frame.origin.x - knobRect.size.width / 2;
    [_knobIv setFrame:knobRect];
    [_knobIv setMaxTrackSize:_maxTrackIv.bounds.size];
    [_knobIv setUserInteractionEnabled:YES];
    //end knob

    //mintrack
    _minTrackIv = [[UIImageView alloc] init];
    CGRect minRect;
    minRect.origin.x = _maxTrackIv.bounds.origin.x;
    minRect.origin.y = _maxTrackIv.bounds.size.height / 2 - _minTrackIv.bounds.size.height / 2;
    minRect.size.height = _maxTrackIv.frame.size.height / MIN_RATIO;
    [_minTrackIv setFrame:minRect];
    //end mintrack
    
    [self addSubview:_maxTrackIv];
    [self addSubview:_minTrackIv];
    [self addSubview:_knobIv];
    [self rotate:self.rotation];
}

#pragma mark - setters, getters

-(void)setProgressValue:(CGFloat)value
{
    _selfMovedValue = value;
    float mutiple = _maxTrackIv.bounds.size.width / 100;
    float position =  value * mutiple;
    NSLog(@"init-didSocketRx rec : %f",position);
    [self moveKnob:position];
}

-(CGFloat)progressValue
{
    return _selfMovedValue;
}

-(void)setMaxTrackImage:(UIImage *)img
{
    [_maxTrackIv setImage:img];
}

-(void)setMinTrackImage:(UIImage *)img
{
    [_minTrackIv setImage:img];
}

-(void)setKonbImage:(UIImage *)img
{
    [_knobIv setImage:img];
}

-(void)setRotation:(int)rotation
{
    [self rotate:rotation];
}

#pragma mark - Private methods

/**
 fill minimum track
 */
-(void)fillTrack:(float)x
{
    //streching fillTrack------------------------------------------------------
    CGRect minRect;
    minRect.size.height = _maxTrackIv.frame.size.height / MIN_RATIO;
    minRect.size.width = x + _knobIv.bounds.origin.x;
    minRect.origin.x = _knobIv.bounds.size.width / 2;
    minRect.origin.y = _maxTrackIv.bounds.size.height / 2 - _minTrackIv.bounds.size.height / 2;
    [_minTrackIv setFrame:minRect];
    //end streching fillTrack--------------------------------------------------
}

/**
 @brief Set Sliderbar orientation
 */
-(void)rotate:(int)orientationType
{
    switch (orientationType) {
        case SLIDER_VERT :
        {
            CGAffineTransform trans = CGAffineTransformMakeRotation(M_PI * (270) / 180.0);
            self.transform = trans;
            break;
        }
        case SLIDER_HORIZ :
        {
            CGAffineTransform trans = CGAffineTransformMakeRotation(M_PI * (0) / 180.0);
            self.transform = trans;
            break;
        }
        case SLIDER_INVERSE_VERT :
        {
            CGAffineTransform trans = CGAffineTransformMakeRotation(M_PI * (90) / 180.0);
            self.transform = trans;
            break;
        }
        case SLIDER_INVERSE_HORIZ :
        {
            CGAffineTransform trans = CGAffineTransformMakeRotation(M_PI * (180) / 180.0);
            self.transform = trans;
            break;
        }
        default:
            break;
    }
}

/**
 Moved knob
 */
-(void)moveKnob:(float)x
{
    //limited
    if (x > _maxTrackIv.bounds.size.width)
        x = 0;
    
    CGRect rect;
    rect.size.width = _knobIv.bounds.size.width;
    rect.size.height = _knobIv.bounds.size.height;
    rect.origin.y = _knobIv.bounds.origin.y;
    rect.origin.x = x;
    [_knobIv setFrame:rect];
    [self fillTrack:x];
}

#pragma mark - KnobImageView delegate

//move knob
-(void)didTouchesMove:(float)x UIEvent:(UIEvent *)event
{
    [self fillTrack:x];
    float mutiple = _maxTrackIv.bounds.size.width / 100;
    float value = x / mutiple ;
    NSLog(@"value:%f", value);
    [self.delegate didMoved:self value:(float)value UIEvent:event];
}

@end
