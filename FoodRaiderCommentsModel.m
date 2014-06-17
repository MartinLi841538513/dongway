//
//  FoodRaiderCommentsModel.m
//  Account
//
//  Created by wang zhe on 9/5/13.
//
//

#import "FoodRaiderCommentsModel.h"
#import "InteractWithServerOnJSON.h"
#import "API.h"

@implementation FoodRaiderCommentsModel


-(void)setFoodRaiderCommentsWithFoodRaiderID:(NSString *)foodRaiderID
{
    NSString *url = [NSString stringWithFormat:GET_FRCOMMENT_URL,foodRaiderID];
    NSDictionary *dictionary = [InteractWithServerOnJSON interactWithServerOnJSON:url];
    self.foodRaidersComments = [dictionary objectForKey:@"foodRaidersComments"];
}

-(void)setPropertysWithDictionary:(NSDictionary *)dictionary
{
    self.ID = [dictionary valueForKey:@"ID"];
    self.commentID = [dictionary valueForKey:@"commentID"];
    self.commentInfo = [dictionary valueForKey:@"commentInfo"];
    self.createTime = [dictionary valueForKey:@"createTime"];
    self.foodDetailID = [dictionary valueForKey:@"foodDetailID"];
    self.parentID = [dictionary valueForKey:@"parentID"];
    self.userID = [dictionary valueForKey:@"userID"];
    self.userName = [dictionary valueForKey:@"userName"];
}


@end
