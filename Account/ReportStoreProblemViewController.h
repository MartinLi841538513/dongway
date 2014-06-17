//
//  ReportStoreProblemViewController.h
//  Account
//
//  Created by wang zhe on 8/1/13.
//
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "StoresModel.h"

@interface ReportStoreProblemViewController : UIViewController<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *storeProblemContent;
@property (weak, nonatomic) NSString *userName;
@property (weak, nonatomic) StoresModel *storesModel;
- (IBAction)backgroundTap:(id)sender;
- (IBAction)submit:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *submitButton;

@end
