//
//  IndexViewController.h
//  Account
//
//  Created by wang zhe on 9/9/13.
//
//

#import <UIKit/UIKit.h>
#import "EScrollerView.h"
#import "EAIntroView.h"

@interface IndexViewController : UIViewController<EScrollerViewDelegate,UITableViewDataSource,UITableViewDelegate,EAIntroDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableview;

@end
