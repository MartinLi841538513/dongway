//
//  NearbyViewController.h
//  Account
//
//  Created by wang zhe on 9/9/13.
//
//

#import <UIKit/UIKit.h>
#import "PullingRefreshTableView.h"
#import "MyDelegate.h"

@interface NearbyViewController : UIViewController<
PullingRefreshTableViewDelegate,
UITableViewDataSource,
UITableViewDelegate,MyDelegate
>
@property (strong, nonatomic)  PullingRefreshTableView *tableView;
@property (nonatomic) BOOL refreshing;

@property (nonatomic) BOOL isAdvancedSearch;

@property (weak, nonatomic) NSString *catForPass;
@property (weak, nonatomic) NSString *radiusForPass;
@property (copy, nonatomic) NSString *termForPass;
@property (weak, nonatomic) NSString *sortForPass;
@property (weak, nonatomic) NSString *priceForPass;
@property (weak, nonatomic) NSString *latitudeForPass;
@property (weak, nonatomic) NSString *longitudeForPass;
@property (weak, nonatomic) NSString *pageForPass;
@property (copy, nonatomic) NSString *locationName;
@property (strong, nonatomic) IBOutlet UILabel *tip;
- (IBAction)refreshAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *refreshButton;


@end
