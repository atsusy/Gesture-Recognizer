//
//  TiUIView+GestureRecognizer.h
//  gesturerecognizer
//
//  Created by KATAOKA,Atsushi on 11/09/24.
//  Copyright 2011年 MARSHMALLOW MACHINE. All rights reserved.
//
#import "TiUIView.h"

@interface TiUIView (TiUIView_GestureRecognizer) <UIGestureRecognizerDelegate>
- (void)setRecognizeSimultaneously_:(id)value;
- (void)setRotateGesture_:(id)value;
- (void)setPinchingGesture_:(id)value;
- (void)setPanGesture_:(id)value;
@end
