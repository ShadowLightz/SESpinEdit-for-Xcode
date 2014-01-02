//
//  SEAppDelegate.m
//  SESpinEdit Demo
//
//  Created by Jonathan Rahn on 02.01.14.
//  Copyright (c) 2014 Jonathan Rahn. All rights reserved.
//

#import "SEAppDelegate.h"

@implementation SEAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.allowsFloatsSegmentedControl.selectedSegment = 1;
    self.incrementSpinEdit.allowsFloats = YES;
    [self.maxSpinEdit addObserver:self forKeyPath:@"value" options:0 context:nil];
    [self.minSpinEdit addObserver:self forKeyPath:@"value" options:0 context:nil];
    [self.incrementSpinEdit addObserver:self forKeyPath:@"value" options:0 context:nil];
    [self.spinEdit addObserver:self forKeyPath:@"value" options:0 context:nil];
        
    self.valueLabel.stringValue = self.spinEdit.value.stringValue;
    self.maxSpinEdit.value = self.spinEdit.max;
    self.minSpinEdit.value = self.spinEdit.min;
    self.incrementSpinEdit.value = self.spinEdit.increment;
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (object == self.minSpinEdit)
    {
        self.spinEdit.min = self.minSpinEdit.value;
    }
    if (object == self.maxSpinEdit)
    {
        self.spinEdit.max = self.maxSpinEdit.value;
    }
    if (object == self.incrementSpinEdit)
    {
        self.spinEdit.increment = self.incrementSpinEdit.value;
    }
    if (object == self.spinEdit)
    {
        self.valueLabel.stringValue = self.spinEdit.value.stringValue;
    }
}

- (IBAction)increaseClick:(id)sender {
    [self.spinEdit increase];
}
- (IBAction)decreaseClick:(id)sender {
    [self.spinEdit decrease];
}
- (IBAction)allowFloatsClick:(id)sender
{
    self.spinEdit.allowsFloats = !self.allowsFloatsSegmentedControl.selectedSegment;
}
@end
