//
//  Common.h
//  Account
//
//  Created by wang zhe on 8/4/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <ShareSDK/ShareSDK.h>

@class Reachability;
@class GlobalVariateModel;
@class UserInfosModel;
@class FoodRaidersModel;

@interface Common : NSObject<UIActionSheetDelegate,UIApplicationDelegate,CLLocationManagerDelegate>
{
    Reachability  *hostReach;
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    GlobalVariateModel *globalVariateModel;
    UserInfosModel *userInfosModel;

}


-(BOOL)judgeUserIsLoginOrNot:(UIViewController *)viewController;
-(BOOL)isLogin;
-(void)pushToLoginViewController:(UIViewController *)viewController;
-(void)functionMenuButton:(UIViewController *)viewController;
-(BOOL)judgeInternetIsAvailable:(NSString *)internetStatus;
-(NSString *)starName:(NSString *)score;
- (void)relocation:(id)sender;
-(UILabel *)setLabelUnderline:(UILabel *)label;
-(id)init;
- (void)initializePlat;
-(void)shareContent:(id<ISSContent>)content andViewController:(UIViewController *)viewController;
-(void)returnButton:(UIViewController *)viewController;

-(void)foodRaiderShareWithFoodRaiderModel:(FoodRaidersModel *)foodRaiderModel inViewController:(UIViewController *)viewController;
-(NSString *)userAddress;
-(NSString *)description_83:(NSString *)description;
@end
