//
//  RoomInfosModel.m
//  Account
//
//  Created by wang zhe on 9/3/13.
//
//

#import "RoomInfosModel.h"
#import "InteractWithServerOnJSON.h"
#import "API.h"


@implementation RoomInfosModel

-(void)setRoomInfosWithStoreID:(NSString *)storeID andIsNoon:(NSString *)isNoon andOrderTime:(NSString *)orderTime
{
    
    NSString *url = [NSString stringWithFormat:GET_ROOM_URL, storeID,isNoon,orderTime];
    NSDictionary *dictionary = [InteractWithServerOnJSON interactWithServerOnJSON:url];
    self.roomInfos = [dictionary objectForKey:@"roomInfos"];
    
}

-(void)setPropertysWithDictionary:(NSDictionary *)dictionary
{
    self.TMaxPeoNum = [dictionary valueForKey:@"TMaxPeoNum"];
    self.TMinPeoNum = [dictionary valueForKey:@"TMinPeoNum"];
    self.TPeoNum = [dictionary valueForKey:@"TPeoNum"];
    self.TV = [dictionary valueForKey:@"TV"];
    self.WC = [dictionary valueForKey:@"WC"];
    self.airConditioner = [dictionary valueForKey:@"airConditioner"];
    self.lastUpdateTime = [dictionary valueForKey:@"lastUpdateTime"];
    self.maxPeoNum = [dictionary valueForKey:@"maxPeoNum"];
    self.minPeoNum = [dictionary valueForKey:@"minPeoNum"];
    self.minPrice = [dictionary valueForKey:@"minPrice"];
    self.note = [dictionary valueForKey:@"note"];
    self.peoNum = [dictionary valueForKey:@"peoNum"];
    self.roomID = [dictionary valueForKey:@"roomID"];
    self.roomName = [dictionary valueForKey:@"roomName"];
    self.roomNum = [dictionary valueForKey:@"roomNum"];
    self.serviceNo = [dictionary valueForKey:@"serviceNo"];
    self.status = [dictionary valueForKey:@"status"];
    self.storeID = [dictionary valueForKey:@"storeID"];
    self.tableID = [dictionary valueForKey:@"tableID"];
    self.tableNo = [dictionary valueForKey:@"tableNo"];    
}

@end
