//
//  SEStepperEdit.m
//  MathApps
//
//  Created by Jonathan Rahn on 02.01.14.
//  Copyright (c) 2014 Jonathan Rahn. All rights reserved.
//

#import "SESpinEdit.h"

@interface SESpinEdit()
{
    NSNumber* _value;
    NSNumber* _max;
    NSNumber* _min;
}

@property NSStepper* stepper;
@property NSTextField* textField;
@property NSNumberFormatter* formatter;
@property NSMutableSet* numberSet;

@end

@implementation SESpinEdit

    //*******************************************************************************
#pragma mark - Initialization
    //*******************************************************************************

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.allowsFloats = NO;
        self.increment = @1;
        self.numberSet = [NSMutableSet setWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"0", @"-", nil];
        
        self.formatter = [NSNumberFormatter new];
        self.formatter.allowsFloats = NO;
        self.formatter.hasThousandSeparators = NO;
        
        NSRect emptyRect = NSMakeRect(0, 0, 0, 0);
        self.textField = [[NSTextField alloc]initWithFrame:emptyRect];
        self.textField.delegate = self;
        self.textField.stringValue = @"0";
        [self addSubview:self.textField];
        
        self.stepper = [[NSStepper alloc]initWithFrame:emptyRect];
        self.stepper.doubleValue = 0;
        self.stepper.maxValue = INFINITY;
        self.stepper.minValue = -INFINITY;
        self.stepper.increment = 1;
        self.stepper.target = self;
        self.stepper.action = @selector(stepperDidChange:);
        [self addSubview:self.stepper];
        
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.stepper.translatesAutoresizingMaskIntoConstraints = NO;
        self.textField.translatesAutoresizingMaskIntoConstraints = NO;
        
        NSDictionary* dict = @{@"stepper": self.stepper, @"textField": self.textField};
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[textField(>=27@749)]-3-[stepper]|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:dict]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[stepper]" options:0 metrics:nil views:dict]];
        [self setNeedsLayout:YES];
    }
    return self;
}

    //*******************************************************************************
#pragma mark - Actions and Delegates
    //*******************************************************************************

- (void) stepperDidChange: (NSStepper*) sender
{
        //Arrow down clicked
    if (self.stepper.doubleValue < 0)
    {
        [self decrease];
    }
        //Arrow up clicked
    if (self.stepper.doubleValue > 0)
    {
        [self increase];
    }
    self.stepper.doubleValue = 0;
    self.textField.stringValue = [self.formatter stringFromNumber:self.value];
    [self controlTextDidChange:nil];
}

- (void) controlTextDidChange:(NSNotification *)obj
{
    BOOL isError = NO;
    BOOL isOnlyMinus = NO;
    int decimalCount = 0;
    NSString* string = [self.textField stringValue];
    int i = 0;
    NSUInteger length = string.length;
    NSUInteger lastPositionDecimalSeparator = -1;
    while (i < length)
    {
        NSString* s = [string substringWithRange:NSMakeRange(i, 1)];
        if (![self.numberSet containsObject:s] || ([s isEqualToString:@"-"] && i != 0))
        {
            isError = YES;
            string = [string stringByReplacingOccurrencesOfString:s withString:@""options:0 range:NSMakeRange(i, 1)];
            i--;
        }
        if ([s isEqualToString:self.formatter.decimalSeparator])
        {
            decimalCount++;
            lastPositionDecimalSeparator = i;
        }
        if ([s isEqualToString:@"-"] && i == 0 && length == 1)
        {
            isOnlyMinus = YES;
        }
        i++;
        length = string.length;
    }
    if (isError || decimalCount > 1)
    {
        NSBeep();
        [self.textField setStringValue:string];
        [self controlTextDidChange:obj];
    }else if (string.length != 0 && lastPositionDecimalSeparator != length-1 && !isOnlyMinus) {
        self.value = [self.formatter numberFromString:string];
    }
    if (string.length == 0)
    {
        [self.textField.cell setPlaceholderString:[self.formatter stringFromNumber:self.value]];
    }
}

    //*******************************************************************************
#pragma mark - Property Accessors
    //*******************************************************************************

- (void) setValue:(NSNumber *)value
{
    if (![value isGreaterThan:self.max] && ![value isLessThan:self.min])
    {
        _value = value;
    }
    if ([value isGreaterThan:self.max])
    {
        _value = self.max;
    }
    if ([value isLessThan:self.min])
    {
        _value = self.min;
    }
    self.textField.stringValue = [self.formatter stringFromNumber:value];
    if ([self.delegate respondsToSelector:@selector(spinEditValueDidChange:)])
    {
        [self.delegate spinEditValueDidChange:self];
    }
}

- (NSNumber*) value
{
    if (!_value)
    {
        self.value = @0;
    }
    return _value;
}

- (void) setMax:(NSNumber *)max
{
    if ([max isGreaterThan:self.min])
    {
        _max = max;
        if ([self.value isGreaterThan:self.max])
        {
            self.value = max;
        }
    }
}

- (NSNumber*) max
{
    if (!_max)
    {
        _max = [NSNumber numberWithDouble:INFINITY];
    }
    return _max;
}

- (void) setMin:(NSNumber *)min
{
    if ([min isLessThan:self.max])
    {
        _min = min;
        if ([self.value isLessThan:self.min])
        {
            self.value = min;
        }
    }
}

- (NSNumber*) min
{
    if (!_min)
    {
        _min = [NSNumber numberWithDouble:-INFINITY];
    }
    return _min;
}

- (void) setAllowsFloats:(BOOL)allowsFloats
{
    self.formatter.allowsFloats = allowsFloats;
    if (allowsFloats)
    {
        self.formatter.maximumFractionDigits = 30;
        [self.numberSet addObject:self.formatter.decimalSeparator];
    }else{
        [self.numberSet removeObject:self.formatter.decimalSeparator];
        self.formatter.maximumFractionDigits = 0;
        self.value = @(self.value.integerValue);
        self.increment = @(self.increment.integerValue);
    }
}

- (BOOL) allowsFloats
{
    return self.formatter.allowsFloats;
}

    //*******************************************************************************
#pragma mark - Interface methods
    //*******************************************************************************

- (void) increase
{
    self.value = @(self.value.doubleValue + self.increment.doubleValue);
}

- (void) decrease
{
    self.value = @(self.value.doubleValue - self.increment.doubleValue);
}

    //*******************************************************************************
#pragma mark - NSView override
    //*******************************************************************************

- (NSSize) intrinsicContentSize
{
    NSSize sizeStepper = self.stepper.intrinsicContentSize;
    NSSize sizeTextField = self.textField.intrinsicContentSize;
    double height = MAX(sizeTextField.height, sizeStepper.height);
    double width = sizeStepper.width + 3;
    if (sizeTextField.width <24)
    {
        width += 24;
    }else{
        width += sizeTextField.width;
    }
    return NSMakeSize(width, height);
}

- (BOOL) requiresConstraintBasedLayout
{
    return YES;
}

@end
