//
//  Common.m
//  Account
//
//  Created by wang zhe on 8/4/13.
//
//

#import "Common.h"
#import "LoginViewController.h"
#import "RCBarButtonItem.h"
#import "Reachability.h"
#import "SVProgressHUD.h"
#import "GlobalVariateModel.h"
#import "UserInfosModel.h"

#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"
#import <RennSDK/RennSDK.h>
#import <TencentOpenAPI/QQApi.h>
#import "WBApi.h"
#import "SubButton.h"
#import "SearchModel.h"
#import "FoodRaidersModel.h"

@implementation Common

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

//判断是否处于登陆状态,如果登陆了，则继续，否则进入判断是否进入登陆界面
-(BOOL)judgeUserIsLoginOrNot:(UIViewController *)viewController
{
    if([self isLogin])
    {
        return YES;
    }
    else
    {
        [SVProgressHUD showErrorWithStatus:@"请先登陆"];
        [self pushToLoginViewController:viewController];
        return NO;
    }
}

//判断是否处于登陆状态
-(BOOL)isLogin
{
    NSString *isLogin = [globalVariateModel isLogin];
    if([isLogin isEqualToString:@"yes"])
    {
        return YES;
    }
    return NO;
}

//跳转到登陆页面(用在当判断出用户没有登陆的时候，还要进行一些未登录状态不允许的操作时，提示并跳转至loginview)
-(void)pushToLoginViewController:(UIViewController *)viewController
{
    LoginViewController *loginViewController = [[LoginViewController alloc] init];
    if([[globalVariateModel passwordIsRemembered] isEqualToString:@"yes"])
    {
        loginViewController.userNameforpass = userInfosModel.userName;
        loginViewController.passWordforpass = userInfosModel.passWord;
        loginViewController.rememberedPasswordforpass = @"checkbuttonyes.PNG";
        loginViewController.autoLoginforpass = @"checkbuttonno.PNG";
    }
    else
    {
        loginViewController.userNameforpass = @"";
        loginViewController.passWordforpass = @"";
        loginViewController.rememberedPasswordforpass = @"checkbuttonno.PNG";
        loginViewController.autoLoginforpass = @"checkbuttonno.PNG";
    }
    loginViewController.loginButtonTitleColor = [UIColor blueColor];
    viewController.hidesBottomBarWhenPushed = YES;
    loginViewController.hidesBottomBarWhenPushed = YES;
    [viewController.navigationController pushViewController:loginViewController animated:YES];
    viewController.hidesBottomBarWhenPushed = NO;
    loginViewController.title = @"尚未登录";
}

//功能列表 menu（因为每个地方都有，所以写在这里）
-(void)functionMenuButton:(UIViewController *)viewController
{
    //功能菜单
    UIBarButtonItem *functionMenuButton = [[RCBarButtonItem alloc] initWithTitle:@"功能" style:UIBarButtonItemStyleBordered target:self action:@selector(functionMenuAction:) withObject:viewController];
    viewController.navigationItem.leftBarButtonItem = functionMenuButton;
}



//判断网络是否可用，如果可以用，则不做什么。如果不可以用则提示。并且中断下一步操作。
-(BOOL)judgeInternetIsAvailable:(NSString *)internetStatus
{
    if([internetStatus isEqualToString:@"no"])
    {
        [SVProgressHUD showErrorWithStatus:@"当前网络不存在"];
    }
    return YES;
}

//根据分数，得到评分星星的名字
-(NSString *)starName:(NSString *)score
{
    float scoreFloat = [score floatValue];
    NSString *starName ;
    if(scoreFloat < 0.25)
        starName = @"score0.png";
    else if(scoreFloat < 0.75)
        starName = @"score0.5.png";
    else if(scoreFloat < 1.25)
        starName = @"score1.png";
    else if(scoreFloat < 1.75)
        starName = @"score1.5.png";
    else if(scoreFloat < 2.25)
        starName = @"score2.png";
    else if(scoreFloat < 2.75)
        starName = @"score2.5.png";
    else if(scoreFloat < 3.25)
        starName = @"score3.png";
    else if(scoreFloat < 3.75)
        starName = @"score3.5.png";
    else if(scoreFloat <4.25)
        starName = @"score4.png";
    else if(scoreFloat <4.75)
        starName = @"score4.5.png";
    else
        starName = @"score5.png";
    return starName;
}


//重新定位
- (void)relocation:(id)sender
{
    
    locationManager = [[CLLocationManager alloc] init];
    geocoder = [[CLGeocoder alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = 1000.0f;
    [locationManager startUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    CLLocationCoordinate2D mylocation = newLocation.coordinate;//手机GPS
    NSString *latitude = [NSString stringWithFormat:@"%3.7f",mylocation.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%3.7f",mylocation.longitude];
    [locationManager stopUpdatingLocation];
    //28.16596(李兰)
    [globalVariateModel setLatitude:latitude];
    [globalVariateModel setLongitude:longitude];
    if(!(latitude == nil))
    {
//        [SVProgressHUD showSuccessWithStatus:@"定位成功"];
        //通过哲哥给的api获取位置。经证实，这个比较精确
        [globalVariateModel setLocationIsAvailabelOnPhone:@"yes"];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            SearchModel *searchModel = [[SearchModel alloc] initGetAddressWithLatitude:latitude andLongitude:longitude];
            
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [globalVariateModel setUserAddress:searchModel.locationString];
//                    [[NSNotificationCenter defaultCenter] postNotificationName:@"addressLabelPopUp" object:nil];
                    NSLog(@"%@",searchModel.locationString);
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"IndexViewController_addressLabelPopUp" object:nil userInfo:nil];
            });
        });

        
        //通过系统api获取位置
//        [globalVariateModel setLocationIsAvailabelOnPhone:@"yes"];
//        [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
//            if (error == nil && [placemarks count] > 0) {
//                placemark = [placemarks lastObject];
//                [globalVariateModel setUserAddress:placemark.name];
//                NSLog(@"%@",placemark.name);
//                 [[NSNotificationCenter defaultCenter] postNotificationName:@"IndexViewController_addressLabelPopUp" object:nil userInfo:nil];
//                
//            } else {
//                NSLog(@"%@", error.debugDescription);
//                
//            }
//        } ];
        
    }
}
- (void)locationManager: (CLLocationManager *)manager
       didFailWithError: (NSError *)error
{
    NSString *errorString;
    [manager stopUpdatingLocation];
    switch([error code])
    {
        case kCLErrorDenied:
            //Access denied by user
            errorString = @"访问用户位置服务被拒绝";
            //Do something...
            break;
        case kCLErrorLocationUnknown:
            //Probably temporary...
            errorString = @"位置数据不可用";
            //Do something else...
            break;
        default:
            errorString = @"发生了未知错误";
            break;
    }
    errorString = [NSString stringWithFormat:@"%@,默认你在五一广场",errorString];
    [globalVariateModel setLocationIsAvailabelOnPhone:@"no"];
    [globalVariateModel setLatitude:@"28.195279"];
    [globalVariateModel setLongitude:@"112.976317"];
    [globalVariateModel setUserAddress:@"定位失败,默认你在五一广场"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"IndexViewController_addressLabelPopUp" object:nil userInfo:nil];

    [SVProgressHUD showErrorWithStatus:errorString];

}

//给文字设置下划线
-(UILabel *)setLabelUnderline:(UILabel *)label
{
    CGSize expectedLabelSize = [label.text sizeWithFont:label.font constrainedToSize:label.frame.size lineBreakMode:label.lineBreakMode];
    UIView *viewUnderline=[[UIView alloc] init];
    CGFloat xOrigin=0;
    switch (label.textAlignment) {
        case NSTextAlignmentCenter:
            xOrigin=(label.frame.size.width - expectedLabelSize.width)/2;
            break;
        case NSTextAlignmentLeft:
            xOrigin=0;
            break;
        case NSTextAlignmentRight:
            xOrigin=label.frame.size.width - expectedLabelSize.width;
            break;
        default:
            break;
    }
    viewUnderline.frame=CGRectMake(xOrigin,
                                   expectedLabelSize.height-1,
                                   expectedLabelSize.width,
                                   1);
    viewUnderline.backgroundColor=label.textColor;
    [label addSubview:viewUnderline];
    return label;
}




- (void)initializePlat
{
    
    [ShareSDK registerApp:@"c2a154e8a3c"];     //参数为ShareSDK官网中添加应用后得到的AppKey
    
    /**
     连接新浪微博开放平台应用以使用相关功能，此应用需要引用SinaWeiboConnection.framework
     http://open.weibo.com上注册新浪微博开放平台应用，并将相关信息填写到以下字段
     **/
    [ShareSDK connectSinaWeiboWithAppKey:@"982068400"
                               appSecret:@"b8d9075eb95aec1e243127ab9e031351"
                             redirectUri:@"http://itunes.apple.com/cn/app/dong-wei-zhang-sha/id508704237?mt=8"];
    
    /**
     连接腾讯微博开放平台应用以使用相关功能，此应用需要引用TencentWeiboConnection.framework
     http://dev.t.qq.com上注册腾讯微博开放平台应用，并将相关信息填写到以下字段
     
     如果需要实现SSO，需要导入libWeiboSDK.a，并引入WBApi.h，将WBApi类型传入接口
     **/
//    [ShareSDK connectTencentWeiboWithAppKey:@"801454079"
//                                  appSecret:@"aab9b7216ec0ea411ab9f02cc6ec8a83"
//                                redirectUri:@"http://www.sharesdk.cn"
//                                   wbApiCls:[WBApi class]];
//    [ShareSDK connectTencentWeiboWithAppKey:@"801441694"
//                                  appSecret:@"7e7eea5baca92108deb266e4564b625d"
//                                redirectUri:@"dev.t.qq.com"
//                                   wbApiCls:[WBApi class]];
    [ShareSDK connectTencentWeiboWithAppKey:@"801441694"
                                    appSecret:@"7e7eea5baca92108deb266e4564b625d"
                                    redirectUri:@"http://itunes.apple.com/cn/app/dong-wei-zhang-sha/id508704237?mt=8"];
//    //导入腾讯微博需要的外部库类型，如果不需要腾讯微博SSO可以不调用此方法
    [ShareSDK importTencentWeiboClass:[WBApi class]];

    
    /**
     连接QQ空间应用以使用相关功能，此应用需要引用QZoneConnection.framework
     http://connect.qq.com/intro/login/上申请加入QQ登录，并将相关信息填写到以下字段
     
     如果需要实现SSO，需要导入TencentOpenAPI.framework,并引入QQApiInterface.h和TencentOAuth.h，将QQApiInterface和TencentOAuth的类型传入接口
     **/
//    [ShareSDK connectQZoneWithAppKey:@"100551988"
//                           appSecret:@"be0c839de4d65263784e257d0b80e105"
//                   qqApiInterfaceCls:[QQApiInterface class]
//                     tencentOAuthCls:[TencentOAuth class]];
    //这是测试用appkey，因为我的appkey的分享功能暂时不能用。
    //添加QQ空间应用
    [ShareSDK connectQZoneWithAppKey:@"100371282"
                           appSecret:@"aed9b0303e3ed1e27bae87c33761161d"
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];

    //    [ShareSDK connectQZoneWithAppKey:@"100551988"
//                           appSecret:@"be0c839de4d65263784e257d0b80e105"];
//    //导入QQ互联和QQ好友分享需要的外部库类型，如果不需要QQ空间SSO和QQ好友分享可以不调用此方法
//    [ShareSDK importQQClass:[QQApiInterface class]
//            tencentOAuthCls:[TencentOAuth class]];

    /**
     连接人人网应用以使用相关功能，此应用需要引用RenRenConnection.framework
     http://dev.renren.com上注册人人网开放平台应用，并将相关信息填写到以下字段
     **/
//    [ShareSDK connectRenRenWithAppKey:@"fc5b8aed373c4c27a05b712acba0f8c3"
//                            appSecret:@"f29df781abdd4f49beca5a2194676ca4"];
//    [ShareSDK connectRenRenWithAppId:@"243866"
//                              appKey:@"3b5c726d99c6448e997ae59d1f8163ba"
//                           appSecret:@"0b321e4e17b6401dbafaf486376cd7b3"
//                   renrenClientClass:[RennClient class]];
    [ShareSDK connectRenRenWithAppId:@"244070"
                              appKey:@"447d9404fcb94ae9b2493771a3135cd7"
                           appSecret:@"c095d1a2b95848ae97a4d7b716a49eb0"
                   renrenClientClass:[RennClient class]];
    /**
     连接微信应用以使用相关功能，此应用需要引用WeChatConnection.framework和微信官方SDK
     http://open.weixin.qq.com上注册应用，并将相关信息填写以下字段
     **/
    [ShareSDK connectWeChatWithAppId:@"wxa07dac2d9a645455" wechatCls:[WXApi class]];
    
    //添加QQ应用
//    [ShareSDK connectQQWithAppId:@"QQ0F0A941E" qqApiCls:[QQApi class]];
    [ShareSDK connectQQWithQZoneAppKey:@"100551988"
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];
    
    [globalVariateModel setIsPlatformConstructed:@"yes"];
}

-(void)foodRaiderShareWithFoodRaiderModel:(FoodRaidersModel *)foodRaiderModel inViewController:(UIViewController *)viewController
{
    NSString *foodRaiderURL = [NSString stringWithFormat:@"http://www.dongway.com.cn/foodRaiders/detail.htm?foodRaidersID=%@&detailID=%@",foodRaiderModel.ID,foodRaiderModel.foodDetailID];
    //    NSString *imageUrlThumbs =[self.foodRaidersModel.imageUrl stringByReplacingOccurrencesOfString:@".jpg" withString:@".thumbs.jpg"];
    NSURL *url = [NSURL URLWithString:foodRaiderModel.imageUrl];
    NSString *description = [self description_83:foodRaiderModel.foodAbstract];
    [SVProgressHUD show];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            //构造分享内容
            id<ISSContent> publishContent = [ShareSDK content:[NSString stringWithFormat:@"不错哦，小伙伴们，来看看吧!!!%@",foodRaiderURL]
                                               defaultContent:@"不错哦，小伙伴们，来看看吧"
                                                        image:[ShareSDK pngImageWithImage:image]
                                                        title:foodRaiderModel.title
                                                          url:foodRaiderURL
                                                  description:description
                                                    mediaType:SSPublishContentMediaTypeNews];
            
            [self shareContent:publishContent andViewController:viewController];
            
        });
    });

}

//分享的description最多放81个字符，否则出错.如果为空也会出错
-(NSString *)description_83:(NSString *)description
{
    if([description isEqualToString:@""] || description == nil)
    {
        description = @"暂时没有描述";
    }
    else if(description.length > 81)
    {
        description = [description substringWithRange:NSMakeRange(0, 83)];
    }
    return description;
}
//分享
-(void)shareContent:(id<ISSContent>)content andViewController:(UIViewController *)viewController
{
    if(![[globalVariateModel isPlatformConstructed] isEqualToString:@"yes"])
    {
        [self initializePlat];
    }

    // 容器
    id<ISSContainer> container = [ShareSDK container];
    
    [container setIPhoneContainerWithViewController:viewController];
    [container setIPadContainerWithView:viewController.view arrowDirect:UIPopoverArrowDirectionLeft];
    
    
    // 分享列表
    NSArray *shareList = [ShareSDK getShareListWithType:ShareTypeQQSpace,ShareTypeQQ,ShareTypeWeixiTimeline,ShareTypeWeixiSession,ShareTypeSinaWeibo,ShareTypeTencentWeibo,ShareTypeRenren,ShareTypeSMS, nil];
    
//    NSArray *shareList = [ShareSDK getShareListWithType:ShareTypeQQ,ShareTypeWeixiTimeline,ShareTypeWeixiSession,ShareTypeSMS, nil];
    
    // 分享选项
    id<ISSShareOptions>shareOptions = [ShareSDK defaultShareOptionsWithTitle:@"分享" oneKeyShareList:shareList cameraButtonHidden:NO mentionButtonHidden:NO topicButtonHidden:NO qqButtonHidden:YES wxSessionButtonHidden:YES wxTimelineButtonHidden:YES showKeyboardOnAppear:NO shareViewDelegate:nil friendsViewDelegate:nil picViewerViewDelegate:nil];
        
    [ShareSDK showShareActionSheet:container
                         shareList:shareList
                           content:content
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions: shareOptions
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                if (state == SSPublishContentStateSuccess){
                                    //[SunUtility printMessage:[NSString stringWithFormat:@"%@分享成功",clientName]];
                                    //分享成功后提醒
                                    [SVProgressHUD showSuccessWithStatus:@"分享成功"];
                                    //分享成功后选择收听"灵机妙算"
                                    NSString *listenName;
                                    if (type == ShareTypeSinaWeibo) {
                                        listenName = @"灵机妙算";
                                    } else {
                                        listenName = @"mobileimmortal";
                                    }
                                    [ShareSDK followUserWithType:type field:listenName fieldType:SSUserFieldTypeName authOptions:nil viewDelegate:nil result:nil];
                                }
                                else if (state == SSPublishContentStateFail) {
                                    //[SunUtility printMessage:[NSString stringWithFormat:@"%@分享失败\n%@",clientName,[error errorDescription]]];
                                    //分享失败
                                    [SVProgressHUD showErrorWithStatus:@"分享失败，请您检查网络设置"];
                                    
                                    NSLog(@"分享失败,错误码:%d,错误描述:%@", [error errorCode], [error errorDescription]);
                                }
                            }];
    
}

//返回button,两种返回方法：1.返回button用图片 2.右滑可以返回
-(void)returnButton:(UIViewController *)viewController
{
    SubButton *returnButton = [[SubButton alloc] init];
    returnButton.frame=CGRectMake(0,0,40,28);
    [returnButton setBackgroundImage:[UIImage imageNamed:@"return.png"] forState:UIControlStateNormal];
    [returnButton addTarget:self action:@selector(popViewController:) withObject:viewController forControlEvents:UIControlEventTouchDown];
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:returnButton];

}

-(void)popViewController:(id)sender
{
    UIViewController *viewController = [(id)sender anObject];
    [viewController.navigationController popViewControllerAnimated:YES];
}


//设置地址的显示方式
-(NSString *)userAddress
{
    NSString *address = globalVariateModel.userAddress;
    //定位成功
    if(![[globalVariateModel locationIsAvailabelOnPhone] isEqualToString:@"no"])
    {
        if([address length]>8)
            address = [NSString stringWithFormat:@"你在:%@",[address substringFromIndex:3]];
        else if([address length]>0)
            address = [NSString stringWithFormat:@"你在:%@",address];
        else
            address = @"定位失败，默认你在五一广场";
    }
    else
    {
        address = address;
    }
    
    return address;
}


@end
