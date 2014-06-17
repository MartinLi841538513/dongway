//
//  IndexDatasModel.h
//  Account
//
//  Created by dongway on 13-11-15.
//
//

#import <Foundation/Foundation.h>

@interface IndexDatasModel : NSObject

@property (copy, nonatomic) NSArray *IndexDatas;

@property (copy, nonatomic) NSString *ID;
@property (copy, nonatomic) NSString *activityPeople;
@property (copy, nonatomic) NSString *activityPlace;
@property (copy, nonatomic) NSString *alt;
@property (copy, nonatomic) NSString *bid;
@property (copy, nonatomic) NSString *bookPeople;
@property (copy, nonatomic) NSString *clickPeople;
@property (copy, nonatomic) NSString *content;
@property (copy, nonatomic) NSString *createTime;
@property (copy, nonatomic) NSString *picUrl;
@property (copy, nonatomic) NSString *storeName;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *type;
@property (copy, nonatomic) NSString *url;

-(void)setIndexDatasWithBid:(NSString *)bid;

-(void)setPropertysWithDictionary:(NSDictionary *)dictionary;

@end
