//
//  EditPasswordViewController.h
//  Account
//
//  Created by wang zhe on 7/26/13.
//
//

#import <UIKit/UIKit.h>
#import "UIKeyboardViewController.h"

@interface EditPasswordViewController : UIViewController<UIActionSheetDelegate,UIKeyboardViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *oldPassword;
@property (weak, nonatomic) IBOutlet UITextField *confirmedPassword;
- (IBAction)confirmEditPassword:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *theNewPassword;
- (IBAction)backgroundTap:(id)sender;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end
