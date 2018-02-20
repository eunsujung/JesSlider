//
//  ViewController.m
//  SteeIt-custom-component
//
//  Created by Jung Eun Su on 2018. 2. 12..
//  Copyright © 2018년 Jung Eun Su. All rights reserved.
//

#import "ViewController.h"

@interface ViewController()

@property(nonatomic, strong) IBOutlet UILabel *valueLb0, *valueLb1, *valueLb2, *valueLb3;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createSlide];
    [self createSlide1];
    [self createSlide2];
    [self createSlide3];
}

-(void)createSlide
{
    JesSlider *slider =  [[JesSlider alloc] initWithFrame:CGRectMake(100, 100, 200, 30)
                                           viewController:self];
    [slider setDelegate:self];
    [slider setTag:2];
    [slider setMaxTrackImage:[UIImage imageNamed:@"track"]];
    [slider setMinTrackImage:[UIImage imageNamed:@"track"]];
    [slider setKonbImage:[UIImage imageNamed:@"knob"]];
    [self.view addSubview:slider];
    [slider setProgressValue:50.f];
    [_valueLb0 setText:[@([slider progressValue]) stringValue]];
}

-(void)createSlide1
{
    JesSlider *slider =  [[JesSlider alloc] initWithFrame:CGRectMake(100, 200, 200, 30)
                                           viewController:self];
    [slider setRotation:SLIDER_INVERSE_HORIZ];
    [slider setTag:3];
    [slider setDelegate:self];
    [slider setMaxTrackImage:[UIImage imageNamed:@"track"]];
    [slider setMinTrackImage:[UIImage imageNamed:@"track"]];
    [slider setKonbImage:[UIImage imageNamed:@"knob-1"]];
    [self.view addSubview:slider];
    [_valueLb1 setText:[@([slider progressValue]) stringValue]];
}

-(void)createSlide2
{
    JesSlider *slider =  [[JesSlider alloc] initWithFrame:CGRectMake(50, 400, 200, 30)
                                           viewController:self];
    [slider setRotation:SLIDER_VERT];
    [slider setTag:4];
    [slider setDelegate:self];
    [slider setMaxTrackImage:[UIImage imageNamed:@"track"]];
    [slider setMinTrackImage:[UIImage imageNamed:@"track"]];
    [slider setKonbImage:[UIImage imageNamed:@"knob-1"]];
    [self.view addSubview:slider];
    [_valueLb2 setText:[@([slider progressValue]) stringValue]];
}

-(void)createSlide3
{
    JesSlider *slider =  [[JesSlider alloc] initWithFrame:CGRectMake(150, 400, 200, 30)
                                           viewController:self];
    [slider setRotation:SLIDER_INVERSE_VERT];
    [slider setTag:5];
    [slider setDelegate:self];
    [slider setMaxTrackImage:[UIImage imageNamed:@"track"]];
    [slider setMinTrackImage:[UIImage imageNamed:@"track"]];
    [slider setKonbImage:[UIImage imageNamed:@"knob-1"]];
    [self.view addSubview:slider];
    [_valueLb3 setText:[@([slider progressValue]) stringValue]];
}

#pragma mark - Slider Delegate

-(void)didMoved:(id)slider
          value:(float)value
        UIEvent:(UIEvent *)event
{
    if([slider tag] == 2)
    {
        [_valueLb0 setText:[@(value) stringValue]];
    }
    if([slider tag] == 3)
    {
        [_valueLb1 setText:[@(value) stringValue]];
    }
    if([slider tag] == 4)
    {
        [_valueLb2 setText:[@(value) stringValue]];
    }
    if([slider tag] == 5)
    {
        [_valueLb3 setText:[@(value) stringValue]];
    }

    
    NSLog(@"dele-vallue:%f", value);
}



@end
