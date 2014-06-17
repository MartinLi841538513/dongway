//
//  CardHighLightViewController.h
//  Account
//
//  Created by dongway on 13-11-21.
//
//

#import <UIKit/UIKit.h>
@class UserInfosModel;

@interface CardHighLightViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *cardID;
@property (strong, nonatomic) UserInfosModel *userInfosModel;

@end
