//
//  UserInfosModel.h
//  Account
//
//  Created by wang zhe on 9/4/13.
//
//

#import <Foundation/Foundation.h>

@interface UserInfosModel : NSObject

@property (copy, nonatomic) NSArray *userInfos;

@property (copy, nonatomic) NSString *ICCID;
@property (copy, nonatomic) NSString *ID;
@property (copy, nonatomic) NSString *IMEI;
@property (copy, nonatomic) NSString *cardID;
@property (copy, nonatomic) NSString *createTime;
@property (copy, nonatomic) NSString *email;
@property (copy, nonatomic) NSString *imageUrl;
@property (copy, nonatomic) NSString *invitation_code;
@property (copy, nonatomic) NSString *invitation_link;
@property (copy, nonatomic) NSString *is_verified;
@property (copy, nonatomic) NSString *is_vip;
@property (copy, nonatomic) NSString *passWord;
@property (copy, nonatomic) NSString *telephone;
@property (copy, nonatomic) NSString *userName;
@property (copy, nonatomic) NSString *userPoint;
@property (copy, nonatomic) NSString *userTitle;


//登陆
-(void)setUserInfosWithUsername:(NSString *)username andUserPWord:(NSString *)userPWord;

//注册
-(void)setUserInfosWithUsername:(NSString *)username andPassword:(NSString *)password andPhoneNumber:(NSString *)phoneNumber andEmail:(NSString *)email;

-(void)setPropertysWithDictionary:(NSDictionary *)dictionary;

@end
