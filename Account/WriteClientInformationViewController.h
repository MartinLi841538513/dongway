//
//  WriteClientInformationViewController.h
//  Account
//
//  Created by wang zhe on 7/24/13.
//
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "StoresModel.h"
#import "UIKeyboardViewController.h"

@interface WriteClientInformationViewController : UIViewController<UIActionSheetDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIKeyboardViewControllerDelegate>

@property (strong, nonatomic) NSString *tableNumberForPass;
@property (weak, nonatomic) NSString *min_maxPeopleNumberForPass;
@property (weak, nonatomic) NSString *minPriceForPass;
@property (strong, nonatomic) IBOutlet UILabel *tableNumber;
@property (strong, nonatomic) IBOutlet UILabel *min_maxPeopleNumber;
@property (strong, nonatomic) IBOutlet UILabel *minPrice;

@property (weak, nonatomic) IBOutlet UITextField *dateAndRepastTime;

@property (weak, nonatomic) IBOutlet UIButton *repastTime;
@property (weak, nonatomic) IBOutlet UITextField *name;
- (IBAction)setTime:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *manRadio;
@property (weak, nonatomic) IBOutlet UIImageView *womanRadio;
@property (weak, nonatomic) IBOutlet UILabel *manText;
@property (weak, nonatomic) IBOutlet UILabel *womanText;

@property (weak, nonatomic) IBOutlet UITextField *tel;
@property (weak, nonatomic) IBOutlet UITextField *numbersOfPerson;
@property (weak, nonatomic) IBOutlet UITextField *tips;
- (IBAction)submit:(id)sender;

- (IBAction)backgroundTap:(id)sender;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) StoresModel *storesModel;
@property (assign, nonatomic) BOOL hallRadioSelected;
@property (assign, nonatomic) BOOL roomRadioSelected;
@property (assign, nonatomic) BOOL lunchSelected;
@property (assign, nonatomic) BOOL dinnerSelected;
@property (strong, nonatomic) NSString *orderTime;
@property (strong, nonatomic) NSString *tableID;




@end
