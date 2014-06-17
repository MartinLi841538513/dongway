//
//  SXFeastActivityViewController.h
//  Account
//
//  Created by Sam Xie on 8/15/13.
//
//

#import <UIKit/UIKit.h>

@interface FeastActivityViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

- (IBAction)changeActivityTable:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *tip;
@end
