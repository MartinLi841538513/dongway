//
//  HallInfosModel.h
//  Account
//
//  Created by wang zhe on 9/3/13.
//
//

#import <Foundation/Foundation.h>

@interface HallInfosModel : NSObject

@property (copy, nonatomic) NSArray *hallInfos;

@property (copy, nonatomic) NSString *TMaxPeoNum;
@property (copy, nonatomic) NSString *TMinPeoNum;
@property (copy, nonatomic) NSString *TPeoNum;
@property (copy, nonatomic) NSString *TV;
@property (copy, nonatomic) NSString *hallID;
@property (copy, nonatomic) NSString *hallName;
@property (copy, nonatomic) NSString *lastUpdateTime;
@property (copy, nonatomic) NSString *maxPeoNum;
@property (copy, nonatomic) NSString *note;
@property (copy, nonatomic) NSString *peoNum;
@property (copy, nonatomic) NSString *status;
@property (copy, nonatomic) NSString *storeID;
@property (copy, nonatomic) NSString *tableID;
@property (copy, nonatomic) NSString *tableNo;
@property (copy, nonatomic) NSString *tableNum;

-(void)setHallInfosWithStoreID:(NSString *)storeID andIsNoon:(NSString *)isNoon andOrderTime:(NSString *)orderTime;

-(void)setPropertysWithDictionary:(NSDictionary *)dictionary;

@end
