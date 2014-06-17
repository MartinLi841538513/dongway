//
//  CardViewController.m
//  Account
//
//  Created by wang zhe on 8/3/13.
//
//

#import "CardViewController.h"
#import "SVProgressHUD.h"
#import "StateModel.h"
#import "GlobalVariateModel.h"
#import "UserInfosModel.h"
#import "Common.h"
#import "CardHighLightViewController.h"

@interface CardViewController ()
{
    StateModel *stateModel;
    GlobalVariateModel *globalVariateModel;
    UserInfosModel *userInfosModel;
    Common *common;
    UIImageView *tipView;
}

@end

@implementation CardViewController

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
    self.title = @"我的达人卡";
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    //这是返回按钮用图片表示的一种做法
    common = [[Common alloc] init];
    [common returnButton:self];
    
    self.cardID.delegate = self;
    self.cardcode.delegate = self;
    
    // Do any additional setup after loading the view from its nib.
    stateModel =[[StateModel alloc] init];
    globalVariateModel = [[GlobalVariateModel alloc] init];
    userInfosModel = [[UserInfosModel alloc] init];
    [userInfosModel setPropertysWithDictionary:[globalVariateModel userInfos]];
    
    self.scrollView.userInteractionEnabled = YES;
    UITapGestureRecognizer *scrollViewAction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTap:)];
    [self.scrollView addGestureRecognizer:scrollViewAction];
    
    //如果是第一次使用这个软件，展示欢迎界面
    if(![globalVariateModel.isFirstTimeEnterCardView isEqualToString:@"no"])
    {
        //如果是第一次使用这个软件，展示提示界面
        [UIView animateWithDuration:0.2 animations:^{
            
            tipView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cardTips.jpg"]];
            [tipView setFrame:CGRectMake(0, 20, 320, [UIScreen mainScreen].bounds.size.height-20)];
            [self.navigationController.tabBarController.view addSubview:tipView];
            self.navigationController.navigationBarHidden = YES;
            tipView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tipViewActionButton = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tipViewAction:)];
            [tipView addGestureRecognizer:tipViewActionButton];
        }];
    }

    
}
-(void)tipViewAction:(id)sender
{
    [UIView animateWithDuration:0.6 animations:^{
        
        self.navigationController.navigationBarHidden = NO;
        [tipView removeFromSuperview];
        [globalVariateModel setIsFirstTimeEnterCardView:@"no"];

    }];
    
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

//绑定达人卡
- (IBAction)bind:(id)sender {
    
    if([common judgeUserIsLoginOrNot:self] == NO)
        return;
    
    [self keyboardDidHide];

    [SVProgressHUD show];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSString *userID = userInfosModel.ID;
        NSString *cardID = self.cardID.text;
        NSString *cardCode = self.cardcode.text;
        
        [stateModel cardAddStateWithUserID:userID andCardID:cardID andCardCode:cardCode];
        NSString *state = stateModel.state;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            if([state isEqualToString:@"1"])
            {
                [SVProgressHUD showSuccessWithStatus:@"绑定成功!"];
                CardHighLightViewController *cardHighLightViewController = [[CardHighLightViewController alloc] initWithNibName:@"CardHighLightViewController" bundle:nil];
                cardHighLightViewController.userInfosModel = userInfosModel;
                [self.view addSubview:cardHighLightViewController.view];
            }
            else if([state isEqualToString:@"-1"])
            {
                [SVProgressHUD showErrorWithStatus:@"绑定错误!"];
                return;
            }
            else
            {
                [SVProgressHUD showErrorWithStatus:@"绑定失败!"];
                return;
            }
        });
    });
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self keyboardWillShow];
    return YES;
}

- (void) keyboardWillShow
{
    // move the view up by 30 pts
    CGRect frame = self.view.frame;
    frame.origin.y = -68;
    
    [UIView animateWithDuration:0.7 animations:^{
        self.view.frame = frame;
    }];
}

- (void) keyboardDidHide
{
    // move the view back to the origin
    CGRect frame = self.view.frame;
    frame.origin.y = 0;
    
    [UIView animateWithDuration:0.7 animations:^{
        self.view.frame = frame;
    }];
}
- (IBAction)backgroundTap:(id)sender {
    
    [self.cardID resignFirstResponder];
    [self.cardcode resignFirstResponder];
    [self keyboardDidHide];
}
@end
