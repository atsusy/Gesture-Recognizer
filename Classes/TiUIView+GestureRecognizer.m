//
//  TiUIView+GestureRecognizer.m
//  gesturerecognizer
//
//  Created by KATAOKA,Atsushi on 11/09/24.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//
#import "TiUtils.h"
#import "TiUIView+GestureRecognizer.h"

@implementation TiUIView (TiUIView_GestureRecognizer)

- (void)handleRotationGesture:(UIRotationGestureRecognizer *)sender
{
    NSDictionary *args = [NSDictionary dictionaryWithObjectsAndKeys:
               [NSNumber numberWithFloat:[sender rotation]], @"rotation",
               [NSNumber numberWithFloat:[sender velocity]], @"velocity", nil];
    if([self.proxy _hasListeners:@"rotate"]){
        [self.proxy fireEvent:@"rotate" withObject:args];
    }
    
    if(sender.state == UIGestureRecognizerStateEnded && 
       [self.proxy _hasListeners:@"rotateend"]){
        [self.proxy fireEvent:@"rotateend"];
    }
}
    
- (void)setRotateGesture_:(id)value
{
    ENSURE_SINGLE_ARG(value, NSNumber);
    BOOL value_ = [value boolValue];
    
    if(value_){
        for(UIGestureRecognizer *gesure in self.gestureRecognizers){
            if([gesure isKindOfClass:[UIRotationGestureRecognizer class]]){
                return;
            }
        }
        
        UIRotationGestureRecognizer *rotationGesture =[[UIRotationGestureRecognizer alloc] initWithTarget:self
                                                                                                   action:@selector(handleRotationGesture:)];
        [self addGestureRecognizer:rotationGesture];
        
        [rotationGesture release];
    } else{
        UIGestureRecognizer *rotationGesture = nil;
        for(UIGestureRecognizer *gesure in self.gestureRecognizers){
            if([gesure isKindOfClass:[UIRotationGestureRecognizer class]]){
                rotationGesture = gesure;
                break;
            }
        }
        if(rotationGesture){
            [self removeGestureRecognizer:rotationGesture];
        }
    }    
}

- (void)handlePinchGesture:(UIPinchGestureRecognizer *)sender
{
    NSDictionary *args = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSNumber numberWithFloat:[sender scale]], @"scale",
                          [NSNumber numberWithFloat:[sender velocity]], @"velocity", nil];
    if([self.proxy _hasListeners:@"pinch"]){
        [self.proxy fireEvent:@"pinch" withObject:args];
    }
    
    if(sender.state == UIGestureRecognizerStateEnded && 
       [self.proxy _hasListeners:@"pinchend"]){
        [self.proxy fireEvent:@"pinchend"];
    }
}

- (void)setPinchGesture_:(id)value
{
    ENSURE_SINGLE_ARG(value, NSNumber);
    BOOL value_ = [value boolValue];
    
    if(value_){
        for(UIGestureRecognizer *gesure in self.gestureRecognizers){
            if([gesure isKindOfClass:[UIPinchGestureRecognizer class]]){
                return;
            }
        }
        
        UIPinchGestureRecognizer *pinchGesture =[[UIPinchGestureRecognizer alloc] initWithTarget:self
                                                                                          action:@selector(handlePinchGesture:)];
        [self addGestureRecognizer:pinchGesture];
        
        [pinchGesture release];
    } else{
        UIGestureRecognizer *pinchGesture = nil;
        for(UIGestureRecognizer *gesure in self.gestureRecognizers){
            if([gesure isKindOfClass:[UIPinchGestureRecognizer class]]){
                pinchGesture = gesure;
                break;
            }
        }
        if(pinchGesture){
            [self removeGestureRecognizer:pinchGesture];
        }
    }        
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)sender
{
    CGPoint translation = [sender translationInView:self.superview];
    CGPoint velocity = [sender velocityInView:self.superview];
    
    NSDictionary *args = [NSDictionary dictionaryWithObjectsAndKeys:
                          [[[TiPoint alloc] initWithPoint:translation] autorelease], @"translation",
                          [[[TiPoint alloc] initWithPoint:velocity] autorelease], @"velocity", nil];
    if([self.proxy _hasListeners:@"pan"]){
        [self.proxy fireEvent:@"pan" withObject:args];
    }
    
    if(sender.state == UIGestureRecognizerStateEnded && 
       [self.proxy _hasListeners:@"panend"]){
        [self.proxy fireEvent:@"panend"];
    }
}

- (void)setPanGesture_:(id)value
{
    ENSURE_SINGLE_ARG(value, NSNumber);
    BOOL value_ = [value boolValue];
    
    if(value_){
        for(UIGestureRecognizer *gesure in self.gestureRecognizers){
            if([gesure isKindOfClass:[UIPanGestureRecognizer class]]){
                return;
            }
        }
        
        UIPanGestureRecognizer *panGesture =[[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(handlePanGesture:)];
        [self addGestureRecognizer:panGesture];
        
        [panGesture release];
    } else{
        UIGestureRecognizer *panGesture = nil;
        for(UIGestureRecognizer *gesure in self.gestureRecognizers){
            if([gesure isKindOfClass:[UIPanGestureRecognizer class]]){
                panGesture = gesure;
                break;
            }
        }
        if(panGesture){
            [self removeGestureRecognizer:panGesture];
        }
    }        
}
@end
