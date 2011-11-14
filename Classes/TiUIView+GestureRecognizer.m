//
//  TiUIView+GestureRecognizer.m
//  gesturerecognizer
//
//  Created by KATAOKA,Atsushi on 11/09/24.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//
#import "TiUtils.h"
#import "TiUIView+GestureRecognizer.h"

#define RECOGNIZE_SIMULTANEOUSLY (1 << 16)

@implementation TiUIView (TiUIView_GestureRecognizer)

- (void)setRecognizeSimultaneously_:(id)value
{
    ENSURE_SINGLE_ARG(value, NSNumber);
    BOOL value_ = [value boolValue];
    
    if(value_)
    {
        NSLog(@"[DEBUG] RecognizeSimultaneously to true.");
        for(UIGestureRecognizer *gesture in self.gestureRecognizers)
        {
            gesture.delegate = self;
        }
        self.tag |= RECOGNIZE_SIMULTANEOUSLY;
    }
    else
    {
        NSLog(@"[DEBUG] RecognizeSimultaneously to false.");
        for(UIGestureRecognizer *gesture in self.gestureRecognizers)
        {
            gesture.delegate = nil;
        }
        self.tag &= ~RECOGNIZE_SIMULTANEOUSLY;
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

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
        
        if(self.tag & RECOGNIZE_SIMULTANEOUSLY)
        {
            rotationGesture.delegate = self;
        }
        
        [rotationGesture release];
    } else{
        UIGestureRecognizer *rotationGesture = nil;
        for(UIGestureRecognizer *gesure in self.gestureRecognizers){
            if([gesure isKindOfClass:[UIRotationGestureRecognizer class]]){
                rotationGesture = gesure;
                break;
            }
        }
        
        rotationGesture.delegate = nil;
        
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
        
        if(self.tag & RECOGNIZE_SIMULTANEOUSLY)
        {
            pinchGesture.delegate = self;
        }
        [pinchGesture release];
    } else{
        UIGestureRecognizer *pinchGesture = nil;
        for(UIGestureRecognizer *gesure in self.gestureRecognizers){
            if([gesure isKindOfClass:[UIPinchGestureRecognizer class]]){
                pinchGesture = gesure;
                break;
            }
        }
        
        pinchGesture.delegate = self;
        
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
        
        if(self.tag & RECOGNIZE_SIMULTANEOUSLY)
        {
            panGesture.delegate = self;
        }
        [panGesture release];
    } else{
        UIGestureRecognizer *panGesture = nil;
        for(UIGestureRecognizer *gesure in self.gestureRecognizers){
            if([gesure isKindOfClass:[UIPanGestureRecognizer class]]){
                panGesture = gesure;
                break;
            }
        }
        
        panGesture.delegate = nil;
        
        if(panGesture){
            [self removeGestureRecognizer:panGesture];
        }
    }        
}
@end
