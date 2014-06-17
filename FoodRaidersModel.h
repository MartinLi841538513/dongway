//
//  FoodRaidersModel.h
//  Account
//
//  Created by wang zhe on 9/5/13.
//
//

#import <Foundation/Foundation.h>

@interface FoodRaidersModel : NSObject

@property (copy, nonatomic) NSArray *foodRaiders;

@property (copy, nonatomic) NSString *ID;
@property (copy, nonatomic) NSString *adminID;
@property (copy, nonatomic) NSString *createTime;
@property (copy, nonatomic) NSString *foodAbstract;
@property (copy, nonatomic) NSString *foodDetailID;
@property (copy, nonatomic) NSString *imageUrl;
@property (copy, nonatomic) NSString *linkUrl;
@property (copy, nonatomic) NSString *source;
@property (copy, nonatomic) NSString *status;
@property (copy, nonatomic) NSString *tag;
@property (copy, nonatomic) NSString *tid;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *totalComment;
@property (copy, nonatomic) NSString *totalWatch;
@property (copy, nonatomic) NSString *typeID;
@property (copy, nonatomic) NSString *typeName;

//美食攻略
-(void)setFoodRaiders;

//美食攻略搜索
-(void)setSearchFoodRaidersWithSearchText:(NSString *)searchText;
//美食攻略详情
//-(void)setFoodRaiderDetailWithFoodRaiderID:(NSString *)foodRaiderID;
//美食攻略收藏
-(void)setCollectedFoodRaidersWithUsername:(NSString *)username;
-(void)setPropertysWithDictionary:(NSDictionary *)dictionary;

@end
