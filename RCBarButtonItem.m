//
//  RCBarButtonItem.m
//  Account
//
//  Created by wang zhe on 8/4/13.
//
//

#import "RCBarButtonItem.h"

@implementation RCBarButtonItem
@synthesize anObject;

- (id)initWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action withObject:(id)obj
{
    if (self = [super initWithTitle:title style:style target:target action:action]) {
        self.anObject = obj;
    }
    return self;
}

@end
