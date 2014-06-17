//
//  AppDelegate.m
//  Account
//
//  Created by wang zhe on 7/16/13.
//
//

#import "AppDelegate.h"

#import "LoginViewController.h"
#import "MakeOrderViewController.h"
#import "SearchViewController.h"
#import "FoodRaiderViewController.h"
#import "RecommendStoreViewController.h"
#import "AllCouponStoreViewController.h"
#import "userViewController.h"
#import "Common.h"
#import "Reachability.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.tabBarController = [[UITabBarController alloc] init];
    
    SearchViewController *firstController = [[SearchViewController alloc] init];
    FoodRaiderViewController *secondController = [[FoodRaiderViewController alloc] init];
    RecommendStoreViewController *thirdController = [[RecommendStoreViewController alloc] init];
    AllCouponStoreViewController *fouthController = [[AllCouponStoreViewController alloc] init];
    userViewController *fifthControllerForUserview = [[userViewController alloc] init];

    
    firstNavigation = [[UINavigationController alloc] initWithRootViewController:firstController];    
    secondNavigation = [[UINavigationController alloc] initWithRootViewController:secondController];
    thirdNavigation = [[UINavigationController alloc] initWithRootViewController:thirdController];
    fouthNavigation = [[UINavigationController alloc] initWithRootViewController:fouthController];
    fifthNavigation = [[UINavigationController alloc] initWithRootViewController:fifthControllerForUserview];
    
    customItem1 = [[UITabBarItem alloc] init];
	customItem2 = [[UITabBarItem alloc] init];
    customItem3 = [[UITabBarItem alloc] init];
	customItem4 = [[UITabBarItem alloc] init];
	customItem5 = [[UITabBarItem alloc] init];

    UIImage *searchSelected = [UIImage imageNamed:@"searchSelected.png"];
    UIImage *raiderSelected = [UIImage imageNamed:@"raiderSelected.png"];
    UIImage *recommendSeclected = [UIImage imageNamed:@"recommendSeclected.png"];
    UIImage *discountSelected = [UIImage imageNamed:@"discountSelected.png"];
    UIImage *accountSelected = [UIImage imageNamed:@"accountSelected.png"];
    
    UIImage *searchUnselected = [UIImage imageNamed:@"searchUnselected.png"];
    UIImage *raiderUnselected = [UIImage imageNamed:@"raiderUnselected.png"];
    UIImage *recommendUnselected = [UIImage imageNamed:@"recommendUnselected.png"];
    UIImage *discountUnselected = [UIImage imageNamed:@"discountUnselected.png"];
    UIImage *accountUnselected = [UIImage imageNamed:@"accountUnselected.png"];
    
    [customItem1 setFinishedSelectedImage:searchSelected withFinishedUnselectedImage:searchUnselected];
    [customItem2 setFinishedSelectedImage:raiderSelected withFinishedUnselectedImage:raiderUnselected];
    [customItem3 setFinishedSelectedImage:recommendSeclected withFinishedUnselectedImage:recommendUnselected];
    [customItem4 setFinishedSelectedImage:discountSelected withFinishedUnselectedImage:discountUnselected];
    [customItem5 setFinishedSelectedImage:accountSelected withFinishedUnselectedImage:accountUnselected];
    
    customItem1.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    customItem2.imageInsets = UIEdgeInsetsMake(6, 0, -12, 0);
    customItem3.imageInsets = UIEdgeInsetsMake(6, 0, -12, 0);
    customItem4.imageInsets = UIEdgeInsetsMake(6, 0, -12, 0);
    customItem5.imageInsets = UIEdgeInsetsMake(6, 0, -12, 0);

    firstNavigation.tabBarItem = customItem1;
    secondNavigation.tabBarItem = customItem2;
    thirdNavigation.tabBarItem = customItem3;
    fouthNavigation.tabBarItem = customItem4;
    fifthNavigation.tabBarItem = customItem5;

    self.tabBarController.viewControllers = [NSArray arrayWithObjects:firstNavigation,secondNavigation,thirdNavigation,fouthNavigation,fifthNavigation,nil];
    self.tabBarController.delegate = self;
    self.tabBarController.tabBar.backgroundImage = [UIImage imageNamed:@"tabbarBackground.png"];
    userInformation = [NSUserDefaults standardUserDefaults];
    user = [userInformation objectForKey:@"userInformation"];
    NSString *isAutoLogin = [userInformation valueForKey:@"isAutoLogin"];
    //如果不是自动登陆，则跳转到登陆页面
    if(![isAutoLogin isEqualToString:@"yes"])
    {
        [userInformation setValue:@"no" forKey:@"isLogin"];
    }
    else
    {
        [userInformation setValue:@"yes" forKey:@"isLogin"];
    }
    [userInformation synchronize];
    
    [self.window addSubview:self.tabBarController.view];
    [self.window makeKeyAndVisible];

    // 监测网络情况
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name: kReachabilityChangedNotification
                                               object: nil];
    hostReach = [Reachability reachabilityWithHostname:@"http://www.dongway.com.cn"];
    [hostReach startNotifier];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    NSUInteger indexOfTab = [tabBarController.viewControllers indexOfObject:viewController];
    if(indexOfTab == 0)
    {
        customItem1.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
        customItem2.imageInsets = UIEdgeInsetsMake(6, 0, -12, 0);
        customItem3.imageInsets = UIEdgeInsetsMake(6, 0, -12, 0);
        customItem4.imageInsets = UIEdgeInsetsMake(6, 0, -12, 0);
        customItem5.imageInsets = UIEdgeInsetsMake(6, 0, -12, 0);
        [firstNavigation popToRootViewControllerAnimated:YES];
    }
    else if(indexOfTab == 1)
    {
        customItem1.imageInsets = UIEdgeInsetsMake(6, 0, -12, 0);
        customItem2.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
        customItem3.imageInsets = UIEdgeInsetsMake(6, 0, -12, 0);
        customItem4.imageInsets = UIEdgeInsetsMake(6, 0, -12, 0);
        customItem5.imageInsets = UIEdgeInsetsMake(6, 0, -12, 0);
        [secondNavigation popToRootViewControllerAnimated:YES];
    }
    else if(indexOfTab == 2)
    {
        customItem1.imageInsets = UIEdgeInsetsMake(6, 0, -12, 0);
        customItem2.imageInsets = UIEdgeInsetsMake(6, 0, -12, 0);
        customItem3.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
        customItem4.imageInsets = UIEdgeInsetsMake(6, 0, -12, 0);
        customItem5.imageInsets = UIEdgeInsetsMake(6, 0, -12, 0);
        [thirdNavigation popToRootViewControllerAnimated:YES];
    }
    else if(indexOfTab == 3)
    {
        customItem1.imageInsets = UIEdgeInsetsMake(6, 0, -12, 0);
        customItem2.imageInsets = UIEdgeInsetsMake(6, 0, -12, 0);
        customItem3.imageInsets = UIEdgeInsetsMake(6, 0, -12, 0);
        customItem4.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
        customItem5.imageInsets = UIEdgeInsetsMake(6, 0, -12, 0);
        [fouthNavigation popToRootViewControllerAnimated:YES];
    }
    //懂客
    else if(indexOfTab == 4)
    {
        customItem1.imageInsets = UIEdgeInsetsMake(6, 0, -12, 0);
        customItem2.imageInsets = UIEdgeInsetsMake(6, 0, -12, 0);
        customItem3.imageInsets = UIEdgeInsetsMake(6, 0, -12, 0);
        customItem4.imageInsets = UIEdgeInsetsMake(6, 0, -12, 0);
        customItem5.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
        
        NSString *isLogin = [userInformation valueForKey:@"isLogin"];
        //如果不是登录状态，则跳转到登陆页面
        if(![isLogin isEqualToString:@"yes"])
        {
            [userInformation setValue:@"no" forKey:@"isLogin"];
            
            LoginViewController *loginView = [[LoginViewController alloc] init];
            if([[userInformation valueForKey:@"passwordIsRemembered"] isEqualToString:@"yes"])
            {
                loginView.rememberedPasswordforpass = @"checkbuttonyes.PNG";
                loginView.userNameforpass = [user valueForKey:@"userName"];
                loginView.passWordforpass = [user valueForKey:@"passWord"];
            }
            else
            {
                loginView.rememberedPasswordforpass = @"checkbuttonno.PNG";
                loginView.userNameforpass = [user valueForKey:@"userName"];
                loginView.passWordforpass = @"";
            }
            loginView.autoLoginforpass = @"checkbuttonno.PNG";
            [fifthNavigation pushViewController:loginView animated:YES];
            [loginView setTitle:@"尚未登录"];
            return;
        }
        else
        {
            //如果是的登录状态，则跳转懂客界面
            [fifthNavigation popToRootViewControllerAnimated:YES];
        }
        [userInformation synchronize];
    }
}

-(void)setTabbarLocation:(NSInteger)indexOfTab
{
    if(indexOfTab == 1)
    {
        
    }
}

//判断网络是否可用，如果可以用，则不做什么。如果不可以用则提示。并且中断下一步操作。

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)reachabilityChanged:(NSNotification *)note {
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    NetworkStatus status = [curReach currentReachabilityStatus];
    
    if (status == NotReachable)
    {
        [userInformation setObject:@"no" forKey:@"internetIsAvailable"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"注意哦"
                                                        message:@"您的网络是不可用的，会影响到你的其他操作的"
                                                       delegate:nil
                                              cancelButtonTitle:@"YES" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        [userInformation setObject:@"yes" forKey:@"internetIsAvailable"];
    }
    [userInformation synchronize];
}

//判断网络是否可用，如果可以用，则不做什么。如果不可以用则提示。并且中断下一步操作。
-(BOOL)judgeInternetIsAvailable:(NSString *)internetStatus
{
    if([internetStatus isEqualToString:@"no"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"注意哦"
                                                        message:@"您的网络是不可用的，会影响到你的其他操作的"
                                                       delegate:nil
                                              cancelButtonTitle:@"YES" otherButtonTitles:nil];
        [alert show];
        return NO;
    }
    return YES;
}

@end
