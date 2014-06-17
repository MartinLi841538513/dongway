//
//  StoreDetailViewController.h
//  Account
//
//  Created by wang zhe on 9/17/13.
//
//

#import <UIKit/UIKit.h>
@class StoresModel;
@class DiscountInfosModel;
#import "MyDelegate.h"
#import "UIMenuBar.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMessageComposeViewController.h>

@interface StoreDetailViewController : UIViewController<UITextFieldDelegate,MyDelegate,UIMenuBarDelegate,UITableViewDataSource,UITableViewDelegate,MFMessageComposeViewControllerDelegate>

@property (nonatomic) BOOL isDiscountStore;
@property (nonatomic) BOOL isCollectedStore;

@property (strong, nonatomic) StoresModel *storesModel;
@property (strong, nonatomic) NSString *latitude;
@property (strong, nonatomic) NSString *longitude;
@property (strong,nonatomic) NSString *locationName;
@property (strong, nonatomic) DiscountInfosModel *discountInfosModel;
@property (strong, nonatomic) NSArray *comments;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end
