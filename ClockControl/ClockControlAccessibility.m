/*
     File: ClockControlAccessibility.m
 Abstract: Accessorizes the clock cell.
  Version: 1.0
 
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
 Inc. ("Apple") in consideration of your agreement to the following
 terms, and your use, installation, modification or redistribution of
 this Apple software constitutes acceptance of these terms.  If you do
 not agree with these terms, please do not use, install, modify or
 redistribute this Apple software.
 
 In consideration of your agreement to abide by the following terms, and
 subject to these terms, Apple grants you a personal, non-exclusive
 license, under Apple's copyrights in this original Apple software (the
 "Apple Software"), to use, reproduce, modify and redistribute the Apple
 Software, with or without modifications, in source and/or binary forms;
 provided that if you redistribute the Apple Software in its entirety and
 without modifications, you must retain this notice and the following
 text and disclaimers in all such redistributions of the Apple Software.
 Neither the name, trademarks, service marks or logos of Apple Inc. may
 be used to endorse or promote products derived from the Apple Software
 without specific prior written permission from Apple.  Except as
 expressly stated in this notice, no other rights or licenses, express or
 implied, are granted by Apple herein, including but not limited to any
 patent rights that may be infringed by your derivative works or by other
 works in which the Apple Software may be incorporated.
 
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 
 Copyright (C) 2009 Apple Inc. All Rights Reserved.
 
 */

#import <ClockControl.h>
#import <AppKit/NSAccessibility.h>

@implementation ClockCell (ClockCellAccessibility)

NSString *AppleSynthesisAttribute = @"AppleSynthesis";

// Attributes
//
// Add a value attribute which is settable. Add an AppleSynthesis attribute for yucks. Inherit role (which we override) as well as size, position, ... which we can leave alone.

- (NSArray *)accessibilityAttributeNames {
    static NSArray *attributes = nil;
    if (attributes == nil) {
        attributes = [[[super accessibilityAttributeNames] arrayByAddingObjectsFromArray:[NSArray arrayWithObjects:NSAccessibilityValueAttribute, AppleSynthesisAttribute, nil]] retain];
    }
    return attributes;
}

- (id)accessibilityAttributeValue:(NSString *)attribute {
    if ([attribute isEqualToString:NSAccessibilityRoleAttribute]) {
        return @"AnalogClock";
    } else if ([attribute isEqualToString:NSAccessibilityRoleDescriptionAttribute]) {
        return NSLocalizedString(@"Analog Clock", "Description of clock control for accessibility purposes");
    } else if ([attribute isEqualToString:NSAccessibilityValueAttribute]) {
        return [self stringValue];
    } else if ([attribute isEqualToString:AppleSynthesisAttribute]) {
        return [NSString stringWithFormat:NSLocalizedString(@"At the tone, the time will be %@, [[inpt phon]] b1IY IY IY IY IY IY IY IY IY 1IYp [[inpt text]]", "String to read the time for accessibility purposes"), [self stringValue]];
    } else {
        return [super accessibilityAttributeValue:attribute];
    }
}

- (BOOL)accessibilityIsAttributeSettable:(NSString *)attribute {
    if ([attribute isEqualToString:NSAccessibilityValueAttribute]) {
        return YES;
    } else if ([attribute isEqualToString:AppleSynthesisAttribute]) {
        return NO;
    } else {
        return [super accessibilityIsAttributeSettable:attribute];
    }
}

- (void)accessibilitySetValue:(id)value forAttribute:(NSString *)attribute {
    if ([attribute isEqualToString:NSAccessibilityValueAttribute]) {
        [self setStringValue:value];
    } else {
        [super accessibilitySetValue:value forAttribute:attribute];
    }
}

// Actions
//
// Implement increment/decrement to act like the arrow keys

- (NSArray *)accessibilityActionNames {
    return [NSArray arrayWithObjects:NSAccessibilityIncrementAction, NSAccessibilityDecrementAction, nil];
}

- (NSString *)accessibilityActionDescription:(NSString *)action {
    if ([action isEqualToString:NSAccessibilityIncrementAction]) {
        return NSLocalizedString(@"Increment", "Description of time increment action, for accessibility purposes");
    } else if ([action isEqualToString:NSAccessibilityDecrementAction]) {
        return NSLocalizedString(@"Decrement", "Description of time decrement action, for accessibility purposes");
    } else {
        return [super accessibilityActionDescription:action];
    }
}

- (void)accessibilityPerformAction:(NSString *)action {
    if ([action isEqualToString:NSAccessibilityIncrementAction]) {
        [self moveRight:self];
    } else if ([action isEqualToString:NSAccessibilityDecrementAction]) {
        [self moveLeft:self];
    } else {
        [super accessibilityPerformAction:action];
    }
}

@end

