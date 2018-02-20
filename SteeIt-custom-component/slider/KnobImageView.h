//
//  KnobImageView.h
//  tet
//
//  Created by Jung Eun Su on 2017. 12. 30..
//  Copyright © 2017년 Jung Eun Su. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KnobImageViewDelegate <NSObject>
/**
 노브를 인위적으로 움직였을 때 호출
 */
-(void)didTouchesMove:(float)x UIEvent:(UIEvent *)event;
@end

@interface KnobImageView : UIImageView
@property (nonatomic, retain) id <KnobImageViewDelegate> delegate;
-(void)setMaxTrackSize:(CGSize)size;
@end
