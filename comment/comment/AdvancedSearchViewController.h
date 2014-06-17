//
//  SXAdvancedSearchViewController.h
//  Account
//
//  Created by Sam Xie on 7/30/13.
//
//

#import <UIKit/UIKit.h>
#import "MyDelegate.h"

@interface AdvancedSearchViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabelInCell;
@property (strong, nonatomic) IBOutlet UIButton *pickerButtonInCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *tableViewCell;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerView;

@property (strong, nonatomic) id<MyDelegate> delegate;

- (IBAction)okClick:(UIButton *)sender;
- (IBAction)cancelClick:(UIButton *)sender;

@end
