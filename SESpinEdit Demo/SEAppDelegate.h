//
//  SEAppDelegate.h
//  SESpinEdit Demo
//
//  Created by Jonathan Rahn on 02.01.14.
//  Copyright (c) 2014 Jonathan Rahn. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SESpinEdit.h"

@interface SEAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet SESpinEdit *spinEdit;
@property (weak) IBOutlet NSTextField *valueLabel;
@property (weak) IBOutlet SESpinEdit *maxSpinEdit;
@property (weak) IBOutlet SESpinEdit *minSpinEdit;
@property (weak) IBOutlet SESpinEdit *incrementSpinEdit;
@property (weak) IBOutlet NSSegmentedControl *allowsFloatsSegmentedControl;

@end
