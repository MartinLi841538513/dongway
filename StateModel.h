//
//  StateModel.h
//  Account
//
//  Created by wang zhe on 9/4/13.
//
//

#import <Foundation/Foundation.h>

@interface StateModel : NSObject

@property (copy, nonatomic) NSString *state;

//提交订单
-(NSString *)MakeOrderStateWithStoreID:(NSString *)storeID andUsername:(NSString *)userName andOrderName:(NSString *)orderName andOrderTime:(NSString *)orderTime andOrderTel:(NSString *)orderTel andNote:(NSString *)note andPeoNum:(NSString *)peoNum andTableInfo:(NSString *)tableInfo andTableID:(NSString *)tableID andSource:(NSString *)source andIsNoon:(NSString *)isNoon andIsTel:(NSString *)isTel andCustomerID:(NSString *)customerID andStatus:(NSString *)status andOrderSex:(NSString *)orderSex andUserID:(NSString *)userID andIsSMS:(NSString *)isSMS andID:(NSString *)ID;

//签到
-(NSString *)checkinAddStateWithUsername:(NSString *)username andLatitude:(NSString *)latitude andLongitude:(NSString *)longitude;

//提交商家的错误信息
-(NSString *)storeErrorAddStateWithUsername:(NSString *)username andStoreID:(NSString *)storeID andLatitude:(NSString *)latitude andLongitude:(NSString *)longitude andContent:(NSString *)content;

//修改密码
-(NSString *)pWordChangeStateWithOldPassword:(NSString *)oldPassword andNewPassword:(NSString *)theNewPassword andUsername:(NSString *)username;

//收藏美食攻略
-(NSString *)foodRaiderCollectionAddStateWithUsername:(NSString *)username andFoodRaidersID:(NSString *)foodRaidersID;

//添加美食攻略评论
-(NSString *)foodRaiderCommentAddStateWithFoodRaiderDetailID:(NSString *)foodRaiderDetailID andUserID:(NSString *)userID andParentID:(NSString *)parentID andCommentInfo:(NSString *)commentInfo;

//删除收藏的美食攻略
-(NSString *)foodRaiderCollectionDeleteStateWithUsername:(NSString *)username andFoodRaidersID:(NSString *)foodRaidersID;

//绑定达人卡
-(NSString *)cardAddStateWithUserID:(NSString *)userID andCardID:(NSString *)cardID andCardCode:(NSString *)cardCode;

//新增商家
-(NSString *)storeAddStateWithStoreID:(NSString *)storeID andStoreName:(NSString *)storeName andCate:(NSString *)cate andAd:(NSString *)ad andTel:(NSString *)tel andRecommend:(NSString *)recommend andPrice:(NSString *)price andScore:(NSString *)score andTaste:(NSString *)taste andEnvir:(NSString *)envir andService:(NSString *)service andDesc:(NSString *)desc;

//发送验证码
-(NSString *)sendCodeStateWithPhoenNumberSource:(NSString *)source;

//验证验证码是否正确
-(NSString *)checkCodeStateWithCode:(NSString *)code andPhoneNumberSource:(NSString *)source andUsername:(NSString *)username;

@end
