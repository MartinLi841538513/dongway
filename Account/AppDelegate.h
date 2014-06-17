//
//  AppDelegate.h
//  Account
//
//  Created by wang zhe on 7/16/13.
//
//

#import <UIKit/UIKit.h>
@class ViewController;
@class LoginViewController;
@class Common;
@class Reachability;
@class GlobalVariateModel;
@class UserInfosModel;
@class Common;
@class MLNavigationController;

@interface AppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate>
{
    MLNavigationController *fifthNavigation ;
    MLNavigationController *firstNavigation ;
    MLNavigationController *secondNavigation ;
    MLNavigationController *thirdNavigation ;
    MLNavigationController *fouthNavigation ;
    UITabBarItem *customItem1;
    UITabBarItem *customItem2;
    UITabBarItem *customItem3;
    UITabBarItem *customItem4;
    UITabBarItem *customItem5;
    Reachability  *hostReach;
    GlobalVariateModel *globalVariateModel;
    UserInfosModel *userInfosModel;
    NSDictionary *userInfos;
    Common *common;
    
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ViewController *viewController;
@property (strong, nonatomic) UITabBarController *tabBarController;


@end
