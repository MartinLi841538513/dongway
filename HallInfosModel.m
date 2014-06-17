//
//  HallInfosModel.m
//  Account
//
//  Created by wang zhe on 9/3/13.
//
//

#import "HallInfosModel.h"
#import "InteractWithServerOnJSON.h"
#import "API.h"

@implementation HallInfosModel

-(void)setHallInfosWithStoreID:(NSString *)storeID andIsNoon:(NSString *)isNoon andOrderTime:(NSString *)orderTime
{

    NSString *url = [NSString stringWithFormat:GET_HALL_URL, storeID,isNoon,orderTime];
    NSDictionary *dictionary = [InteractWithServerOnJSON interactWithServerOnJSON:url];
    self.hallInfos = [dictionary objectForKey:@"hallInfos"];

}

-(void)setPropertysWithDictionary:(NSDictionary *)dictionary
{

    self.TMaxPeoNum = [dictionary valueForKey:@"TMaxPeoNum"];
    self.TMinPeoNum = [dictionary valueForKey:@"TMinPeoNum"];
    self.TPeoNum = [dictionary valueForKey:@"TPeoNum"];
    self.TV = [dictionary valueForKey:@"TV"];
    self.hallID = [dictionary valueForKey:@"hallID"];
    self.hallName = [dictionary valueForKey:@"hallName"];
    self.lastUpdateTime = [dictionary valueForKey:@"lastUpdateTime"];
    self.maxPeoNum = [dictionary valueForKey:@"maxPeoNum"];
    self.note = [dictionary valueForKey:@"note"];
    self.peoNum = [dictionary valueForKey:@"peoNum"];
    self.status = [dictionary valueForKey:@"status"];
    self.storeID = [dictionary valueForKey:@"storeID"];
    self.tableID = [dictionary valueForKey:@"tableID"];
    self.tableNo = [dictionary valueForKey:@"tableNo"];
    self.tableNum = [dictionary valueForKey:@"tableNum"];

}

@end
