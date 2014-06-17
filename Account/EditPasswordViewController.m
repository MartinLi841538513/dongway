//
//  EditPasswordViewController.m
//  Account
//
//  Created by wang zhe on 7/26/13.
//
//

#import "EditPasswordViewController.h"
#import "LoginViewController.h"
#import "UserViewController.h"
#import "Common.h"
#import "SVProgressHUD.h"
#import "StateModel.h"
#import "GlobalVariateModel.h"
#import "UserInfosModel.h"

@interface EditPasswordViewController ()
{
    UIKeyboardViewController *keyBoardController;
    StateModel *stateModel;
    GlobalVariateModel *globalVariateModel;
    Common *common;
}
@end

@implementation EditPasswordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    
    self.title = @"修改密码";
}

-(void)return:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //这是返回按钮用图片表示的一种做法
    common = [[Common alloc] init];
    [common returnButton:self];
    
    // Do any additional setup after loading the view from its nib.
    keyBoardController=[[UIKeyboardViewController alloc] initWithControllerDelegate:self];
	[keyBoardController addToolbarToKeyboard];
    stateModel = [[StateModel alloc] init];
    globalVariateModel = [[GlobalVariateModel alloc] init];
    
    self.scrollView.userInteractionEnabled = YES;
    UITapGestureRecognizer *scrollViewAction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTap:)];
    [self.scrollView addGestureRecognizer:scrollViewAction];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)confirmEditPassword:(id)sender {
    
    UserInfosModel *userInfoModel =[[UserInfosModel alloc] init];
    [userInfoModel setPropertysWithDictionary:globalVariateModel.userInfos];
    
    NSString *username = userInfoModel.userName;
    NSString *password = userInfoModel.passWord;
    NSString *oldPassword = self.oldPassword.text;
    NSString *theNewPassword = self.theNewPassword.text;
    NSString *confirmedPassword = self.confirmedPassword.text;
    if([oldPassword isEqualToString:@""]||oldPassword==nil)
    {
        [SVProgressHUD showErrorWithStatus:@"请输入原密码"];
        [self.oldPassword becomeFirstResponder];
        return;
    }
    else if([oldPassword length] < 6)
    {
        [SVProgressHUD showErrorWithStatus:@"原密码错误"];
        [self.oldPassword becomeFirstResponder];
        return;
    }
    else if([theNewPassword length] < 6||theNewPassword==nil)
    {
        [SVProgressHUD showErrorWithStatus:@"密码长度应不小于6"];
        [self.theNewPassword becomeFirstResponder];
        return;
    }
    else if([confirmedPassword length] < 6||confirmedPassword==nil)
    {
        [SVProgressHUD showErrorWithStatus:@"密码长度应不小于6"];
        [self.oldPassword becomeFirstResponder];
        return;
    }
    else if(![oldPassword isEqualToString:password])
    {
        [SVProgressHUD showErrorWithStatus:@"原密码错误"];
        [self.oldPassword becomeFirstResponder];
        return;
    }
    
    else if(![theNewPassword isEqualToString:confirmedPassword])
    {
        [SVProgressHUD showErrorWithStatus:@"两次输入密码不一样"];
        [self.theNewPassword becomeFirstResponder];
        return;
    }
    else
    {
        [SVProgressHUD show];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            [stateModel pWordChangeStateWithOldPassword:oldPassword andNewPassword:theNewPassword andUsername:username];
            NSString *state = stateModel.state;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
                
                if([state isEqualToString:@"1"])
                {
                    [globalVariateModel setIsLogin:@"yes"];
                    [SVProgressHUD showSuccessWithStatus:@"修改成功!"];
                    
                    [self.navigationController popViewControllerAnimated:YES];
                    dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    
                        
                        [userInfoModel setUserInfosWithUsername:username andUserPWord:theNewPassword];
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            NSArray *loginUserArray = userInfoModel.userInfos;
                            NSDictionary *userInfos = [loginUserArray objectAtIndex:0];
                            [globalVariateModel setUserInfos:userInfos];
                        });
                    });
                }
                else if([state isEqualToString:@"0"])
                {
                    [SVProgressHUD showErrorWithStatus:@"修改失败!"];
                    return;
                }
            });
        });
    }
}


- (IBAction)backgroundTap:(id)sender {
    [self.oldPassword resignFirstResponder];
    [self.theNewPassword resignFirstResponder];
    [self.confirmedPassword resignFirstResponder];
    
}
@end
