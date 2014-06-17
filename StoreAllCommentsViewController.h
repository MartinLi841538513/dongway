//
//  StoreAllCommentsViewController.h
//  Account
//
//  Created by dongway on 13-11-3.
//
//

#import <UIKit/UIKit.h>

@interface StoreAllCommentsViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITableView *storeAllCommentsTableView;
@property (strong, nonatomic) NSArray *comments;

@end
