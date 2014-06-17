//
//  FoodRaidersModel.m
//  Account
//
//  Created by wang zhe on 9/5/13.
//
//

#import "FoodRaidersModel.h"
#import "InteractWithServerOnJSON.h"
#import "API.h"

@implementation FoodRaidersModel

//美食攻略
-(void)setFoodRaiders
{
    NSString *url = [NSString stringWithFormat:GET_FOODRAIDERS_URL,@""];
    NSDictionary *dictionary = [InteractWithServerOnJSON interactWithServerOnJSON:url];
    self.foodRaiders = [dictionary objectForKey:@"foodRaiderss"];
}

//搜索美食攻略
-(void)setSearchFoodRaidersWithSearchText:(NSString *)searchText
{
    NSString *url = [NSString stringWithFormat:Search_FOODRAIDERS_URL,searchText];
    NSDictionary *dictionary = [InteractWithServerOnJSON interactWithServerOnJSON:url];
    self.foodRaiders = [dictionary objectForKey:@"foodRaiderss"];
}

//美食攻略收藏
-(void)setCollectedFoodRaidersWithUsername:(NSString *)username
{
    NSString *url = [NSString stringWithFormat:GET_FRCOLLECTION_USER_URL, username];
    NSDictionary *dictionary = [InteractWithServerOnJSON interactWithServerOnJSON:url];
    self.foodRaiders = [dictionary objectForKey:@"foodRaiderss"];
}

-(void)setPropertysWithDictionary:(NSDictionary *)dictionary
{
    self.ID = [dictionary valueForKey:@"ID"];
    self.adminID = [dictionary valueForKey:@"adminID"];
    self.createTime = [dictionary valueForKey:@"createTime"];
    self.foodAbstract = [dictionary valueForKey:@"foodAbstract"];
    self.foodDetailID = [dictionary valueForKey:@"foodDetailID"];
    self.imageUrl = [dictionary valueForKey:@"imageUrl"];
    self.linkUrl = [dictionary valueForKey:@"linkUrl"];
    self.source = [dictionary valueForKey:@"source"];
    self.status = [dictionary valueForKey:@"status"];
    self.tag = [dictionary valueForKey:@"tag"];
    self.tid = [dictionary valueForKey:@"tid"];
    self.title = [dictionary valueForKey:@"title"];
    self.totalComment = [dictionary valueForKey:@"totalComment"];
    self.totalWatch = [dictionary valueForKey:@"totalWatch"];
    self.typeID = [dictionary valueForKey:@"typeID"];
    self.typeName = [dictionary valueForKey:@"typeName"];
}

@end
