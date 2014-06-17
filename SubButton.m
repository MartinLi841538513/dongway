//
//  SubButton.m
//  Account
//
//  Created by dongway on 13-11-19.
//
//

#import "SubButton.h"

@implementation SubButton
@synthesize anObject;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)addTarget:(id)target action:(SEL)action withObject:(id)object forControlEvents:(UIControlEvents)controlEvents
{
    [super addTarget:target action:action forControlEvents:controlEvents];
    self.anObject = object;
}

@end
