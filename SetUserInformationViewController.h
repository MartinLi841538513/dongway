//
//  SetUserInformationViewController.h
//  Account
//
//  Created by wang zhe on 9/13/13.
//
//

#import <UIKit/UIKit.h>
@class UserInfosModel;

@interface SetUserInformationViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *userInfors;

@property (weak, nonatomic) UserInfosModel *userInfosModel;
@property (weak, nonatomic) IBOutlet UILabel *loginOutButton;

@property (strong, nonatomic) IBOutlet UILabel *userName;
@property (strong, nonatomic) IBOutlet UILabel *userTitle;

@property (strong, nonatomic) IBOutlet UILabel *userPoint;
@property (strong, nonatomic) IBOutlet UIImageView *imageUrl;

@end
