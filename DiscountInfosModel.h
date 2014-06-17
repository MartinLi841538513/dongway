//
//  AllCouponStore.h
//  Account
//
//  Created by wang zhe on 9/3/13.
//
//

#import <Foundation/Foundation.h>

@interface DiscountInfosModel : NSObject

@property (copy, nonatomic) NSArray *discountInfoArray;
@property (copy, nonatomic) NSString *ID;
@property (copy, nonatomic) NSString *address;
@property (copy, nonatomic) NSString *bus;
@property (copy, nonatomic) NSString *content;
@property (copy, nonatomic) NSString *discount;
@property (copy, nonatomic) NSString *discountCode;
@property (copy, nonatomic) NSString *discountID;
@property (copy, nonatomic) NSString *endTime;
@property (copy, nonatomic) NSString *picUrl;
@property (copy, nonatomic) NSString *price;
@property (copy, nonatomic) NSString *state;
@property (copy, nonatomic) NSString *storeID;
@property (copy, nonatomic) NSString *storeName;
@property (copy, nonatomic) NSString *tel;
@property (copy, nonatomic) NSString *url;
@property (copy, nonatomic) NSString *webName;

//很多优惠商家
-(void)setDiscountInfosWithPageNumber:(NSString *)pageNumber andStoreID:(NSString *)storeID;
//下载某个优惠商家的优惠券
-(void)setDownloadDiscountInfosWithUsername:(NSString *)userName andDiscountCode:(NSString *)discountCode andDiscountID:(NSString *)discountID andStoreID:(NSString *)storeID;
//我的优惠券
-(void)setUserDiscountsWithUsername:(NSString *)username;
//删除我的优惠券
-(void)deleteUserDiscountWithUsername:(NSString *)username andDiscountCode:(NSString *)discountCode;
-(void)setPropertysWithDictionary:(NSDictionary *)Dictionary;

-(void)setDiscountStoreInfosWithStoreID:(NSString *)storeID;

@end
