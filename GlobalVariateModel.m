//
//  UserModel.m
//  Account
//
//  Created by wang zhe on 9/5/13.
//
//

#import "GlobalVariateModel.h"

@implementation GlobalVariateModel

-(id)init
{
    if(self = [super init])
    {
        self.globalVariateModel = [NSUserDefaults standardUserDefaults];
    
    }
    return self;
}

//自动登陆
-(void)setIsAutoLogin:(NSString *)isAutoLogin
{
    [self.globalVariateModel setValue:isAutoLogin forKey:@"isAutoLogin"];
    [self.globalVariateModel synchronize];
}

-(NSString *)isAutoLogin
{
    return [self.globalVariateModel valueForKey:@"isAutoLogin"];
}

//登陆
-(void)setIsLogin:(NSString *)isLogin
{
    [self.globalVariateModel setValue:isLogin forKey:@"isLogin"];
    [self.globalVariateModel synchronize];
}

-(NSString *)isLogin
{
    return [self.globalVariateModel valueForKey:@"isLogin"];
}

//记住密码
-(void)setPasswordIsRemembered:(NSString *)passwordIsRemembered
{
    [self.globalVariateModel setValue:passwordIsRemembered forKey:@"passwordIsRemembered"];
    [self.globalVariateModel synchronize];
}

-(NSString *)passwordIsRemembered
{
    return [self.globalVariateModel valueForKey:@"passwordIsRemembered"];
}

//判断网络可用
-(void)setInternetIsAvailable:(NSString *)internetIsAvailable
{
    [self.globalVariateModel setValue:internetIsAvailable forKey:@"internetIsAvailable"];
    [self.globalVariateModel synchronize];
}

-(NSString *)internetIsAvailable
{
    return [self.globalVariateModel valueForKey:@"internetIsAvailable"];
}

//用户信息
-(void)setUserInfos:(NSDictionary *)userInfos
{
    [self.globalVariateModel setObject:userInfos forKey:@"userInfos"];
    [self.globalVariateModel synchronize];
}

-(NSDictionary *)userInfos
{
    return [self.globalVariateModel objectForKey:@"userInfos"];
}

//经纬度
-(void)setLatitude:(NSString *)latitude
{
    [self.globalVariateModel setValue:latitude forKey:@"latitude"];
    [self.globalVariateModel synchronize];
}

-(NSString *)latitude
{
    return [self.globalVariateModel valueForKey:@"latitude"];
}

-(void)setLongitude:(NSString *)longitude
{
    [self.globalVariateModel setValue:longitude forKey:@"longitude"];
    [self.globalVariateModel synchronize];
}

-(NSString *)longitude
{
    return [self.globalVariateModel valueForKey:@"longitude"];
}

//定位是否成功
-(void)setLocationIsAvailabelOnPhone:(NSString *)locationIsAvailabelOnPhone
{
    [self.globalVariateModel setValue:locationIsAvailabelOnPhone forKey:@"locationIsAvailabelOnPhone"];
    [self.globalVariateModel synchronize];
}

-(NSString *)locationIsAvailabelOnPhone
{
    return [self.globalVariateModel valueForKey:@"locationIsAvailabelOnPhone"];
}

//是否搭建了分享的平台
-(void)setIsPlatformConstructed:(NSString *)isPlatformConstructed
{
    [self.globalVariateModel setValue:isPlatformConstructed forKey:@"isPlatformConstructed"];
    [self.globalVariateModel synchronize];
}

-(NSString *)isPlatformConstructed
{
    return [self.globalVariateModel valueForKey:@"isPlatformConstructed"];
}

//用户位置
-(void)setUserAddress:(NSString *)userAddress
{
    [self.globalVariateModel setValue:userAddress forKey:@"userAddress"];
    [self.globalVariateModel synchronize];
}

-(NSString *)userAddress
{
    return [self.globalVariateModel valueForKey:@"userAddress"];
}

//时间（防止用户每天签到两次用）
-(void)setYear:(NSString *)year
{
    [self.globalVariateModel setValue:year forKey:@"year"];
    [self.globalVariateModel synchronize];
}

-(NSString *)year
{
    return [self.globalVariateModel valueForKey:@"year"];
}

-(void)setMonth:(NSString *)month
{
    [self.globalVariateModel setValue:month forKey:@"month"];
    [self.globalVariateModel synchronize];
}

-(NSString *)month
{
    return [self.globalVariateModel valueForKey:@"month"];
}

-(void)setDay:(NSString *)day
{
    [self.globalVariateModel setValue:day forKey:@"day"];
    [self.globalVariateModel synchronize];
}

-(NSString *)day
{
    return [self.globalVariateModel valueForKey:@"day"];
}

-(void)setIsFirstTimeUseApp:(NSString *)isFirstTimeUser
{
    [self.globalVariateModel setValue:isFirstTimeUser forKey:@"isFirstTimeUser"];
    [self.globalVariateModel synchronize];
}
-(NSString *)isFirstTimeUseApp
{
    return [self.globalVariateModel valueForKey:@"isFirstTimeUser"];
}

-(void)setIsFirstTimeEnterIndexView:(NSString *)isFirstTimeEnterIndexView
{
    [self.globalVariateModel setValue:isFirstTimeEnterIndexView forKey:@"isFirstTimeEnterIndexView"];
    [self.globalVariateModel synchronize];
}
-(NSString *)isFirstTimeEnterIndexView
{
    return [self.globalVariateModel valueForKey:@"isFirstTimeEnterIndexView"];
}

-(void)setIsFirstTimeEnterNearbyView:(NSString *)isFirstTimeEnterNearbyView
{
    [self.globalVariateModel setValue:isFirstTimeEnterNearbyView forKey:@"isFirstTimeEnterNearbyView"];
    [self.globalVariateModel synchronize];
}
-(NSString *)isFirstTimeEnterNearbyView
{
    return [self.globalVariateModel valueForKey:@"isFirstTimeEnterNearbyView"];
}

-(void)setIsFirstTimeEnterStoreDetailView:(NSString *)isFirstTimeEnterStoreDetailView
{
    [self.globalVariateModel setValue:isFirstTimeEnterStoreDetailView forKey:@"isFirstTimeEnterStoreDetailView"];
    [self.globalVariateModel synchronize];
}
-(NSString *)isFirstTimeEnterStoreDetailView
{
    return [self.globalVariateModel valueForKey:@"isFirstTimeEnterStoreDetailView"];
}

-(void)setIsFirstTimeEnterCardView:(NSString *)isFirstTimeEnterCardView
{
    [self.globalVariateModel setValue:isFirstTimeEnterCardView forKey:@"isFirstTimeEnterCardView"];
    [self.globalVariateModel synchronize];
}
-(NSString *)isFirstTimeEnterCardView
{
    return [self.globalVariateModel valueForKey:@"isFirstTimeEnterCardView"];
}


@end
