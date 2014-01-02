//
//  SEStepperEdit.h
//  MathApps
//
//  Created by Jonathan Rahn on 02.01.14.
//  Copyright (c) 2014 Jonathan Rahn. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class SESpinEdit;

@protocol SESpinEditDelegate <NSObject>

@optional
- (void) spinEditValueDidChange: (SESpinEdit*) sender;

@end

/*
 # Standard Height = 22
 # Minimal Width = 43
 */

/**
 This subclass of NSView provides the from other frameworks well-know SpinEdit. 
 
 Technically the view contains a NSTextField and a NSStepper and keeps the both in sync, in addition, it validates
 the input of the NSTextField.
 
 @attention This view requires autolayout!
 */
@interface SESpinEdit : NSView<NSTextFieldDelegate>

/**Provides the current value. When you set a value which is out of range, max/min will be setted.*/
@property NSNumber* value;
/**When activated, the SpinEdit accepts decimal values. When deactivated, the potential decimal value in value will be
 cutted off to an integer.*/
@property BOOL allowsFloats;
/**The stepwidth of the stepper.*/
@property NSNumber* increment;
/**The lowest possible value. Default is -∞.*/
@property NSNumber* min;
/**The highest possible value. Default is +∞.*/
@property NSNumber* max;

<<<<<<< HEAD
/**The delegate, @see SESpinEditDelegate*/
@property id<SESpinEditDelegate> delegate;

=======
/**Increases the value by the increment. Same effect like the up-button.*/
>>>>>>> Documentation
- (void) increase;
/**Decreases the value by the increment. Same effect like the down-button.*/
- (void) decrease;

@end
