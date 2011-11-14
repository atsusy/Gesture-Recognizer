//
//  TiUIView+GestureRecognizer.h
//  gesturerecognizer
//
//  Created by KATAOKA,Atsushi on 11/09/24.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//
#import "TiUIView.h"

@interface TiUIView (TiUIView_GestureRecognizer)
- (void)setRecognizeSimultaneously_:(id)value;
- (void)setRotateGesture_:(id)value;
- (void)setPinchGesture_:(id)value;
- (void)setPanGesture_:(id)value;
@end
