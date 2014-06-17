//
//  CardViewController.h
//  Account
//
//  Created by wang zhe on 8/3/13.
//
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface CardViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *cardID;
@property (weak, nonatomic) IBOutlet UITextField *cardcode;
- (IBAction)bind:(id)sender;
- (IBAction)backgroundTap:(id)sender;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end
