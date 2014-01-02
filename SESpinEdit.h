//
//  SEStepperEdit.h
//  MathApps
//
//  Created by Jonathan Rahn on 02.01.14.
//  Copyright (c) 2014 Jonathan Rahn. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/*
 # Standard Height = 22
 # Minimal Width = 43
 */

@interface SESpinEdit : NSView<NSTextFieldDelegate>

@property NSNumber* value;
@property BOOL allowsFloats;
@property NSNumber* increment;
@property NSNumber* min;
@property NSNumber* max;

- (void) increase;
- (void) decrease;

@end
