//
//  RegisterViewController.h
//  Account
//
//  Created by wang zhe on 7/16/13.
//
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "UIKeyboardViewController.h"

@interface RegisterViewController : UIViewController<UIActionSheetDelegate,UIKeyboardViewControllerDelegate>
- (IBAction)sendCodeNumber:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *passwordConfirm;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *authenticode;
@property (weak, nonatomic) IBOutlet UILabel *registerProtocol;
@property (weak, nonatomic) IBOutlet UIImageView *registerProtocolCheckbox;
@property (weak, nonatomic) IBOutlet UILabel *registerProtocolCheck;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)backgroundTap:(id)sender;
- (IBAction)userRegister:(id)sender;
@end
