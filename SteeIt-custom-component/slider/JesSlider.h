//
//  SliderProgressHybrid.h
//  tet
//
//  Created by Jung Eun Su on 2017. 12. 29..
//  Copyright © 2017년 Jung Eun Su. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SliderProgressHybridDelegate <NSObject>
-(void)didMoved:(id)slider
          value:(float)value
        UIEvent:(UIEvent *)event;
@end
#import "KnobImageView.h"


enum
{
    /** Fills from bottom to top */
    SLIDER_HORIZ = 0,
    /** Fills from left to right */
    SLIDER_VERT,
    /** Fills from top to bottom */
    SLIDER_INVERSE_VERT,
    /** Fills from right to left */
    SLIDER_INVERSE_HORIZ
};


@interface JesSlider : UIView <KnobImageViewDelegate>
@property(nonatomic, strong) id<SliderProgressHybridDelegate> delegate;
@property(nonatomic, assign, setter=setMovedValue:, getter=movedValue) CGFloat progressValue;
@property (nonatomic, assign) int rotation;

-(id)initWithFrame:(CGRect)frame viewController:(UIViewController *)viewController;
//-(void)setValue:(CGFloat)value;
-(void)setProgressValue:(CGFloat)value;
-(CGFloat)progressValue;
-(void)setMaxTrackImage:(UIImage *)img;
-(void)setMinTrackImage:(UIImage *)img;
-(void)setKonbImage:(UIImage *)img;
-(void)setRotation:(int)rotation;
@end



