//
//  userViewController.m
//  Account
//
//  Created by wang zhe on 7/16/13.
//
//

#import "userViewController.h"
#import "LoginViewController.h"
#import "OrderCollectionViewController.h"
#import "StoresCollectionViewController.h"
#import "FoodRaidersCollectionViewController.h"
#import "EditPasswordViewController.h"
#import "CardViewController.h"
#import "Common.h"
#import "SVProgressHUD.h"
#import "GlobalVariateModel.h"
#import "UserInfosModel.h"
#import "SetUserInformationViewController.h"
#import "CardHighLightViewController.h"

@interface UserViewController ()
{
    NSMutableArray *userAllInfos;
    NSArray *storesCollection;
    NSString *userName;
    UIMenuBar *menuBar;
    Common *common;
    BOOL internetStatusBool;
    GlobalVariateModel *globalVariateModel;
    UserInfosModel *userInfosModel;
    UIView *viewUnderline;
    UITableView *tableview;
}
@end

@implementation UserViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}




- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib
    [self.navigationItem setTitle:@"懂     客"];
    [self.navigationController setNavigationBarHidden:NO animated:NO];//显示导航栏
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top.png"] forBarMetrics:UIBarMetricsDefault];//导航栏背景
    [self.navigationController.navigationBar setBackgroundColor:[UIColor orangeColor]];
    
    UITapGestureRecognizer *setUserInformation = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setUserInformationAction:)];
    [self.image2 addGestureRecognizer:setUserInformation];
    
    
    //给图片设置边框
    [self.imageUrl.layer setBorderWidth:3];
    [self.imageUrl.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, self.image2.frame.origin.y+self.image2.frame.size.height, 320, 200)];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.scrollEnabled = NO;
    [self.scrollView addSubview:tableview];
}

-(void)viewWillAppear:(BOOL)animated
{
    [SVProgressHUD dismiss];
    globalVariateModel = [[GlobalVariateModel alloc] init];
    userInfosModel = [[UserInfosModel alloc] init];
    [userInfosModel setPropertysWithDictionary:[globalVariateModel userInfos]];
    common = [[Common alloc] init];
    
    //判断用户是否处于的登陆状态
    if([common isLogin] == NO)
    {
        
        //用户处于未登陆状态
        self.username.text = @"登录／注册";
        //        self.username=[common setLabelUnderline:self.username];
        CGSize expectedLabelSize = [self.username.text sizeWithFont:self.username.font constrainedToSize:self.username.frame.size lineBreakMode:self.username.lineBreakMode];
        viewUnderline=[[UIView alloc] init];
        viewUnderline.frame=CGRectMake((self.username.frame.size.width - expectedLabelSize.width)/2-30,    expectedLabelSize.height + (self.username.frame.size.height - expectedLabelSize.height)/2,   expectedLabelSize.width, 1);
        viewUnderline.backgroundColor=self.username.textColor;
        [self.username addSubview:viewUnderline];
        self.createTime.text = @"";
        self.userTitle.text = @"";
        return;
    }
    NSString *internetStatus = [globalVariateModel internetIsAvailable];
    internetStatusBool = [common judgeInternetIsAvailable:internetStatus];
    //如果没有网络，则取到的数据为空
    if(internetStatusBool == NO)
    {
        //用户处于未登陆状态
        self.username.text = @"网络不可用";
        self.createTime.text = @"";
        self.userTitle.text = @"";
        return;
    }
    else
    {
        //显示懂客信息
        userName = userInfosModel.userName;
        [viewUnderline removeFromSuperview];
        self.username.text = userName;
        self.createTime.text = userInfosModel.createTime;
        self.userTitle.text = userInfosModel.userTitle;
        
    }
    
//    //第一次不加载viewdidload，因为系统本身会加载的。pop回来的时候需要加载
//    static int i = 0;
//    if(i != 0)
//    {
//        [self viewDidLoad];
//    }
//    i++;
}

//用户信息详情
-(void)setUserInformationAction:(id)sender
{
    //判断用户是否处于的登陆状态
    if([common isLogin] == NO)
    {
        LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        if([[globalVariateModel passwordIsRemembered] isEqualToString:@"yes"])
        {
            loginViewController.passWordforpass = userInfosModel.passWord;
        }
        else
        {
            loginViewController.passWordforpass = @"";
        }
        loginViewController.userNameforpass = userInfosModel.userName;
        
        loginViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginViewController animated:YES];
        [loginViewController setTitle:@"尚未登录"];
    }
    else
    {
        SetUserInformationViewController *setUserInformationViewController = [[SetUserInformationViewController alloc] initWithNibName:@"SetUserInformationViewController" bundle:nil];
        setUserInformationViewController.userInfosModel = userInfosModel;
        setUserInformationViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:setUserInformationViewController animated:YES];
    }
}


-(void)viewDidDisappear:(BOOL)animated
{
    
}

-(void)viewDidAppear:(BOOL)animated
{
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSUInteger section = [indexPath section];
    static NSString *CellIdentifier = @"SectionsTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.font = [UIFont fontWithName:@"Courier" size:15.0];
    cell.textLabel.textColor = [UIColor colorWithRed:0.2 green:0 blue:0 alpha:1];
    if(section == 0)
        cell.textLabel.text = @"订   单";
    else if(section == 1)
        cell.textLabel.text = @"商家收藏";
    else if(section == 2)
        cell.textLabel.text = @"攻略收藏";
    else if(section == 3)
        cell.textLabel.text = @"达人卡专区";
    // Configure the cell...
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 50;
}


//选中一行，called
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([common judgeUserIsLoginOrNot:self] == NO)
        return;
    NSUInteger section = [indexPath section];
    
    //订单
    if(section == 0)
    {
        OrderCollectionViewController *orderView = [[OrderCollectionViewController alloc] initWithNibName:@"OrderCollectionViewController" bundle:nil];
        orderView.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:orderView animated:YES];
        [orderView setTitle:@"当前订单"];
    }
    //点击商家收藏，跳转到商家收藏界面
    else if(section == 1)
    {
        //跳转到商家收藏界面
        StoresCollectionViewController *restaurantCollectionView = [[StoresCollectionViewController alloc] initWithNibName:@"StoresCollectionViewController" bundle:nil];
        restaurantCollectionView.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:restaurantCollectionView animated:YES];
        
    }
    else if(section == 2)
    {
        FoodRaidersCollectionViewController *foodStrategyCollectionView = [[FoodRaidersCollectionViewController alloc] initWithNibName:@"FoodRaidersCollectionViewController" bundle:nil];
        foodStrategyCollectionView.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:foodStrategyCollectionView animated:YES];
    }
    else if(section == 3)
    {
        NSString *isVIP = userInfosModel.is_vip;
        //0表示没有绑定达人卡，1表示已经绑定了达人卡
        if([isVIP isEqualToString:@"0"])
        {
            CardViewController *cardViewController = [[CardViewController alloc] initWithNibName:@"CardViewController" bundle:nil];
            cardViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:cardViewController animated:YES];
        }
        else if([isVIP isEqualToString:@"1"])
        {
            CardHighLightViewController *cardViewCotroller = [[CardHighLightViewController alloc] initWithNibName:@"CardHighLightViewController" bundle:nil];
            cardViewCotroller.hidesBottomBarWhenPushed = YES;
            cardViewCotroller.userInfosModel = userInfosModel;
            [self.navigationController pushViewController:cardViewCotroller animated:YES];
        }
    }
    
}

@end








