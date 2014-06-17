//
//  SubButton.h
//  Account
//
//  Created by dongway on 13-11-19.
//
//

#import <UIKit/UIKit.h>

@interface SubButton : UIButton
{
    UIViewController *anObject;
}

@property (nonatomic, retain) id anObject;

- (void)addTarget:(id)target action:(SEL)action withObject:(id)object forControlEvents:(UIControlEvents)controlEvents;

@end
