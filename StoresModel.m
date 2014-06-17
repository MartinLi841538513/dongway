//
//  StoresModel.m
//  Account
//
//  Created by wang zhe on 9/4/13.
//
//

#import "StoresModel.h"
#import "InteractWithServerOnJSON.h"
#import "API.h"

@implementation StoresModel

-(void)setStoresWithCat:(NSString *)cat andLatitude:(NSString *)latitude andLongitude:(NSString *)longitude andRadius:(NSString *)radius andSort:(NSString *)sort andPage:(NSString *)page andPrice:(NSString *)price andTerm:(NSString *)term
{
    NSString *url = [NSString stringWithFormat:Get_Store_URL, cat, latitude, longitude, radius, sort,page, price, term];
    NSDictionary *dictionary = [InteractWithServerOnJSON interactWithServerOnJSON:url];
    self.stores = [dictionary objectForKey:@"stores"];
}

-(void)setRecommendedStoresWithCat:(NSString *)cat andLatitude:(NSString *)latitude andLongitude:(NSString *)longitude andRadius:(NSString *)radius andSort:(NSString *)sort andPage:(NSString *)page andPrice:(NSString *)price
{
    NSString *url = [NSString stringWithFormat:Get_Recommend_Store, cat, latitude, longitude, radius, sort,page, price];
    NSDictionary *dictionary = [InteractWithServerOnJSON interactWithServerOnJSON:url];
    self.stores = [dictionary objectForKey:@"stores"];
}

//收藏商家
-(void)addStoreCollectionWithStoreID:(NSString *)storeID andUsername:(NSString *)userName
{
    NSString *url = [NSString stringWithFormat:ADD_StoreCollection_URL, storeID,userName];
    NSDictionary *dictionary = [InteractWithServerOnJSON interactWithServerOnJSON:url];
    self.stores = [dictionary objectForKey:@"stores"];
}

//我的商家收藏
-(void)setStoresWithUsername:(NSString *)username
{
    NSString *url = [NSString stringWithFormat:Get_Favorite_URL,username];
    NSDictionary *dictionary = [InteractWithServerOnJSON interactWithServerOnJSON:url];
    self.stores = [dictionary objectForKey:@"stores"];
}


//删除收藏的商家
-(void)deleteCollectedStoreWithStoreID:(NSString *)storeID andUsername:(NSString *)username
{
    
    NSString *url = [NSString stringWithFormat:DEL_Favorite_URL,storeID,username];
    NSDictionary *dictionary = [InteractWithServerOnJSON interactWithServerOnJSON:url];
    self.stores = [dictionary objectForKey:@"stores"];
}

//通过storeID找到StoreInformation
-(void)setStoreWithStoreID:(NSString *)storeID
{
    
    NSString *url = [NSString stringWithFormat:StoreInfo_FromStoreID_URL,storeID];
    NSDictionary *dictionary = [InteractWithServerOnJSON interactWithServerOnJSON:url];
    self.stores = [dictionary objectForKey:@"stores"];
}

-(void)setPropertysWithDictionary:(NSDictionary *)dictionary
{
    self.accuracy = [dictionary valueForKey:@"accuracy"];
    self.address = [dictionary valueForKey:@"address"];
    self.area = [dictionary valueForKey:@"area"];
    self.busStation = [dictionary valueForKey:@"busStation"];
    self.busTrips = [dictionary valueForKey:@"busTrips"];
    self.cellphone = [dictionary valueForKey:@"cellphone"];
    self.city = [dictionary valueForKey:@"city"];
    self.commentUrl = [dictionary valueForKey:@"commentUrl"];
    self.description = [dictionary valueForKey:@"description"];
    self.distance = [dictionary valueForKey:@"distance"];
    self.environment = [dictionary valueForKey:@"environment"];
    self.imageUrl = [dictionary valueForKey:@"imageUrl"];
    self.introduction = [dictionary valueForKey:@"introduction"];
    self.lastUpdateTime = [dictionary valueForKey:@"lastUpdateTime"];
    self.latitude = [dictionary valueForKey:@"latitude"];
    self.longtitude = [dictionary valueForKey:@"longtitude"];
    self.number = [dictionary valueForKey:@"number"];
    self.price = [dictionary valueForKey:@"price"];
    self.province = [dictionary valueForKey:@"province"];
    self.recommend = [dictionary valueForKey:@"recommend"];
    self.score = [dictionary valueForKey:@"score"];
    self.service = [dictionary valueForKey:@"service"];
    self.status = [dictionary valueForKey:@"status"];
    self.storeId = [dictionary valueForKey:@"storeId"];
    self.storeName = [dictionary valueForKey:@"storeName"];
    self.street = [dictionary valueForKey:@"street"];
    self.taste = [dictionary valueForKey:@"taste"];
    self.telephone = [dictionary valueForKey:@"telephone"];
}

@end
