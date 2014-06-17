//
//  MoreViewController.m
//  Account
//
//  Created by wang zhe on 9/16/13.
//
//

#import "MoreViewController.h"
#import "Common.h"
#import "SVProgressHUD.h"
#import "GlobalVariateModel.h"
#import "UserInfosModel.h"
#import "StoresModel.h"
#import "StateModel.h"
#import "AddStoreViewController.h"
#import "HelpViewController.h"
#import "DongwayLifeViewController.h"
#import "AboutDongwayViewController.h"
#import "SoftwareInfosModel.h"
#import "MoreTableViewCell.h"
#import "ChoiceYourLocationViewController.h"


@interface MoreViewController ()
{
    Common *common;
    GlobalVariateModel *globalVariateModel;
    UserInfosModel *userInfosModel;
    StoresModel *storeModel;
    StateModel *stateModel;
    SoftwareInfosModel *softwareInfosModel;
}

@end

@implementation MoreViewController

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
    // Do any additional setup after loading the view from its nib.
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top.png"] forBarMetrics:UIBarMetricsDefault];//导航栏背景
    [self.navigationController.navigationBar setBackgroundColor:[UIColor orangeColor]];
    
//    self.ta
    
    common = [[Common alloc] init];
    storeModel = [[StoresModel alloc] init];
    stateModel = [[StateModel alloc] init];
    globalVariateModel = [[GlobalVariateModel alloc] init];
    userInfosModel = [[UserInfosModel alloc] init];
    [userInfosModel setPropertysWithDictionary:[globalVariateModel userInfos]];
    softwareInfosModel = [[SoftwareInfosModel alloc] init];
    
    self.title = @"更多";
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top.png"] forBarMetrics:UIBarMetricsDefault];//导航栏背景
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
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if(section == 0)
        return 6;
    else
        return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    
    
    
    static NSString *CustomCellIdentifier = @"Cell";
    
    static BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:@"MoreTableViewCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CustomCellIdentifier];
        nibsRegistered = YES;
    }
    
    MoreTableViewCell *cell = (MoreTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    
    cell.detailTextLabel1.hidden = YES;
    if(section == 0)
    {
        if(row == 0)
        {
            cell.textLabel1.text = @"签到";
            cell.imageView1.image = [UIImage imageNamed:@"more0.png"];
        }
        else if(row == 1)
        {
            cell.textLabel1.text = @"告诉朋友";
            cell.imageView1.image = [UIImage imageNamed:@"more1.png"];
        }
        else if(row == 2)
        {
            cell.textLabel1.text = @"关于懂味";
            cell.imageView1.image = [UIImage imageNamed:@"more2.png"];
        }
        else if(row == 3)
        {
            cell.textLabel1.text = @"懂味生活";
            cell.imageView1.image = [UIImage imageNamed:@"more3.png"];
        }
        else if(row == 4)
        {
            cell.textLabel1.text = @"添加商家";
            cell.imageView1.image = [UIImage imageNamed:@"more4.png"];
        }
        else if (row == 5)
        {
            cell.textLabel1.text = @"自选定位地点";
            cell.imageView1.image = [UIImage imageNamed:@"more10.png"];
        }
    }
    else if(section == 1)
    {
        if(row == 0)
        {
            cell.textLabel1.text = @"懂味客服 0731-85589427";
            cell.imageView1.image = [UIImage imageNamed:@"more5.png"];
        }
        else if(row == 1)
        {
            cell.textLabel1.text = @"帮助";
            cell.imageView1.image = [UIImage imageNamed:@"more6.png"];
        }
        else if(row == 2)
        {
            cell.textLabel1.text = @"意见反馈";
            cell.imageView1.image = [UIImage imageNamed:@"more7.png"];
        }
        else if(row == 3)
        {
            NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
            NSString *nowVersion = [infoDict objectForKey:@"CFBundleVersion"];
            cell.textLabel1.text = @"检查更新";
            cell.detailTextLabel1.text = [NSString stringWithFormat:@"当前版本v%@",nowVersion];
            cell.detailTextLabel1.hidden = NO;
            cell.imageView1.image = [UIImage imageNamed:@"more8.png"];
            
        }

    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel1.font = [UIFont fontWithName:@"Courier" size:15.0];
    cell.textLabel1.textColor = [UIColor colorWithRed:0.2 green:0 blue:0 alpha:1];
    cell.imageView1.hidden = NO;

    return cell;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    if (section == 0)
    {
        return @" ";
    }
    else
    {
        return @" ";
    }
    return nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1.0f;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    
    if(section == 0)
    {
        //签到
        if(row == 0)
        {
            if([common judgeUserIsLoginOrNot:self] == NO)
                return;
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy"];
            NSString *year = [dateFormatter stringFromDate:[NSDate date]];
            [dateFormatter setDateFormat:@"MM"];
            NSString *month = [dateFormatter stringFromDate:[NSDate date]];
            [dateFormatter setDateFormat:@"dd"];
            NSString *day = [dateFormatter stringFromDate:[NSDate date]];
            
            if([year isEqualToString:globalVariateModel.year]&&[month isEqualToString:globalVariateModel.month]&&[day isEqualToString:globalVariateModel.day])
            {
                [SVProgressHUD showImage:nil status:@"今日已签到,明天再来吧"];
            }
            else
            {
                [globalVariateModel setYear:year];
                [globalVariateModel setMonth:month];
                [globalVariateModel setDay:day];
                [SVProgressHUD show];
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    
                    NSString *userName = userInfosModel.userName;
                    NSString *latitude = [globalVariateModel latitude];
                    NSString *longtitude = [globalVariateModel longitude];
                    [stateModel checkinAddStateWithUsername:userName andLatitude:latitude andLongitude:longtitude];
                    NSString *state = stateModel.state;
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [SVProgressHUD dismiss];
                        if([state isEqualToString:@"1"])
                        {
                            //签到成功
                            [SVProgressHUD showSuccessWithStatus:@"签到成功"];
                        }
                        else
                        {
                            //签到失败
                            [SVProgressHUD showImage:Nil status:@"今日已签到,明天再来吧"];
                        }
                    });
                });

            }
        }
        //告诉朋友
        else if(row == 1)
        {
            
            //构造分享内容
            id<ISSContent> publishContent = [ShareSDK content:@"懂味美食，以精确定位，以及对长沙本地美食深入研究，给你最好的推荐，快来下载懂味app吧。http://app.dongway.com.cn/"
                                               defaultContent:@"懂味"
                                                        image:[ShareSDK pngImageWithImage:[UIImage imageNamed:@"logo.png"]]
                                                        title:@"懂味长沙"
                                                          url:@"http://app.dongway.com.cn/"
                                                  description:@"基于位置的服务是由电子地图支持，通过一个当时所获知的地理位置向用户提供信息的服务平台。用户可利用移动服务终端通过移动通信网络或者全球卫星导航系统获取地理位置。随着越来越多的移动设备内置了全球定位系统，基于位置的服务在过去的几年中快速发展壮大。http://app.dongway.com.cn/"
                                                    mediaType:SSPublishContentMediaTypeNews];
            [common shareContent:publishContent andViewController:self];
        }
        //关于懂味
        else if(row == 2)
        {
            AboutDongwayViewController *aboutDongwayViewController = [[AboutDongwayViewController alloc] initWithNibName:@"AboutDongwayViewController" bundle:nil];
            aboutDongwayViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:aboutDongwayViewController animated:YES];
        }
        //懂味生活
        else if(row == 3)
        {
            DongwayLifeViewController *dongwayLife = [[DongwayLifeViewController alloc] initWithNibName:@"DongwayLifeViewController" bundle:nil];
            dongwayLife.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:dongwayLife animated:YES];
        }
        else if(row == 4)
        {
            if([common judgeUserIsLoginOrNot:self] == NO)
                return;
            AddStoreViewController *storeByUserView = [[AddStoreViewController alloc] initWithNibName:@"AddStoreViewController" bundle:nil];
            storeByUserView.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:storeByUserView animated:YES];
        }
        //选择定位地点
        else if(row == 5)
        {
            ChoiceYourLocationViewController *choiceYourLocationViewController = [[ChoiceYourLocationViewController alloc] initWithNibName:@"ChoiceYourLocationViewController" bundle:nil];
            choiceYourLocationViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:choiceYourLocationViewController animated:YES];
        }
    }
    else if(section == 1)
    {
        //客服电话
        if(row == 0)
        {
            NSString *tel = [NSString stringWithFormat:@"tel:%@",@"073185589427"];
            UIWebView *callWebview = [[UIWebView alloc] init];
            NSURL *telURL = [NSURL URLWithString:tel];
            [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
            [self.view addSubview:callWebview];
        }
        //帮助
        else if(row == 1)
        {
            HelpViewController *helpViewController = [[HelpViewController alloc] initWithNibName:@"HelpViewController" bundle:nil];
            helpViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:helpViewController animated:YES];
        }
        //意见反馈
        else if(row == 2)
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto://support@dongway.com.cn"]];
        }
        //检查更新
        else if(row == 3)
        {
            NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
            float nowVersion = [[infoDict objectForKey:@"CFBundleVersion"] floatValue];
            
            [SVProgressHUD show];
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                
                [softwareInfosModel getAppStoreInfosWithAppStoreID:@"508704237"];

                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    NSDictionary *softwareInfos = [softwareInfosModel.softwares objectAtIndex:0];
                    [softwareInfosModel setPropertysWithDictionary:softwareInfos];
                    float preVersion = [softwareInfosModel.version floatValue];
                    
                    [SVProgressHUD dismiss];
                    if(nowVersion < preVersion)
                    {
                        //有新软件要更新
                        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"新版本出来了，是否要更新!" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定!" otherButtonTitles:nil];
                        [actionSheet showInView:self.view.window];
                    }
                    else
                    {
                        //你的是最新版了
                        [SVProgressHUD showSuccessWithStatus:@"当前已是最新版"];
                    }
                
                });
            });

        }
        
    }

}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/dong-wei-zhang-sha/id508704237?l=en&mt=8"]];
    }
}
@end
