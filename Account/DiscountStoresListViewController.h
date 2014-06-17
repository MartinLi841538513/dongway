//
//  AllCouponStoreViewController.h
//  Account
//
//  Created by wang zhe on 8/20/13.
//
//

#import <UIKit/UIKit.h>
#import "PullingRefreshTableView.h"
@interface DiscountStoresListViewController : UIViewController<
PullingRefreshTableViewDelegate,
UITableViewDataSource,
UITableViewDelegate
>
@property (strong, nonatomic)  PullingRefreshTableView *tableView;
@property (nonatomic) BOOL refreshing;

@end
