//
//  FoodRaidersDetailsModel.h
//  Account
//
//  Created by wang zhe on 9/5/13.
//
//

#import <Foundation/Foundation.h>

@interface FoodRaidersDetailsModel : NSObject

@property (copy, nonatomic) NSArray *foodRaidersDetails;

@property (copy, nonatomic) NSString *ID;
@property (copy, nonatomic) NSString *adminID;
@property (copy, nonatomic) NSString *content;
@property (copy, nonatomic) NSString *createTime;
@property (copy, nonatomic) NSString *source;
@property (copy, nonatomic) NSString *status;
@property (copy, nonatomic) NSString *title;

//美食攻略详情
-(void)setFoodRaiderDetailWithFoodRaiderID:(NSString *)foodRaiderID;

-(void)setPropertysWithDictionary:(NSDictionary *)dictionary;


@end
