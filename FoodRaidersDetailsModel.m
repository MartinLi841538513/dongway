//
//  FoodRaidersDetailsModel.m
//  Account
//
//  Created by wang zhe on 9/5/13.
//
//

#import "FoodRaidersDetailsModel.h"
#import "InteractWithServerOnJSON.h"
#import "API.h"

@implementation FoodRaidersDetailsModel

//美食攻略详情
-(void)setFoodRaiderDetailWithFoodRaiderID:(NSString *)foodRaiderID
{

    NSString *url = [NSString stringWithFormat:GET_FRDETAIL_URL,foodRaiderID];
    NSDictionary *dictionary = [InteractWithServerOnJSON interactWithServerOnJSON:url];
    self.foodRaidersDetails = [dictionary objectForKey:@"foodRaidersDetails"];
}

-(void)setPropertysWithDictionary:(NSDictionary *)dictionary
{
    self.ID = [dictionary valueForKey:@"ID"];
    self.adminID = [dictionary valueForKey:@"adminID"];
    self.content = [dictionary valueForKey:@"content"];
    self.createTime = [dictionary valueForKey:@"createTime"];
    self.source = [dictionary valueForKey:@"source"];
    self.status = [dictionary valueForKey:@"status"];
    self.title = [dictionary valueForKey:@"title"];
}


@end
