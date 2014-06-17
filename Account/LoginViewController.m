//
//  ViewController.m
//  Account
//
//  Created by wang zhe on 7/16/13.
//
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "userViewController.h"
#import "Common.h"
#import "SVProgressHUD.h"
#import "UserInfosModel.h"
#import "GlobalVariateModel.h"
#import "Common.h"

@interface LoginViewController ()
{
    BOOL internetStatusBool;
    UIKeyboardViewController *keyBoardController;
    UserInfosModel *userInfosModel;
    GlobalVariateModel *globalVariateModel;
    BOOL isRememberPassword;
    BOOL isAutoLogin;
    Common *common;
}

@end

@implementation LoginViewController


-(void)viewWillAppear:(BOOL)animated
{
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top.png"] forBarMetrics:UIBarMetricsDefault];//导航栏背景
    


}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top.png"] forBarMetrics:UIBarMetricsDefault];//导航栏背景

    common = [[Common alloc] init];
    userInfosModel = [[UserInfosModel alloc] init];
    globalVariateModel = [[GlobalVariateModel alloc] init];
    
    //这是返回按钮用图片表示的一种做法
    [common returnButton:self];
    
	// Do any additional setup after loading the view, typically from a nib.
    self.title = @"登录";
    keyBoardController=[[UIKeyboardViewController alloc] initWithControllerDelegate:self];
	[keyBoardController addToolbarToKeyboard];
    
    NSString *internetStatus = [globalVariateModel internetIsAvailable];
    
    internetStatusBool = [common judgeInternetIsAvailable:internetStatus];
    //如果没有网络，则取到的数据为空
    if(internetStatusBool == NO)
    {
        self.title = @"网络有问题";
    }
    else
    {
        //初始化
        self.username.text = self.userNameforpass;
        self.password.text = self.passWordforpass;
    }
    self.rememberPassword.image = [UIImage imageNamed:@"checkbuttonyes.PNG"];
    self.autoLogin.image = [UIImage imageNamed:@"checkbuttonyes.PNG"];
    isRememberPassword = YES;
    isAutoLogin = YES;
    
    self.autoLogin.userInteractionEnabled = YES;
    self.autoLoginText.userInteractionEnabled = YES;
    self.rememberPassword.userInteractionEnabled = YES;
    self.rememberPasswordText.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *autoLogin = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(autoLoginAction:)];
    UITapGestureRecognizer *passwordIsRembered = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rememberPasswordAction:)];
    UITapGestureRecognizer *autoLoginText = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(autoLoginAction:)];
    UITapGestureRecognizer *passwordIsRemberedText = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rememberPasswordAction:)];
    
    [self.autoLogin addGestureRecognizer:autoLogin];
    [self.rememberPassword addGestureRecognizer:passwordIsRembered];
    [self.autoLoginText addGestureRecognizer:autoLoginText];
    [self.rememberPasswordText addGestureRecognizer:passwordIsRemberedText];
    
    self.scrollView.userInteractionEnabled = YES;
    UITapGestureRecognizer *scrollViewAction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTap:)];
    [self.scrollView addGestureRecognizer:scrollViewAction];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
}



-(void)userViewAction:(id)sender
{
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController popViewControllerAnimated:YES];
}


//记住密码
-(void)rememberPasswordAction:(UITapGestureRecognizer *) sender
{
    if(isRememberPassword == YES)
    {
        self.rememberPassword.image = [UIImage imageNamed:@"checkbuttonno.PNG"];
        isRememberPassword = NO;
        self.autoLogin.image = [UIImage imageNamed:@"checkbuttonno.PNG"];
        isAutoLogin = NO;
    }
    else
    {
        self.rememberPassword.image = [UIImage imageNamed:@"checkbuttonyes.PNG"];
        isRememberPassword = YES;
    }
    [self.username resignFirstResponder];
    [self.password resignFirstResponder];
}

//自动登陆
-(void)autoLoginAction:(UITapGestureRecognizer *)sender
{
    if(isAutoLogin == YES)
    {
        self.autoLogin.image = [UIImage imageNamed:@"checkbuttonno.PNG"];
        isAutoLogin = NO;
    }
    else
    {
        self.autoLogin.image = [UIImage imageNamed:@"checkbuttonyes.PNG"];
        self.rememberPassword.image = [UIImage imageNamed:@"checkbuttonyes.PNG"];
        isRememberPassword = YES;
        isAutoLogin = YES;
    }
    [self.username resignFirstResponder];
    [self.password resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//注册
- (IBAction)userRegister:(id)sender {
    RegisterViewController *registerView = [[RegisterViewController alloc] init];
    registerView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:registerView animated:YES];
    self.hidesBottomBarWhenPushed = YES;
}

//登录
- (IBAction)login:(id)sender {
    
//    [self.loginButton setBackgroundColor:[UIColor colorWithRed:188/255.0 green:128/255.0 blue:0/255.0 alpha:1.0]];
    
    NSString *username = self.username.text;
    NSString *password = self.password.text;
    
    //用户名为空
    if([username isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"用户名不能为空"];
        return;
    }
    else
    {
        //如果没有网络，则取到的数据为空
        if(internetStatusBool == NO)
        {
            self.title = @"未登录";
        }
        else
        {
            [SVProgressHUD show];
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                
                //向服务器提交的数据，进行验证用户名和密码
                [userInfosModel setUserInfosWithUsername:username andUserPWord:password];
                NSArray *loginUserArray = userInfosModel.userInfos;
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                    if([loginUserArray count] == 1)
                    {
                        if(isRememberPassword)
                        {
                            [globalVariateModel setPasswordIsRemembered:@"yes"];
                        }
                        else
                        {
                            [globalVariateModel setPasswordIsRemembered:@"no"];
                        }
                        if(isAutoLogin)
                        {
                            [globalVariateModel setIsAutoLogin:@"yes"];
                        }
                        else
                        {
                            [globalVariateModel setIsAutoLogin:@"no"];
                        }
                        //保存用户信息，设置用户信息为全局变量
                        NSDictionary *userInfos = [loginUserArray objectAtIndex:0];
                        [globalVariateModel setUserInfos:userInfos];
                        [globalVariateModel setIsLogin:@"yes"];
                        [SVProgressHUD showSuccessWithStatus:@"登陆成功"];
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                    else
                    {
                        [SVProgressHUD showErrorWithStatus:@"用户名不存在，或者密码错误"];
                        [self.username becomeFirstResponder];
                        return;
                    }
                });
            });
        }
    }
}

- (IBAction)backgroundTap:(id)sender {
    [self.username resignFirstResponder];
    [self.password resignFirstResponder];
}


@end











