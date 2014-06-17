//
//  AllCouponStore.m
//  Account
//
//  Created by wang zhe on 9/3/13.
//
//

#import "DiscountInfosModel.h"
#import "InteractWithServerOnJSON.h"
#import "API.h"

@implementation DiscountInfosModel

//很多优惠商家
- (void)setDiscountInfosWithPageNumber:(NSString *)pageNumber andStoreID:(NSString *)storeID
{
    NSString *url = [NSString stringWithFormat:Get_Discount_Info_Url, pageNumber, storeID];
    NSDictionary *dictionary = [InteractWithServerOnJSON interactWithServerOnJSON:url];
    self.discountInfoArray = [dictionary objectForKey:@"discountInfos"];
}

//下载某个优惠商家的优惠券
-(void)setDownloadDiscountInfosWithUsername:(NSString *)userName andDiscountCode:(NSString *)discountCode andDiscountID:(NSString *)discountID andStoreID:(NSString *)storeID
{
    NSString *url = [NSString stringWithFormat:Get_Discount_Ticket, userName, discountCode,discountID,storeID];
    NSDictionary *dictionary = [InteractWithServerOnJSON interactWithServerOnJSON:url];
    self.discountInfoArray = [dictionary objectForKey:@"discountInfos"];
}

//我的优惠券
-(void)setUserDiscountsWithUsername:(NSString *)username
{
    NSString *url = [NSString stringWithFormat:Get_User_Discount_Ticket, username];
    NSDictionary *dictionary = [InteractWithServerOnJSON interactWithServerOnJSON:url];
    self.discountInfoArray = [dictionary objectForKey:@"discountInfos"];
}

//删除优惠券
-(void)deleteUserDiscountWithUsername:(NSString *)username andDiscountCode:(NSString *)discountCode
{
    NSString *url = [NSString stringWithFormat:Del_User_Discount_Ticket, username, discountCode];
    NSDictionary *dictionary = [InteractWithServerOnJSON interactWithServerOnJSON:url];
    self.discountInfoArray = [dictionary objectForKey:@"discountInfos"];
}

//通过storeID得到优惠商家的优惠信息
-(void)setDiscountStoreInfosWithStoreID:(NSString *)storeID
{
    NSString *url = [NSString stringWithFormat:DiscountStoreInfo_FromStoreID_URL,storeID];
    NSDictionary *dictionary = [InteractWithServerOnJSON interactWithServerOnJSON:url];
    self.discountInfoArray = [dictionary objectForKey:@"discountInfos"];
}


-(void)setPropertysWithDictionary:(NSDictionary *)dictionary
{
    self.ID = [dictionary valueForKey:@"ID"];
    self.address = [dictionary valueForKey:@"address"];
    self.bus = [dictionary valueForKey:@"bus"];
    self.content = [dictionary valueForKey:@"content"];
    self.discount = [dictionary valueForKey:@"discount"];
    self.discountCode = [dictionary valueForKey:@"discountCode"];
    self.discountID = [dictionary valueForKey:@"discountID"];
    self.endTime = [dictionary valueForKey:@"endTime"];
    self.picUrl = [dictionary valueForKey:@"picUrl"];
    self.price = [dictionary valueForKey:@"price"];
    self.state = [dictionary valueForKey:@"state"];
    self.storeID = [dictionary valueForKey:@"storeID"];
    self.storeName = [dictionary valueForKey:@"storeName"];
    self.tel = [dictionary valueForKey:@"tel"];
    self.url = [dictionary valueForKey:@"url"];
    self.webName = [dictionary valueForKey:@"webName"];
}

@end
