//
//  ViewController.h
//  AccountCalculatorViewController
//
//  Created by wang zhe on 7/16/13.
//
//

#import <UIKit/UIKit.h>
#import "UIKeyboardViewController.h"

@interface LoginViewController : UIViewController<UIKeyboardViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIImageView *rememberPassword;
@property (weak, nonatomic) IBOutlet UIImageView *autoLogin;
@property (weak, nonatomic) IBOutlet UILabel *rememberPasswordText;
@property (weak, nonatomic) IBOutlet UILabel *autoLoginText;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UIButton *registerButton;

@property (weak, nonatomic) NSDictionary *registeredUserDictionary;
- (IBAction)login:(id)sender;
- (IBAction)backgroundTap:(id)sender;
-(IBAction)userRegister:(id)sender;

@property (weak, nonatomic) NSString *userNameforpass;
@property (weak, nonatomic) NSString *passWordforpass;
@property (weak, nonatomic) NSString *rememberedPasswordforpass;
@property (weak, nonatomic) NSString *autoLoginforpass;
@property (weak, nonatomic) UIColor *loginButtonTitleColor;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end
