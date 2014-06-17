//
//  RaiderCommentViewController.h
//  Account
//
//  Created by wang zhe on 8/2/13.
//
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "FoodRaidersDetailsModel.h"
#import "UIKeyboardViewController.h"

@interface RaiderCommentViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UITextViewDelegate,UIKeyboardViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextView *commentContent;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) FoodRaidersDetailsModel *foodRaiderDetailModel;
- (IBAction)submit:(id)sender;
- (IBAction)backgroundTap:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *tip;
@end
