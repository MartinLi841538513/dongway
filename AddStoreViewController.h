//
//  storeByUserViewController.h
//  Account
//
//  Created by wang zhe on 8/3/13.
//
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "SXRateView.h"
#import "UIKeyboardViewController.h"

@interface AddStoreViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate, SXRateViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIActionSheetDelegate,UIKeyboardViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *storeName;
@property (weak, nonatomic) IBOutlet UITextField *address;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *recommendDish;
@property (weak, nonatomic) IBOutlet UITextField *price;
@property (weak, nonatomic) IBOutlet UITextView *decriptionContent;
@property (strong, nonatomic) IBOutlet SXRateView *score;
@property (strong, nonatomic) IBOutlet SXRateView *service;
@property (strong, nonatomic) IBOutlet SXRateView *environment;
@property (strong, nonatomic) IBOutlet SXRateView *taste;
@property (weak, nonatomic) IBOutlet UIButton *categorySelect;
- (IBAction)selectCategory:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *pulldownButton;

- (IBAction)submit:(id)sender;
- (IBAction)backgroundTap:(id)sender;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
- (void) rateChange;

@end
