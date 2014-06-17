//
//  Login.m
//  Account
//
//  Created by wang zhe on 8/4/13.
//
//

#import "Login.h"
#import "LoginViewController.h"
#import "GlobalVariateModel.h"
#import "UserInfosModel.h"

@implementation Login

-(id)init
{
    if(self = [super init])
    {
        globalVariateModel = [[GlobalVariateModel alloc] init];
        userInfosModel = [[UserInfosModel alloc] init];
        [userInfosModel setPropertysWithDictionary:[globalVariateModel userInfos]];
    }
    return self;
}

//每次从（功能界面）进入loginview时根据登陆状态初始化数据
-(void)loginViewInit:(LoginViewController *)loginViewController
{
    //从功能菜单跳转过来的判断
    if([[globalVariateModel isLogin] isEqualToString:@"yes"])
    {
        loginViewController.userNameforpass = userInfosModel.userName;
        loginViewController.passWordforpass = userInfosModel.passWord;
        if([[globalVariateModel passwordIsRemembered] isEqualToString:@"yes"])
        {
            loginViewController.rememberedPasswordforpass = @"checkbuttonyes.PNG";
        }
        else
        {
            loginViewController.rememberedPasswordforpass = @"checkbuttonno.PNG";
        }
        if([[globalVariateModel isAutoLogin] isEqualToString:@"yes"])
        {
            loginViewController.autoLoginforpass = @"checkbuttonyes.PNG";
        }
        else
        {
            loginViewController.autoLoginforpass = @"checkbuttonno.PNG";
        }
        loginViewController.title = @"您已登录";
//        loginViewController.loginButtonTitleColor = [UIColor grayColor];
    }
    else
    {
        if([[globalVariateModel passwordIsRemembered] isEqualToString:@"yes"])
        {
            loginViewController.userNameforpass = userInfosModel.userName;
            loginViewController.passWordforpass = userInfosModel.passWord;
            loginViewController.rememberedPasswordforpass = @"checkbuttonyes.PNG";
            loginViewController.autoLoginforpass = @"checkbuttonno.PNG";
        }
        else
        {
            loginViewController.username.text = @"";
            loginViewController.password.text = @"";
            loginViewController.rememberedPasswordforpass = @"checkbuttonno.PNG";
            loginViewController.autoLoginforpass = @"checkbuttonno.PNG";
        }
        loginViewController.title = @"尚未登录";
        loginViewController.loginButtonTitleColor = [UIColor blueColor];
  }

}

@end
