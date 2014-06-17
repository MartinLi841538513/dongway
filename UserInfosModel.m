//
//  UserInfosModel.m
//  Account
//
//  Created by wang zhe on 9/4/13.
//
//

#import "UserInfosModel.h"
#import "InteractWithServerOnJSON.h"
#import "API.h"

@implementation UserInfosModel


-(void)setUserInfosWithUsername:(NSString *)username andUserPWord:(NSString *)userPWord
{
    NSString *url = [NSString stringWithFormat:Get_UserInfo_URL, username ,userPWord];
    NSDictionary *dictionary = [InteractWithServerOnJSON interactWithServerOnJSON:url];
    self.userInfos = [dictionary objectForKey:@"userInfos"];
}

//注册
-(void)setUserInfosWithUsername:(NSString *)username andPassword:(NSString *)password andPhoneNumber:(NSString *)phoneNumber andEmail:(NSString *)email
{
    NSString *url = [NSString stringWithFormat:ADD_UserInfo_URL, username ,password,phoneNumber,email];
    NSDictionary *dictionary = [InteractWithServerOnJSON interactWithServerOnJSON:url];
    self.userInfos = [dictionary objectForKey:@"userInfos"];
}

-(void)setPropertysWithDictionary:(NSDictionary *)dictionary
{
    
    self.ICCID = [dictionary valueForKey:@"ICCID"];
    self.ID = [dictionary valueForKey:@"ID"];
    self.IMEI = [dictionary valueForKey:@"IMEI"];
    self.cardID = [dictionary valueForKey:@"cardID"];
    self.createTime = [dictionary valueForKey:@"createTime"];
    self.email = [dictionary valueForKey:@"email"];
    self.imageUrl = [dictionary valueForKey:@"imageUrl"];
    self.invitation_code = [dictionary valueForKey:@"invitation_code"];
    self.invitation_link = [dictionary valueForKey:@"invitation_link"];
    self.is_verified = [dictionary valueForKey:@"is_verified"];
    
    self.is_vip = [dictionary valueForKey:@"is_vip"];
    self.passWord = [dictionary valueForKey:@"passWord"];
    self.telephone = [dictionary valueForKey:@"telephone"];
    self.userName = [dictionary valueForKey:@"userName"];
    self.userPoint = [dictionary valueForKey:@"userPoint"];
    self.userTitle = [dictionary valueForKey:@"userTitle"];

}


@end
