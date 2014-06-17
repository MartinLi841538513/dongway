//
//  OrderCollectionViewController.h
//  Account
//
//  Created by dongway on 13-11-4.
//
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMessageComposeViewController.h>

@interface OrderCollectionViewController : UIViewController<MFMessageComposeViewControllerDelegate,UIActionSheetDelegate>

@property (strong, nonatomic) NSArray *ordersInformationArray;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segement;
- (IBAction)segementAction:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *tip;

@end
