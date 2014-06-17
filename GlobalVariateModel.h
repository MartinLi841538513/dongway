//
//  UserModel.h
//  Account
//
//  Created by wang zhe on 9/5/13.
//
//

#import <Foundation/Foundation.h>

@interface GlobalVariateModel : NSObject

@property (weak, nonatomic) NSUserDefaults *globalVariateModel;

@property (copy, nonatomic) NSString *isAutoLogin;
@property (copy, nonatomic) NSString *isLogin;
@property (copy, nonatomic) NSString *passwordIsRemembered;
@property (copy, nonatomic) NSString *internetIsAvailable;
@property (copy, nonatomic) NSString *latitude;
@property (copy, nonatomic) NSString *longitude;
@property (copy, nonatomic) NSString *locationIsAvailabelOnPhone;
@property (copy, nonatomic) NSString *userAddress;
@property (copy, nonatomic) NSString *isPlatformConstructed;
@property (copy, nonatomic) NSString *year;

@property (copy, nonatomic) NSString *month;

@property (copy, nonatomic) NSString *day;

@property (copy, nonatomic) NSString *isFirstTimeUseApp;
@property (copy, nonatomic) NSString *isFirstTimeEnterIndexView;
@property (copy, nonatomic) NSString *isFirstTimeEnterNearbyView;
@property (copy, nonatomic) NSString *isFirstTimeEnterStoreDetailView;
@property (copy, nonatomic) NSString *isFirstTimeEnterCardView;



@property (copy, nonatomic) NSDictionary *userInfos;

-(id)init;
@end
