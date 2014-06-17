//
//  OrderInfosModel.m
//  Account
//
//  Created by wang zhe on 9/4/13.
//
//

#import "OrderInfosModel.h"
#import "InteractWithServerOnJSON.h"
#import "API.h"

@implementation OrderInfosModel
-(void)setOrderByUserWithUsername:(NSString *)username andType:(NSString *)type
{
    NSString *url = [NSString stringWithFormat:GET_ORDERINFO_URL, username, type];
    NSDictionary *dictionary = [InteractWithServerOnJSON interactWithServerOnJSON:url];
    self.orderInfos = [dictionary objectForKey:@"orderInfos"];
}

-(void)setPropertysWithDictionary:(NSDictionary *)dictionary
{
    self.address = [dictionary valueForKey:@"address"];
    self.createTime = [dictionary valueForKey:@"createTime"];
    self.customerID = [dictionary valueForKey:@"customerID"];
    self.isNoon = [dictionary valueForKey:@"isNoon"];
    self.isSync = [dictionary valueForKey:@"isSync"];
    self.isTel = [dictionary valueForKey:@"isTel"];
    self.lastUpdateTime = [dictionary valueForKey:@"lastUpdateTime"];
    self.md5ID = [dictionary valueForKey:@"md5ID"];
    self.note = [dictionary valueForKey:@"note"];
    self.orderID = [dictionary valueForKey:@"orderID"];
    self.orderName = [dictionary valueForKey:@"orderName"];
    self.orderSex = [dictionary valueForKey:@"orderSex"];
    self.orderTamp = [dictionary valueForKey:@"orderTamp"];
    self.orderTel = [dictionary valueForKey:@"orderTel"];
    self.orderTime = [dictionary valueForKey:@"orderTime"];
    self.peoNum = [dictionary valueForKey:@"peoNum"];
    self.price = [dictionary valueForKey:@"price"];
    self.source = [dictionary valueForKey:@"source"];
    self.status = [dictionary valueForKey:@"status"];
    self.storeID = [dictionary valueForKey:@"storeID"];
    self.storeName = [dictionary valueForKey:@"storeName"];
    self.storeTel = [dictionary valueForKey:@"storeTel"];
    self.tableID = [dictionary valueForKey:@"tableID"];
    self.tableInfo = [dictionary valueForKey:@"tableInfo"];
    self.userID = [dictionary valueForKey:@"userID"];
    self.userName = [dictionary valueForKey:@"userName"];

}

@end
