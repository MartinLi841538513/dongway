//
//  OrderInfosModel.h
//  Account
//
//  Created by wang zhe on 9/4/13.
//
//

#import <Foundation/Foundation.h>

@interface OrderInfosModel : NSObject

@property (copy, nonatomic) NSArray *orderInfos;

@property (copy, nonatomic) NSString *address;
@property (copy, nonatomic) NSString *createTime;
@property (copy, nonatomic) NSString *customerID;
@property (copy, nonatomic) NSString *isNoon;
@property (copy, nonatomic) NSString *isSync;
@property (copy, nonatomic) NSString *isTel;
@property (copy, nonatomic) NSString *lastUpdateTime;
@property (copy, nonatomic) NSString *md5ID;
@property (copy, nonatomic) NSString *note;
@property (copy, nonatomic) NSString *orderID;
@property (copy, nonatomic) NSString *orderName;
@property (copy, nonatomic) NSString *orderSex;
@property (copy, nonatomic) NSString *orderTamp;
@property (copy, nonatomic) NSString *orderTel;
@property (copy, nonatomic) NSString *orderTime;
@property (copy, nonatomic) NSString *peoNum;
@property (copy, nonatomic) NSString *price;
@property (copy, nonatomic) NSString *source;
@property (copy, nonatomic) NSString *status;
@property (copy, nonatomic) NSString *storeID;
@property (copy, nonatomic) NSString *storeName;
@property (copy, nonatomic) NSString *storeTel;
@property (copy, nonatomic) NSString *tableID;
@property (copy, nonatomic) NSString *tableInfo;
@property (copy, nonatomic) NSString *userID;
@property (copy, nonatomic) NSString *userName;

-(void)setOrderByUserWithUsername:(NSString *)username andType:(NSString *)type;
-(void)setPropertysWithDictionary:(NSDictionary *)dictionary;


@end
