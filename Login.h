//
//  Login.h
//  Account
//
//  Created by wang zhe on 8/4/13.
//
//

#import <Foundation/Foundation.h>
@class LoginViewController;
@class GlobalVariateModel;
@class UserInfosModel;

@interface Login : NSObject
{
    GlobalVariateModel *globalVariateModel;
    UserInfosModel *userInfosModel;
}

-(void)loginViewInit:(LoginViewController *)loginViewController;

-(id)init;

@end
