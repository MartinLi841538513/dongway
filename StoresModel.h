//
//  StoresModel.h
//  Account
//
//  Created by wang zhe on 9/4/13.
//
//

#import <Foundation/Foundation.h>

@interface StoresModel : NSObject

@property (copy, nonatomic) NSArray *stores;
@property (copy, nonatomic) NSString *accuracy;
@property (copy, nonatomic) NSString *address;
@property (copy, nonatomic) NSString *area;
@property (copy, nonatomic) NSString *busStation;
@property (copy, nonatomic) NSString *busTrips;
@property (copy, nonatomic) NSString *cellphone;
@property (copy, nonatomic) NSString *city;
@property (copy, nonatomic) NSString *commentUrl;
@property (copy, nonatomic) NSString *description;
@property (copy, nonatomic) NSString *distance;
@property (copy, nonatomic) NSString *environment;
@property (copy, nonatomic) NSString *imageUrl;
@property (copy, nonatomic) NSString *introduction;
@property (copy, nonatomic) NSString *lastUpdateTime;
@property (copy, nonatomic) NSString *latitude;
@property (copy, nonatomic) NSString *longtitude;
@property (copy, nonatomic) NSString *number;
@property (copy, nonatomic) NSString *price;
@property (copy, nonatomic) NSString *province;
@property (copy, nonatomic) NSString *recommend;
@property (copy, nonatomic) NSString *score;
@property (copy, nonatomic) NSString *service;
@property (copy, nonatomic) NSString *status;
@property (copy, nonatomic) NSString *storeId;
@property (copy, nonatomic) NSString *storeName;
@property (copy, nonatomic) NSString *street;
@property (copy, nonatomic) NSString *taste;
@property (copy, nonatomic) NSString *telephone;

-(void)setStoresWithCat:(NSString *)cat andLatitude:(NSString *)latitude andLongitude:(NSString *)longitude andRadius:(NSString *)radius andSort:(NSString *)sort andPage:(NSString *)page andPrice:(NSString *)price andTerm:(NSString *)term;

-(void)setRecommendedStoresWithCat:(NSString *)cat andLatitude:(NSString *)latitude andLongitude:(NSString *)longitude andRadius:(NSString *)radius andSort:(NSString *)sort andPage:(NSString *)page andPrice:(NSString *)price;

//收藏商家
-(void)addStoreCollectionWithStoreID:(NSString *)storeID andUsername:(NSString *)userName;

//我的商家收藏
-(void)setStoresWithUsername:(NSString *)username;

//删除收藏商家
-(void)deleteCollectedStoreWithStoreID:(NSString *)storeID andUsername:(NSString *)username;

-(void)setPropertysWithDictionary:(NSDictionary *)dictionary;

-(void)setStoreWithStoreID:(NSString *)storeID;
@end
