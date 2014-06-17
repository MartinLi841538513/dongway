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
#import "FoodRaiderViewController.h"
#import "DiscountStoresListViewController.h"
#import "UserViewController.h"
#import "Common.h"
#import "Reachability.h"
#import "SVProgressHUD.h"
#import "MobClick.h"
#import "GlobalVariateModel.h"
#import "UserInfosModel.h"
#import "IndexViewController.h"
#import "NearbyViewController.h"
#import "CategoryViewController.h"
#import "MoreViewController.h"
#import "MLNavigationController.h"
#import "APService.h"
#import "FeastActivityViewController.h"
#import "FoodRaiderViewController.h"

@implementation AppDelegate

- (void)umengTrack {
    //    [MobClick setCrashReportEnabled:NO]; // 如果不需要捕捉异常，注释掉此行
//    [MobClick setLogEnabled:YES];  // 打开友盟sdk调试，注意Release发布时需要注释掉此行,减少io消耗
//    [MobClick setAppVersion:XcodeAppVersion]; //参数为NSString * 类型,自定义app版本信息，如果不设置，默认从CFBundleVersion里取
    //建议使用BATCH策略，更省流量528c1add56240b19f502d786
    [MobClick startWithAppkey:@"52118c3156240b648d05cc38" reportPolicy:(ReportPolicy) BATCH channelId:nil];
//    [MobClick startWithAppkey:@"528c1add56240b19f502d786" reportPolicy:(ReportPolicy) BATCH channelId:nil];

    //   reportPolicy为枚举类型,可以为 REALTIME, BATCH,SENDDAILY,SENDWIFIONLY几种
    //   channelId 为NSString * 类型，channelId 为nil或@""时,默认会被被当作@"App Store"渠道
    
    [MobClick checkUpdate];   //自动更新检查, 如果需要自定义更新请使用下面的方法,需要接收一个(NSDictionary *)appInfo的参数
    //    [MobClick checkUpdateWithDelegate:self selector:@selector(updateMethod:)];
    
    [MobClick updateOnlineConfig];  //在线参数配置
    
    //    1.6.8之前的初始化方法
    //    [MobClick setDelegate:self reportPolicy:REALTIME];  //建议使用新方法
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onlineConfigCallBack:) name:UMOnlineConfigDidFinishedNotification object:nil];
    
}


- (void)onlineConfigCallBack:(NSNotification *)note {
    
    NSLog(@"online config has fininshed and note = %@", note.userInfo);
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    //  友盟的方法本身是异步执行，所以不需要再异步调用 力力渔港
    [self umengTrack];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];

    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.tabBarController = [[UITabBarController alloc] init];
    
    IndexViewController *firstController = [[IndexViewController alloc] initWithNibName:@"IndexViewController" bundle:nil];
    NearbyViewController *secondController = [[NearbyViewController alloc] initWithNibName:@"NearbyViewController" bundle:nil];
    CategoryViewController *thirdController = [[CategoryViewController alloc] initWithNibName:@"CategoryViewController" bundle:nil];
    UserViewController *fouthController = [[UserViewController alloc] init];
    MoreViewController *fifthControllerForUserview = [[MoreViewController alloc] initWithNibName:@"MoreViewController" bundle:nil];
    
    secondController.title = @"附近";
    
    firstNavigation = [[MLNavigationController alloc] initWithRootViewController:firstController];
    secondNavigation = [[MLNavigationController alloc] initWithRootViewController:secondController];
    thirdNavigation = [[MLNavigationController alloc] initWithRootViewController:thirdController];
    fouthNavigation = [[MLNavigationController alloc] initWithRootViewController:fouthController];
    fifthNavigation = [[MLNavigationController alloc] initWithRootViewController:fifthControllerForUserview];
    

    customItem1 = [[UITabBarItem alloc] initWithTitle:@"首页" image:nil tag:0];
	customItem2 = [[UITabBarItem alloc] initWithTitle:@"附近" image:nil tag:1];
    customItem3 = [[UITabBarItem alloc] initWithTitle:@"搜索" image:nil tag:2];
	customItem4 = [[UITabBarItem alloc] initWithTitle:@"我的" image:nil tag:3];
	customItem5 = [[UITabBarItem alloc] initWithTitle:@"更多" image:nil tag:4];
    
    UIImage *imageSelected1 = [UIImage imageNamed:@"ic_tab_artists_selected.png"];
    UIImage *imageSelected2 = [UIImage imageNamed:@"ic_tab_albums_selected.png"];
    UIImage *imageSelected3 = [UIImage imageNamed:@"tab_category_light.png"];
    UIImage *imageSelected4 = [UIImage imageNamed:@"ic_tab_songs_selected.png"];
    UIImage *imageSelected5 = [UIImage imageNamed:@"ic_tab_playlists_selected.png"];
    
    UIImage *imageUnselected1 = [UIImage imageNamed:@"ic_tab_artists_unselected.png"];
    UIImage *imageUnselected2 = [UIImage imageNamed:@"ic_tab_albums_unselected.png"];
    UIImage *imageUnselected3 = [UIImage imageNamed:@"tab_category_dark.png"];
    UIImage *imageUnselected4 = [UIImage imageNamed:@"ic_tab_songs_unselected.png"];
    UIImage *imageUnselected5 = [UIImage imageNamed:@"ic_tab_playlists_unselected.png"];
    
    [customItem1 setFinishedSelectedImage:imageSelected1 withFinishedUnselectedImage:imageUnselected1];
    [customItem2 setFinishedSelectedImage:imageSelected2 withFinishedUnselectedImage:imageUnselected2];
    [customItem3 setFinishedSelectedImage:imageSelected3 withFinishedUnselectedImage:imageUnselected3];
    [customItem4 setFinishedSelectedImage:imageSelected4 withFinishedUnselectedImage:imageUnselected4];
    [customItem5 setFinishedSelectedImage:imageSelected5 withFinishedUnselectedImage:imageUnselected5];
    
    firstNavigation.tabBarItem = customItem1;
    secondNavigation.tabBarItem = customItem2;
    thirdNavigation.tabBarItem = customItem3;
    fouthNavigation.tabBarItem = customItem4;
    fifthNavigation.tabBarItem = customItem5;
    
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:firstNavigation,secondNavigation,thirdNavigation,fouthNavigation,fifthNavigation,nil];
    self.tabBarController.delegate = self;
    
    globalVariateModel = [[GlobalVariateModel alloc] init];
    [globalVariateModel setIsPlatformConstructed:@"no"];
    userInfosModel = [[UserInfosModel alloc]  init];
    
    userInfos = [globalVariateModel userInfos];
    [userInfosModel setPropertysWithDictionary:userInfos];
    
    //如果不是自动登陆，则设置登陆状态为no
    if(![[globalVariateModel isAutoLogin] isEqualToString:@"yes"])
    {
        [globalVariateModel setIsLogin:@"no"];
    }
    else
    {
        [globalVariateModel setIsLogin:@"yes"];
    }
    
    self.window.rootViewController = self.tabBarController;
    [self.window addSubview:self.tabBarController.view];
    [self.window makeKeyAndVisible];
    
    // 监测网络情况
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name: kReachabilityChangedNotification
                                               object: nil];
    
    Reachability * reach = [Reachability reachabilityWithHostname:@"www.dongway.com.cn"];
    [reach startNotifier];
    
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    
    [defaultCenter addObserver:self selector:@selector(networkDidSetup:) name:kAPNetworkDidSetupNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidClose:) name:kAPNetworkDidCloseNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidRegister:) name:kAPNetworkDidRegisterNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidLogin:) name:kAPNetworkDidLoginNotification object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kAPNetworkDidReceiveMessageNotification object:nil];
    
    //极光推送
    // Required
    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                   UIRemoteNotificationTypeSound |
                                                   UIRemoteNotificationTypeAlert)];
    //别名和标签 我觉得在测试推送功能的时候有用，这样可以指定手机推送，就不会乱发信息给用户了。注意，在发布之前，要注释下面这段代码
//    [APService setTags:[NSSet setWithObjects:@"tag4",@"tag5",@"tag6",nil] alias:@"别名" callbackSelector:@selector(tagsAliasCallback:tags:alias:) target:self];
//    [APService sett
    // Required
    [APService setupWithOption:launchOptions];
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:1];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];

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
    [globalVariateModel setLocationIsAvailabelOnPhone:@"no"];
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

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    // Required
    [APService registerDeviceToken:deviceToken];
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *) error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
       // Required
    [APService handleRemoteNotification:userInfo];
}
//avoid compile error for sdk under 7.0
#ifdef __IPHONE_7_0
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    [APService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNoData);
}
#endif

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    NSUInteger indexOfTab = [tabBarController.viewControllers indexOfObject:viewController];
    if(indexOfTab == 0)
    {
        [firstNavigation popToRootViewControllerAnimated:YES];
    }
    else if(indexOfTab == 1)
    {
        [secondNavigation popToRootViewControllerAnimated:YES];
    }
    else if(indexOfTab == 2)
    {
        [thirdNavigation popToRootViewControllerAnimated:YES];
    }
    //懂客
    else if(indexOfTab == 3)
    {
        
        NSString *isLogin = [globalVariateModel isLogin];
        //如果不是登录状态，则跳转到登陆页面
        if(![isLogin isEqualToString:@"yes"])
        {
            [globalVariateModel setIsLogin:@"no"];
            LoginViewController *loginView = [[LoginViewController alloc] init];
            if([[globalVariateModel passwordIsRemembered] isEqualToString:@"yes"])
            {
                loginView.rememberedPasswordforpass = @"checkbuttonyes.PNG";
                loginView.userNameforpass = userInfosModel.userName;
                loginView.passWordforpass = userInfosModel.passWord;
            }
            else
            {
                loginView.rememberedPasswordforpass = @"checkbuttonno.PNG";
                loginView.userNameforpass = userInfosModel.userName;
                loginView.passWordforpass = @"";
            }
            loginView.autoLoginforpass = @"checkbuttonyes.PNG";
            loginView.hidesBottomBarWhenPushed = YES;//登录页面不要出现tabbar，否则持续点击tabbar会出现问题
            [fouthNavigation pushViewController:loginView animated:YES];
            [loginView setTitle:@"尚未登录"];
            return;
        }
        else
        {
            userInfos = [globalVariateModel userInfos];
            [userInfosModel setPropertysWithDictionary:userInfos];
//            [SVProgressHUD show];
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                
                //向服务器提交的数据，进行验证用户名和密码
                [userInfosModel setUserInfosWithUsername:userInfosModel.userName andUserPWord:userInfosModel.passWord];
                dispatch_async(dispatch_get_main_queue(), ^{
//                    [SVProgressHUD dismiss];
                    NSArray *loginUserArray = userInfosModel.userInfos;
                    if([loginUserArray count] == 1)
                    {
                        //保存用户信息，设置用户信息为全局变量
                        NSDictionary *userInfo = [loginUserArray objectAtIndex:0];
                        [globalVariateModel setUserInfos:userInfo];
                        [globalVariateModel setIsLogin:@"yes"];
//                        [SVProgressHUD showSuccessWithStatus:@"登陆成功"];
                        //如果是的登录状态，则跳转懂客界面
//                        [fouthNavigation popToRootViewControllerAnimated:YES];
                    }
                    else
                    {
                        [SVProgressHUD showErrorWithStatus:@"密码可能在别处更改过，请重新输入密码"];
                        [globalVariateModel setIsLogin:@"no"];
                        LoginViewController *loginView = [[LoginViewController alloc] init];
                        
                        loginView.userNameforpass = userInfosModel.userName;
                        loginView.passWordforpass = @"";
                        
                        loginView.hidesBottomBarWhenPushed = YES;//登录页面不要出现tabbar，否则持续点击tabbar会出现问题
                        [fouthNavigation pushViewController:loginView animated:YES];
                        [loginView setTitle:@"尚未登录"];

                    }
                });
            });
        }
    }
    else if(indexOfTab == 4)
    {
        [fifthNavigation popToRootViewControllerAnimated:YES];
    }
}

-(void)setTabbarLocation:(NSInteger)indexOfTab
{
    if(indexOfTab == 1)
    {
        
    }
}

-(void)reachabilityChanged:(NSNotification*)note
{
    Reachability * reach = [note object];
    
    if([reach isReachable])
    {
        [globalVariateModel setInternetIsAvailable:@"yes"];
        common = [[Common alloc] init];
//        [common relocation:self];
    }
    else
    {
        [globalVariateModel setInternetIsAvailable:@"no"];
        [SVProgressHUD showErrorWithStatus:@"当前网络不可用"];
    }
}

- (BOOL)application:(UIApplication *)application  handleOpenURL:(NSURL *)url
{
    return [ShareSDK handleOpenURL:url
                        wxDelegate:self];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [ShareSDK handleOpenURL:url
                 sourceApplication:sourceApplication
                        annotation:annotation
                        wxDelegate:self];
}

- (void)networkDidSetup:(NSNotification *)notification {
    NSLog(@"已连接");
}

- (void)networkDidClose:(NSNotification *)notification {
    NSLog(@"未连接。。。");
}

- (void)networkDidRegister:(NSNotification *)notification {
    NSLog(@"已注册");
}

- (void)networkDidLogin:(NSNotification *)notification {
    NSLog(@"已登录");
    
}
- (void)networkDidReceiveMessage:(NSNotification *)notification {
    NSDictionary * userInfo = [notification userInfo];
    NSDictionary *dict = [userInfo valueForKey:@"extras"];
    NSString *value1 = [dict objectForKey:@"value1"];
    if([value1 isEqualToString:@"懂味活动"])
    {
        [self.tabBarController setSelectedIndex:0];
        FeastActivityViewController *viewcontroller = [[FeastActivityViewController alloc] initWithNibName:@"FeastActivityViewController" bundle:nil];
        [firstNavigation pushViewController:viewcontroller animated:YES];
    }
    else if([value1 isEqualToString:@"软件更新"])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/dong-wei-zhang-sha/id508704237?l=en&mt=8"]];
    }
    else if([value1 isEqualToString:@"美食攻略"])
    {
         [self.tabBarController setSelectedIndex:0];
        FoodRaiderViewController *viewcontroller = [[FoodRaiderViewController alloc] initWithNibName:@"FoodRaiderViewController" bundle:nil];
        [firstNavigation pushViewController:viewcontroller animated:YES];
    }
}

- (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias {
    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}
@end
