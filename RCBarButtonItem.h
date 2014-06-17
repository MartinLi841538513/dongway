//
//  RCBarButtonItem.h
//  Account
//
//  Created by wang zhe on 8/4/13.
//
//

#import <UIKit/UIKit.h>

@interface RCBarButtonItem : UIBarButtonItem
{
    UIViewController *anObject;
}

@property (nonatomic, retain) id anObject;

- (id)initWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style target:(id)target action:(SEL)action withObject:(id)obj;


@end
