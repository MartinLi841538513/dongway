//
//  FoodRaiderViewController.h
//  Account
//
//  Created by wang zhe on 7/23/13.
//
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface FoodRaiderViewController : UIViewController<UITableViewDataSource, UITextFieldDelegate,UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UITextField *raiderName;
@property (strong, nonatomic) IBOutlet UIButton *searchButton;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)backrgroundTap:(id)sender;
- (IBAction)search:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *tip;

@end
