//
//  FoodRaiderCommentsModel.h
//  Account
//
//  Created by wang zhe on 9/5/13.
//
//

#import <Foundation/Foundation.h>

@interface FoodRaiderCommentsModel : NSObject

@property (copy, nonatomic) NSArray *foodRaidersComments;

@property (copy, nonatomic) NSString *ID;
@property (copy, nonatomic) NSString *commentID;
@property (copy, nonatomic) NSString *commentInfo;
@property (copy, nonatomic) NSString *createTime;
@property (copy, nonatomic) NSString *foodDetailID;
@property (copy, nonatomic) NSString *parentID;
@property (copy, nonatomic) NSString *userID;
@property (copy, nonatomic) NSString *userName;


-(void)setFoodRaiderCommentsWithFoodRaiderID:(NSString *)foodRaiderID;

-(void)setPropertysWithDictionary:(NSDictionary *)dictionary;



@end
