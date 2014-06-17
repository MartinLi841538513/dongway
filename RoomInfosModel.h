//
//  RoomInfosModel.h
//  Account
//
//  Created by wang zhe on 9/3/13.
//
//

#import <Foundation/Foundation.h>

@interface RoomInfosModel : NSObject

@property (copy, nonatomic) NSArray *roomInfos;

@property (copy, nonatomic) NSString *TMaxPeoNum;
@property (copy, nonatomic) NSString *TMinPeoNum;
@property (copy, nonatomic) NSString *TPeoNum;
@property (copy, nonatomic) NSString *TV;
@property (copy, nonatomic) NSString *WC;
@property (copy, nonatomic) NSString *airConditioner;
@property (copy, nonatomic) NSString *lastUpdateTime;
@property (copy, nonatomic) NSString *maxPeoNum;
@property (copy, nonatomic) NSString *minPeoNum;
@property (copy, nonatomic) NSString *minPrice;
@property (copy, nonatomic) NSString *note;
@property (copy, nonatomic) NSString *peoNum;
@property (copy, nonatomic) NSString *roomID;
@property (copy, nonatomic) NSString *roomName;
@property (copy, nonatomic) NSString *roomNum;
@property (copy, nonatomic) NSString *serviceNo;
@property (copy, nonatomic) NSString *status;
@property (copy, nonatomic) NSString *storeID;
@property (copy, nonatomic) NSString *tableID;
@property (copy, nonatomic) NSString *tableNo;

-(void)setRoomInfosWithStoreID:(NSString *)storeID andIsNoon:(NSString *)isNoon andOrderTime:(NSString *)orderTime;

-(void)setPropertysWithDictionary:(NSDictionary *)discountInfoDictionary;


@end
