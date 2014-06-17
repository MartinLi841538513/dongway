//
//  StateModel.m
//  Account
//
//  Created by wang zhe on 9/4/13.
//
//

#import "StateModel.h"
#import "InteractWithServerOnJSON.h"
#import "API.h"

@implementation StateModel


-(NSString *)MakeOrderStateWithStoreID:(NSString *)storeID andUsername:(NSString *)userName andOrderName:(NSString *)orderName andOrderTime:(NSString *)orderTime andOrderTel:(NSString *)orderTel andNote:(NSString *)note andPeoNum:(NSString *)peoNum andTableInfo:(NSString *)tableInfo andTableID:(NSString *)tableID andSource:(NSString *)source andIsNoon:(NSString *)isNoon andIsTel:(NSString *)isTel andCustomerID:(NSString *)customerID andStatus:(NSString *)status andOrderSex:(NSString *)orderSex andUserID:(NSString *)userID andIsSMS:(NSString *)isSMS andID:(NSString *)ID
{
    NSString *url = [NSString stringWithFormat:SEND_ORDER_URL,storeID,userName,orderName,orderTime,orderTel,note,peoNum,tableInfo,tableID,source,isNoon,isTel,customerID,status,orderSex,userID,isSMS,ID];
    NSDictionary *dictionary = [InteractWithServerOnJSON interactWithServerOnJSON:url];
    self.state = [dictionary objectForKey:@"state"];
    
    
    return self.state;
}

//签到
-(NSString *)checkinAddStateWithUsername:(NSString *)username andLatitude:(NSString *)latitude andLongitude:(NSString *)longitude
{
    NSString *url = [NSString stringWithFormat:User_Checkin_URL,username,latitude,longitude];
    NSDictionary *dictionary = [InteractWithServerOnJSON interactWithServerOnJSON:url];
    self.state = [dictionary objectForKey:@"state"];
    
    return self.state;
}

-(NSString *)storeErrorAddStateWithUsername:(NSString *)username andStoreID:(NSString *)storeID andLatitude:(NSString *)latitude andLongitude:(NSString *)longitude andContent:(NSString *)content
{
    NSString *url = [NSString stringWithFormat:Get_SendQuestion_URL,username,storeID,latitude,longitude,content];
    NSDictionary *dictionary = [InteractWithServerOnJSON interactWithServerOnJSON:url];
    self.state = [dictionary objectForKey:@"state"];
    
    return self.state;
}

//修改密码
-(NSString *)pWordChangeStateWithOldPassword:(NSString *)oldPassword andNewPassword:(NSString *)theNewPassword andUsername:(NSString *)username
{
    
    NSString *url = [NSString stringWithFormat:CHANGE_USER_PASSWORD,oldPassword ,theNewPassword ,username];
    NSDictionary *dictionary = [InteractWithServerOnJSON interactWithServerOnJSON:url];
    self.state = [dictionary objectForKey:@"state"];
    
    return self.state;
}

//收藏美食攻略
-(NSString *)foodRaiderCollectionAddStateWithUsername:(NSString *)username andFoodRaidersID:(NSString *)foodRaidersID
{
    NSString *url = [NSString stringWithFormat:ADD_FRCOLLECTION_URL,username,foodRaidersID];
    NSDictionary *dictionary = [InteractWithServerOnJSON interactWithServerOnJSON:url];
    self.state = [dictionary objectForKey:@"state"];
    
    return self.state;
}

//添加美食攻略评论
-(NSString *)foodRaiderCommentAddStateWithFoodRaiderDetailID:(NSString *)foodRaiderDetailID andUserID:(NSString *)userID andParentID:(NSString *)parentID andCommentInfo:(NSString *)commentInfo
{
    NSString *url = [NSString stringWithFormat:ADD_FRCOMMENT_URL,foodRaiderDetailID,userID,parentID,commentInfo];
    NSDictionary *dictionary = [InteractWithServerOnJSON interactWithServerOnJSON:url];
    self.state = [dictionary objectForKey:@"state"];
    
    return self.state;
}

//删除收藏的美食攻略
-(NSString *)foodRaiderCollectionDeleteStateWithUsername:(NSString *)username andFoodRaidersID:(NSString *)foodRaidersID
{
    
    NSString *url = [NSString stringWithFormat:DEL_FRCOLLECTION_URL,username,foodRaidersID];
    NSDictionary *dictionary = [InteractWithServerOnJSON interactWithServerOnJSON:url];
    self.state = [dictionary objectForKey:@"state"];
    
    return self.state;
}

//绑定达人卡
-(NSString *)cardAddStateWithUserID:(NSString *)userID andCardID:(NSString *)cardID andCardCode:(NSString *)cardCode
{
    
    NSString *url = [NSString stringWithFormat:ADD_USERCard_URL,userID,cardID,cardCode];
    NSDictionary *dictionary = [InteractWithServerOnJSON interactWithServerOnJSON:url];
    self.state = [dictionary objectForKey:@"state"];
    
    return self.state;
}

//新增商家
-(NSString *)storeAddStateWithStoreID:(NSString *)storeID andStoreName:(NSString *)storeName andCate:(NSString *)cate andAd:(NSString *)ad andTel:(NSString *)tel andRecommend:(NSString *)recommend andPrice:(NSString *)price andScore:(NSString *)score andTaste:(NSString *)taste andEnvir:(NSString *)envir andService:(NSString *)service andDesc:(NSString *)desc
{
    NSString *url = [NSString stringWithFormat:Get_AddStore_URL,storeID,storeName,cate,ad,tel,recommend,price,score,taste,envir,service,desc];
    NSDictionary *dictionary = [InteractWithServerOnJSON interactWithServerOnJSON:url];
    self.state = [dictionary objectForKey:@"state"];
    
    return self.state;
}

//发送验证码
-(NSString *)sendCodeStateWithPhoenNumberSource:(NSString *)source
{
    NSString *url = [NSString stringWithFormat:GET_VERDIFY_CODE,source];
    NSDictionary *dictionary = [InteractWithServerOnJSON interactWithServerOnJSON:url];
    self.state = [dictionary objectForKey:@"state"];
    
    return self.state;
}

//验证验证码是否正确
-(NSString *)checkCodeStateWithCode:(NSString *)code andPhoneNumberSource:(NSString *)source andUsername:(NSString *)username
{
    NSString *url = [NSString stringWithFormat:CHECK_VERDIFY_CODE,source];
    NSDictionary *dictionary = [InteractWithServerOnJSON interactWithServerOnJSON:url];
    self.state = [dictionary objectForKey:@"state"];
    
    return self.state;
}

@end
